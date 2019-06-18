//
//  ASHDetectStore.m
//  AHSBasic
//
//  Created by sam on 2019/5/31.
//  Copyright © 2019 sam. All rights reserved.
//
#import "AHSActionReducer.h"
#import "AHSDetectStore.h"



@interface AHSDetectStore()
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableDictionary <NSString*, NSMutableArray  <AHSActionReducer *> *> *> *store;
@end

@implementation AHSDetectStore
+ (instancetype)store {
    static AHSDetectStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[AHSDetectStore alloc] init];
    });
    return store;
}

- (instancetype)init {
    if (self = [super init]) {
        self.store = @{}.mutableCopy;
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil] subscribeNext:^(id x) {
            [self.store enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull scope, NSMutableDictionary<NSString *,NSMutableArray<AHSActionReducer *> *> * _Nonnull firstMap, BOOL * _Nonnull stop) {
                [firstMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull url, NSMutableArray<AHSActionReducer *> * _Nonnull reducers, BOOL * _Nonnull stop) {
                    [reducers enumerateObjectsUsingBlock:^(AHSActionReducer * _Nonnull reducer, NSUInteger idx, BOOL * _Nonnull stop) {
                        [reducer startWith:url];
                    }];
                }];
            }];
        }];
    }
    return self;
}
- (void)registReducer:(AHSActionReducer *)reducer ForUrl:(NSString *)url inScope:(NSString *)scope {
    if (!self.store[scope]) self.store[scope] = @{}.mutableCopy;
    if (!self.store[scope][url]) self.store[scope][url] = @[].mutableCopy;
    
    if (![self.store[scope][url] containsObject:reducer]) {
        [self.store[scope][url] addObject:reducer];
    }
}

- (void)handleUrl:(NSString *)url inScope:(NSString *)scope requestAction:(AHSRequestAction *)action {
    NSArray *reducers = self.store[scope][url];
    if (!reducers) return;
    [reducers enumerateObjectsUsingBlock:^(AHSActionReducer *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj handleUrl:url requestAction:action];
    }];
}
@end
