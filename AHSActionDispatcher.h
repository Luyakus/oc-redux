//
//  AHSActionDispatcher.h
//  AHSBasic
//
//  Created by sam on 2019/5/31.
//  Copyright © 2019 sam. All rights reserved.
//

#import "AHSBaseModel.h"
#import "AHSDispatchAction.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AHSReceiveActionProtocol <NSObject>
- (void)handleAction:(AHSDispatchAction *)action;
@end

extern void ahs_redux_dispatch(AHSDispatchAction *action);

@interface AHSActionDispatcher : AHSBaseModel
+ (instancetype)dispatcher;
@end

NS_ASSUME_NONNULL_END
