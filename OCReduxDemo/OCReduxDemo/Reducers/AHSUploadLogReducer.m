//
//  AHSUploadLogReducer.m
//  OCReduxDemo
//
//  Created by sam on 2019/9/20.
//  Copyright © 2019 sam. All rights reserved.
//

#import "AHSUploadLogReducer.h"
#import <YYTimer.h>
@implementation AHSUploadLogReducer
+ (void)load {
    AHSUploadLogReducer *reducer = [AHSUploadLogReducer new];
    [reducer registForUrl:@"ahs://uploadlog"];
    [reducer registForUrl:@"ahs://otherurl"];
}

- (void)handleUrl:(NSString *)url requestAction:(AHSRequestAction *)action {
    if ([url isEqualToString:@"ahs://uploadlog"]) {
        NSLog(@"上传的日志为 %@", action.data);
        AHSDispatchSignalAction *progressAction = [AHSDispatchSignalAction new];
        progressAction.identifier = action.identifier;
        progressAction.signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [[[RACSignal interval:1 onScheduler:RACScheduler.mainThreadScheduler] take:10] subscribe:subscriber];
            return nil;
        }];
        ahs_redux_dispatch(progressAction);
        
        AHSDispatchDataAction *logAction = [AHSDispatchDataAction new];
        logAction.identifier = @"log_data";
        logAction.data = action.data;
        ahs_redux_dispatch(logAction);
    }
}

- (void)startWith:(NSString *)url {
    if ([url isEqualToString:@"ahs://uploadlog"]) {
        NSLog(@"init job for ahs://uploadlog");
    } else if ([url isEqualToString:@"ahs://otherurl"]) {
        NSLog(@"init job for ahs://otherurl");
    }
}
@end
