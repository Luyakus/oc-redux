//
//  AHSLogReducer.m
//  OCReduxDemo
//
//  Created by sam on 2019/9/20.
//  Copyright © 2019 sam. All rights reserved.
//

#import "AHSLogReducer.h"

@implementation AHSLogReducer
+ (void)load {
    AHSLogReducer *reducer = [AHSLogReducer new];
    [reducer registForUrl:@"ahs://nouserInterfaceinteraction"];
    [reducer registToReceiveActionForIdentifier:@"log_data"];
}

- (void)handleAction:(AHSDispatchDataAction *)action {
    if ([action isKindOfClass:[AHSDispatchDataAction class]]) {
        NSLog(@"log is %@", action.data);
    }
}
@end
