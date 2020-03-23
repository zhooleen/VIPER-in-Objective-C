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
 * 响应接收器
 * （1）数据流：Interactor->Presenter->View
 * （2）Presenter、View均是ResultReceiver
 */
@protocol ResultReceiver <NSObject>
- (void) receiveResult:(id<Result>)result;
@end

/**
 中间件 Middleware
 事件在VIPER架构中流转时，可通过中间件对其做特殊处理，如记录日志
 */
@protocol Middleware <EventHandler, ResultReceiver>

@property (strong, nonatomic) id<EventHandler> handler;

@property (weak, nonatomic) id<ResultReceiver> receiver;

@end

typedef NSString* EventName;
typedef NSString* RoutingName;
typedef NSString* NotificationName;
typedef NSString* ResultStatus;

