//
//  AHSBaseViewController+Redux.h
//  AHSBasic
//
//  Created by sam on 2019/5/31.
//  Copyright © 2019 sam. All rights reserved.
//

#import "AHSBaseModel.h"
#import "AHSActionDispatcher.h"
#import "AHSRequestAction.h"
NS_ASSUME_NONNULL_BEGIN


@interface NSObject(Redux) <AHSReceiveActionProtocol>
// 自己发送的 requestAction 的回调是一定可以收到的, 如果想收到别的回调, 需要手动添加
// 如果只发送一个 request 可以不用写 id, 如果有多个则一定要写 id

- (void)requestForUrl:(NSString *)url action:(AHSRequestAction *)action;
- (void)requestForUrl:(NSString *)url action:(AHSRequestAction *)action inScope:(NSString *)scope;

- (void)registToReceiveActionForIdentifier:(NSString *)identifier;

// 子类 overwrite
- (NSString *)defaultRequestActionIdentifier;
@end

NS_ASSUME_NONNULL_END
