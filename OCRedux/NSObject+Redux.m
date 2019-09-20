//
//  AHSBaseViewController+Redux.m
//  AHSBasic
//
//  Created by sam on 2019/5/31.
//  Copyright © 2019 sam. All rights reserved.
//

#import "NSObject+Redux.h"
#import "AHSRequestAction.h"
#import "AHSActionDispatcher.h"
#import "AHSDetectStore.h"
#import "AHSDetectStore+Private.h"

NSString *ahs_default_scope = @"ahs_app";
@interface AHSActionDispatcher ()
- (void)addReceiver:(id <AHSReceiveActionProtocol>)receiver forIdentifier:(NSString *)identifier;
@end

@implementation NSObject (Redux)
- (void)requestForUrl:(NSString *)url action:(AHSRequestAction *)action inScope:(NSString *)scope {
    if (!action.identifier) action.identifier = [self defaultRequestActionIdentifier];
    [[AHSActionDispatcher dispatcher] addReceiver:self forIdentifier:action.identifier];
    [[AHSDetectStore store] handleUrl:url requestAction:action inScope:scope];
}

- (void)requestForUrl:(NSString *)url action:(AHSRequestAction *)action {
    [self requestForUrl:url action:action inScope:ahs_default_scope];
}


- (void)registToReceiveActionForIdentifier:(NSString *)identifier {
    [[AHSActionDispatcher dispatcher] addReceiver:self forIdentifier:identifier];
}

- (void)handleAction:(AHSDispatchAction *)action {
    
}

- (NSString *)defaultRequestActionIdentifier {
    return NSStringFromClass([self class]);
}
@end
