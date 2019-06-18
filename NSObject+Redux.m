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


@interface AHSActionDispatcher ()
- (void)addReceiver:(id <AHSReceiveActionProtocol>)receiver forIdentifier:(NSString *)identifier;
@end

@implementation NSObject (Redux)
- (void)requestForUrl:(NSString *)url inScope:(NSString *)scope action:(AHSRequestAction *)action {
    if (!action.identifier) action.identifier = [self defaultRequestActionIdentifier];
    [[AHSActionDispatcher dispatcher] addReceiver:self forIdentifier:action.identifier];
    [[AHSDetectStore store] handleUrl:url inScope:scope requestAction:action];
}

- (void)requestForUrl:(NSString *)url action:(AHSRequestAction *)action {
    [self requestForUrl:url inScope:ahs_default_scope action:action];
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
