# VIPER-in-Objective-C
VIPER架构中各组件的分工严格遵循单一职责原则。作者实现了基于事件的松耦合VIPER架构，其各组件的职责、交互如下所示：
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
事件产生后，交给事件处理器去处理。如View上的点击事件交给Presenter处理，Presenter可再将该事件转发给Interactor。
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
	将初始化封装成初始化事件，由EventHandler处理；
	将界面结果回调封装成初始化响应，由ResultHandler接收并处理。

### View
View的职责：
1. 对UI的创建、展示、动画、样式等做控制
2. 将事件外包给EventHandler处理
3. 根据EventHandler回调的结果，控制UI更新
4. 接收前一个界面传来的初始化数据
5. 接收后一个界面回调的数据
5. 界面退出时，将结果回调给前一个界面
``` Objective C
@protocol View <Middleware>
- (UIViewController*) routeSource;//一般是View本身
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
//路由类型：PUSH、PRESENT、ANY
typedef NS_ENUM(NSUInteger, RoutingType) {
    PushRouting,
    PresentRouting,
    AnyRouting
};
@protocol Router <NSObject>
- (BOOL) canRoute:(id<Event>)event type:(RoutingType)type; //是否支持
- (void) push:(id<Event>)event from:(id<View>)view; //push routing
- (void) present:(id<Event>)event from:(id<View>)view; //present routing
- (void) route:(id<Event>)event from:(id<View>)view; //any routing
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
## 实践
至此，VIPER中各个关键组件以及其相互间的交互已经建模完成。但仍存在以下问题有待解决：
1、不管是EventHandler处理Event还是ResultReceiver接收Result，其处理逻辑都是通过层层叠叠的if-else语句判断event.name，可读性、维护性差。
2、构建VIPER结构逻辑单一，可抽象，交由某一工具类构建；
3、全局Router怎么维护；
4、常用逻辑抽象在基类中。
### 通过SelectorMapping解决if-else层叠问题
不管是EventHandler处理Event，还是ResultReceiver接收Result，将Event.name与处理函数Selector一一关联，即可将if-else转换为event-selector映射。
故使用时，只需要init方法中建立映射关系即可。
``` Objective C
@interface SelectorMapping : NSObject
- (void) registerSelector:(SEL)sel forKey:(NSString*)key;   //注册映射关系
- (SEL) selectorForKey:(NSString*)key;
- (void) handleEvent:(id<Event>)event forHandler:(id<EventHandler>)handler; //处理事件 
- (void) receiveResult:(id<Result>)result forReceiver:(id<ResultReceiver>)receiver; //接收结果
@end
```
### VIPBuilder简化VIPER结构创建
```
@interface VIPBuilder : NSObject
@property (strong, nonatomic) NSString *prefix;    //V、I、P三者通过前缀创建
@property (weak, nonatomic) id<Router> router;     //R
@property (strong, nonatomic) NSString *storyboard;//是否从SB中创建V
@property (strong, nonatomic) id initialData;      //初始化数据
@property (strong, nonatomic) UIViewController<View> *previous;  //前一级VIPER结构，接收本级VIPER产生的结果
- (UIViewController<View>*) build; //构建VIPER结构
+ (UIViewController<View>*) buildWithPrefix:(NSString*)prefix router:(id<Router>)router; //工具函数：无初始化、无返回、非SB
@end
```
通过VIPBuiler，每次构建VIPER结构，只需要配置所需参数即可。对于不需要初始化参数，也不向上一级VIPER返回数据的，非SB结构，直接调用
工具方法[VIPBuilder buildWithPrefix:router:],将创建工作压缩到最小。
### 全局Router
一个模块内部构建完成后，只需要对外提供最小信息即可。对于VIPER架构封装的Module，对外暴露路由事件以及该事件所需的参数即可。
通过路由事件以及参数，可以PUSH或PRESENT的方式唤起该模块中的界面，而无须关注该模块内各个组件的名称以及交互方式。
```
@interface VIPRouter : NSObject <Router>
+ (instancetype) router;
- (void) registerRouters:(NSArray*)classNames;  //注册各个模块中的Router实例，一般在App launch时注册。
- (id<Router>) routerOfClass:(NSString*)className; //只有首页需要，其他地方用不上
@end
```
例如，在A模块中唤起B模块中某个界面，路由名称为ARouting，无需参数：
[VIPRouter.router push:B.ARouting.event from:A.view];
### 基类
1. VIPController 遵循View协议，封装了Event-selector映射，以及将通知转换为Event。
2. VIPPresenter 遵循Presenter协议，封装了Event-selector映射，并为事件处理提供默认逻辑
3. VIPInteractor 遵循Interactor协议，封装了Event-selector映射
基类主要工作为将if-else转换为Event-selector映射。

## 辅助
### Model抽象
Model分为ViewModel以及DomainModel：
    ViewModel：包含UIView及其子类所需要的内容，其属性可不具备现实意义，为了统一处理ViewModel，为其添加title、subtitle、image、icon等通用属性。
    DomainModel：对业务对象的抽象，其属性具有现实意义，如User、Product等；
### 去Model化处理
通过NSProxy代理NSDictionary实现对ViewModel属性的访问。
### UIView的抽象统一
将UIView的大小计算、内容更新封装在UIView组件内部，常用于UITableViewCell UICollectionViewCell, 简化和统一Delegate的逻辑处理。
```
@protocol Cell <NSObject>
- (void) updateWithModel:(id<CellViewModel>)model;
+ (CGSize) cellSizeWithModel:(id<CellViewModel>)model;
@end
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

