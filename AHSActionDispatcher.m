//
//  AHSActionDispatcher.m
//  AHSBasic
//
//  Created by sam on 2019/5/31.
//  Copyright © 2019 sam. All rights reserved.
//

#import "AHSActionDispatcher.h"

@interface AHSActionDispatcher()
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSPointerArray *> *recivers;
- (void)dispatchAction:(AHSDispatchAction *)action;
@end

@implementation AHSActionDispatcher

+ (instancetype)dispatcher {
    static AHSActionDispatcher *dis = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dis = [[AHSActionDispatcher alloc] init];
    });
    return dis;
}


- (instancetype)init {
    if (self = [super init]) {
        self.recivers = @{}.mutableCopy;
    }
    return self;
}
- (void)addReceiver:(id <AHSReceiveActionProtocol>)receiver forIdentifier:(NSString *)identifier {
    if (!self.recivers[identifier]) {
        self.recivers[identifier]  = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsWeakMemory];
    }
    [self.recivers[identifier] compact];
    NSArray *arr = [self.recivers[identifier] allObjects];
    if (![arr containsObject:receiver]) {
        [self.recivers[identifier] addPointer:(__bridge void * _Nullable)(receiver)];
    }
}

- (void)dispatchAction:(AHSDispatchAction *)action {
    if (!self.recivers[action.identifier]) return;
    [self.recivers[action.identifier] compact];
    NSArray *arr = [self.recivers[action.identifier] allObjects];
    for (id <AHSReceiveActionProtocol> receiver in arr) {
        NSAssert([receiver respondsToSelector:@selector(handleAction:)], action.identifier, receiver, @"not handle");
        [receiver handleAction:action];
    }
}


@end

void ahs_redux_dispatch(AHSDispatchAction *action) {
    [[AHSActionDispatcher dispatcher] dispatchAction:action];
}

