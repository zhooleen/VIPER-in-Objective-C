//
//  Event.h
//  VIPER
//
//  Created by zhooleen on 2018/9/28.
//  Copyright © 2018年 NONE. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * 事件
 */

@protocol Event <NSObject>

@property (strong , nonatomic) NSString *name; //事件名称

@property (strong , nonatomic) id data;  //事件参数

@end



/**
 * 事件响应
 */
@protocol Result <Event>

@property (strong , nonatomic) NSString *status;    //状态

@property (strong , nonatomic) NSString *title;     //标题

@property (strong , nonatomic) NSString *message;   //状态信息

@end

/**
 定义响应回调，用于异步事件
 */
typedef void(^ResultCallback)(id<Result> result);

/**
 * 事件处理器：
 * （1）事件流：View -> Presenter -> Interactor
 * （2）Presenter 、 Interactor均是EventHandler
 */
@protocol EventHandler <NSObject>
- (void) handleEvent:(id<Event>)event;
@end

/**
 * 数据接收器
 * （1）数据流：Interactor->Presenter->View
 * （2）Presenter、View均是ResultReceiver
 */
@protocol ResultReceiver <NSObject>
- (void) receiveResult:(id<Result>)result;
@end


/**
原始数据在VIPER架构中的流转以及保存：
Interactor:从数据库、Server等请求数据，并将数据直接传递给Presenter
Presenter：保存从Interactor获取的数据，并转换为View可展示的Model
View：只展示视图，不对数据做处理；

原始数据：数据库 -> Interator -> Presenter -> Interactor
模型数据：Presenter -> View -> Presenter


事件数据在VIPER架构中的流转以及保存：
View：转发用户操作，携带用户输入数据或者相关模型数据
Presenter：将用户输入数据或者相关模型数据转换为Interactor能处理的数据，并保存
Interactor：将数据插入数据库或者上传Server

事件数据：View -> Presenter -> Interactor -> 数据库

*/


/**
 中间件 Middleware
 事件在VIPER架构中流转时，可通过中间件对其做特殊处理，如记录日志
 */
@protocol Middleware <EventHandler, ResultReceiver>

@property (strong, nonatomic) id<EventHandler> handler;

@property (weak, nonatomic) id<ResultReceiver> receiver;

@end

/**
 *VIP之间参数传递
 *初始：上级向本级传递初始化参数
 *回调：下级向本级传递回调的参数
 *
 *VIP栈：上级 -> 本级 -> 下级
 *
 *角色：一般由Presenter或者View担当DataReceiver角色
 */
@protocol DataReceiver <NSObject>
@optional
- (void) receiveInitialData:(id)data;
- (void) receiveCallbackData:(id)data;
@end
