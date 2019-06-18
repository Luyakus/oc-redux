//
//  AHSActionReducer.h
//  AHSBasic
//
//  Created by sam on 2019/5/31.
//  Copyright © 2019 sam. All rights reserved.
//

#import "AHSBaseModel.h"
#import "AHSRequestAction.h"
NS_ASSUME_NONNULL_BEGIN

@interface AHSActionReducer : AHSBaseModel

// 在 + (void)load 方法中注册
- (void)registForUrl:(NSString *)url inScope:(NSString *)scope;

// 子类 overwrite
- (void)handleUrl:(NSString *)url requestAction:(AHSRequestAction *)action;

- (void)startWith:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
