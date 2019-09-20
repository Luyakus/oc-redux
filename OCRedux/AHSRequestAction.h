//
//  AHSRequestAction.h
//  AHSBasic
//
//  Created by sam on 2019/5/31.
//  Copyright © 2019 sam. All rights reserved.
//

#import "AHSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AHSRequestAction : AHSBaseModel
@property (nonatomic, copy  ) NSString *identifier;
@property (nonatomic, strong) id data;
@end

NS_ASSUME_NONNULL_END
