## AHSRedux
AHSRedux 是 react-redux + thunk 的简易实现, 同时根据 iOS 平台的特点做了合理的精简

### 与 redux 相同的地方
1. store, action, reducer, dispatcher, 基本元素一致
2. 由 store 管理所有的 reducer
3. 由 action 触发状态改变
4. 由 diapatcher 分发 action

### 与 react-redux 不同的地方
由于 iOS 有天然的 controller, 所以我们只需要关心 controller 层级的状态共享即可, AHSRedux 相对于标准的 react-redux 有如下区别
1. 隐式的 store, 使用者不需要手动创建 store, 也不需要 combineReducer, 一切都自然而然的发生
2. 分散的 state, iOS controller 之间共享的状态可能仅仅是几个属性, 因此维持一个统一的 state 树显得非常的没有必要, 由相关的 reducer 管理
3. 方便的 connect, 相较于 react-redux 中 connect 的弯弯绕, AHSRedux 的状态绑定显得非常直接, 一句话概括为, 谁请求, 谁处理, 谁需要, 谁订阅
4. 天然的 thunk, AHSRedux 并没有中间件系统, 因此借助 ReactiveCocoa 将 thunk 整合了进来, 使用方式与其他 action 统一

### 示例
1. 上传一段日志, 并监听状态
```objc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    AHSRequestAction *action = [AHSRequestAction new];
    action.data = @"白日依山尽, 黄河入海流, 欲穷千里目, 更上一层楼";
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

```

2. 注册 reducer, 订阅需要的信息或状态

```objc
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
```
### 写在最后
AHSRedux 是为了应对跨模块, 跨界面之间消息传递和状态共享的需求, 参考了前端的 react-redux, 根据 iOS 平台的特点实现的一个库. 是一层很薄的实现, 并没有限制做任何的扩展. 
