//
//  ViewController.m
//  OCReduxDemo
//
//  Created by sam on 2019/9/20.
//  Copyright © 2019 sam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    AHSRequestAction *action = [AHSRequestAction new];
    action.data = @"百日依山尽, 黄河入海流, 欲穷千里目, 更上一层楼";
    action.identifier = @"ahs://uploadlog";
    [self requestForUrl:@"ahs://uploadlog" action:action];
}


- (void)handleAction:(AHSDispatchSignalAction *)action {
    if ([action isKindOfClass:[AHSDispatchSignalAction class]] &&
        [action.identifier isEqualToString:@"ahs://uploadlog"]) {
        [action.signal subscribeNext:^(id x) {
            NSLog(@"上传中");
        } completed:^{
            NSLog(@"上传完成");
        }];
    }
}

@end
