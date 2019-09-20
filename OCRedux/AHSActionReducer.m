//
//  AHSActionReducer.m
//  AHSBasic
//
//  Created by sam on 2019/5/31.
//  Copyright © 2019 sam. All rights reserved.
//

#import "AHSActionReducer.h"
#import "AHSDetectStore.h"
#import "AHSDetectStore+Private.h"

extern NSString *ahs_default_scope;
@implementation AHSActionReducer
- (void)registForUrl:(NSString *)url inScope:(NSString *)scope {
    [[AHSDetectStore store] registReducer:self ForUrl:url inScope:scope];
}

- (void)registForUrl:(NSString *)url {
    [self registForUrl:url inScope:ahs_default_scope];
}

- (void)handleUrl:(NSString *)url requestAction:(AHSRequestAction *)action {
    
}

- (void)startWith:(NSString *)url {
    
}

@end
