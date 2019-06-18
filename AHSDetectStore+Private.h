//
//  AHSDetectStore+Private.h
//  AHSBasic
//
//  Created by sam on 2019/5/31.
//  Copyright © 2019 sam. All rights reserved.
//

#ifndef AHSDetectStore_Private_h
#define AHSDetectStore_Private_h
#import "AHSDetectStore.h"
#import "AHSRequestAction.h"
#import "AHSActionReducer.h"
@interface AHSDetectStore ()
- (void)registReducer:(AHSActionReducer *)reducer ForUrl:(NSString *)url inScope:(NSString *)scope;
- (void)handleUrl:(NSString *)url inScope:(NSString *)scope requestAction:(AHSRequestAction *)action;
@end

#endif /* AHSDetectStore_Private_h */
