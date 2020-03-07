# VIPER-in-Objective-C
Objective-C实现基于事件的VIPER架构,交互图如下：
![VIPER.png](https://upload-images.jianshu.io/upload_images/21549447-c54e517aad6fe10a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 建模
### 事件 Event
VIPER中各部分之间通过Event进行交互。
举例：View上用户点击Button，View向Presenter发送点击事件；Presenter处理点击事件后，回传Result给View，View根据Result的信息更新UI展示。
Result的回传可以是同步的，也可以是异步的。
``` Objective C
@protocol Event <NSObject>
@property (strong , nonatomic) NSString *name; //事件名称
@property (strong , nonatomic) id data;  //事件参数
@end
```
### 响应 Result
事件响应也是一种事件。
``` Objective C
@protocol Result <Event>
@property (strong , nonatomic) NSString *status;    //状态
@property (strong , nonatomic) NSString *title;     //标题
@property (strong , nonatomic) NSString *message;   //状态信息
@end
```
### 事件处理 EventHandler
事件产生后，交给时间处理器去处理。如View上的点击事件交给Presenter处理，Presenter可再将该事件转发给Interactor。
``` Objective C
@protocol EventHandler <NSObject>
- (void) handleEvent:(id<Event>)event;
@end
```
### 响应接收 ResultReceiver
对事件处理后，需要将事件响应回调给接收者。如Interactor对用户点击事件作出处理后，将结果回调给Presenter，Presenter可再将该结果转给View。
``` Objective C
@protocol ResultReceiver <NSObject>
- (void) receiveResult:(id<Result>)result;
@end
```
### 中间件
在View-Presenter-Interactor这条通道上，可加载中间件，处理一些非业务性逻辑，如日志记录。
由于Presenter处理中间位置，也可视为一种中间件。
``` Objective C
@protocol Middleware <EventHandler, ResultReceiver>
@property (strong, nonatomic) id<EventHandler> handler;
@property (weak, nonatomic) id<ResultReceiver> receiver;
@end
```
### 初始化与回调
从A路由到B，需要设置B的初始状态；
从B退回到A，B的结果需要回调给A。
``` Objective C
@protocol DataReceiver <NSObject>
@optional
- (void) receiveInitialData:(id)data; //初始化
- (void) receiveCallbackData:(id)data;//结果回调
@end
```
### View
View的职责：
1. 对UI的创建、展示、动画、样式等做控制
2. 将事件外包给EventHandler处理
3. 根据EventHandler回调的结果，控制UI更新
4. 接收前一个界面传来的初始化数据
5. 接收后一个界面回调的数据
5. 界面退出时，将结果回调给前一个界面
``` Objective C
@protocol View <ResultReceiver>
@property (strong, nonatomic) id<EventHandler> handler;//中间件
- (UIViewController*) routeSource;//一般是View本身
@optional
@property (weak, nonatomic) id<DataReceiver> previousReceiver;
- (id<DataReceiver>) initialReceiver;
- (id<DataReceiver>) callbackReceiver;
@end
```
### Presenter
Presenter的职责：
1. 对View产生的事件做预处理与预判：
	自身能消化的事件处理后回调给View；
	将路由事件转给Router；
	其他事件转给Interactor。
2. 对Event中参数做格式化检查：非空，参数长度等
3. 将Result中数据格式化为适合View展示的数据
``` Objective C
@protocol Presenter <Middleware>
@property (weak, nonatomic) id<Router> router;
@property (weak, nonatomic) id<View> view;
@end
```
### Interactor
Interactor职责：
1. 访问数据库
2. 访问服务器
3. 调用各中Service
``` Objective C
@protocol Interactor <EventHandler>
@property (weak, nonatomic) id<ResultReceiver> receiver;
@end
```
### Router
负责自己模块中各界面的显示：push present,或者处理其他与界面切换相关的操作，如Tab切换。
``` Objective C
@protocol Router <NSObject>
- (BOOL) canRoute:(id<Event>)event; //是否支持
- (void) push:(id<Event>)event from:(id<View>)view; //push routing
- (void) present:(id<Event>)event from:(id<View>)view; //present routing
- (void) route:(id<Event>)event from:(id<View>)view; //other routing
@end
```
### 构建VIPER结构
一般在Router中完成VIPER结构的构建，各个部分之间松耦合。
``` Objective C
view.handler = presenter;
presenter.handler = interactor;
interactor.receiver = presenter;
presenter.receiver = view;
presenter.view = view;
presenter.router = router;
```
## 参考资料
[Objective-C实现基于Event的VIPER架构<1>](https://www.jianshu.com/p/c9993713730d)

[Objective-C实现基于Event的VIPER架构<2>](https://www.jianshu.com/p/f44ca94586b4)

[Objective-C实现基于Event的VIPER架构<3>](https://www.jianshu.com/p/726d615fb94b)

[Objective-C实现基于Event的VIPER架构<4>](https://www.jianshu.com/p/ab74989fc903)

[Objective-C实现基于Event的VIPER架构<5>](https://www.jianshu.com/writer#/notebooks/43173191/notes/61973210)

[Objective-C实现基于Event的VIPER架构<6>](https://www.jianshu.com/writer#/notebooks/43173191/notes/61976343)

[Objective-C实现基于Event的VIPER架构<7>](https://www.jianshu.com/writer#/notebooks/43173191/notes/61976387)

[Objective-C实现基于Event的VIPER架构<8>](https://www.jianshu.com/writer#/notebooks/43173191/notes/62164075)

[Objective-C实现基于Event的VIPER架构<9>](https://www.jianshu.com/writer#/notebooks/43173191/notes/62742387)

[Objective-C实现基于Event的VIPER架构<10>](https://www.jianshu.com/writer#/notebooks/43173191/notes/62764636)

