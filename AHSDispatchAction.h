//
//  AHSDispatchAction.h
//  AHSBasic
//
//  Created by sam on 2019/5/31.
//  Copyright © 2019 sam. All rights reserved.
//

#import "AHSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface AHSDispatchAction : AHSBaseModel
@property (nonatomic, copy) NSString  *identifier;
@end

@interface AHSDispatchSignalAction : AHSDispatchAction
@property (nonatomic, strong) RACSignal *signal;
@end


typedef NS_ENUM(NSUInteger, AHSDispatchRouteType) {
    AHSDispatchRouteTypePush,
    AHSDispatchRouteTypePop,
    AHSDispatchRouteTypePopToRoot,
    AHSDispatchRouteTypePresent
};

@interface AHSDispatchRouteAction : AHSDispatchAction
@property (nonatomic, copy) NSString *targetClass;
@property (nonatomic, copy) NSDictionary *extras;
@property (nonatomic, assign) AHSDispatchRouteType routeType;
@end

@interface AHSDispatchDataAction : AHSDispatchAction
@property (nonatomic, strong) id data;
@end
NS_ASSUME_NONNULL_END
