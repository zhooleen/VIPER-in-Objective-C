//
//  View.h
//  VIPER
//
//  Created by zhooleen on 2018/9/28.
//  Copyright © 2018年 NONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

/**
 * View 视图
 * （1）负责：View展示、View更新、动画控制、事件转发、数据接收
 * （2）用户的操作，都封装成Event转发给Presenter，然后使用回调中的数据更新View
 * （3）主动请求数据：需要数据时，向Presenter发起请求
 * （3）被动接收数据：Presenter接收到数据Model变更时，会将数据传给View
 *
 * VIP间数据传递
 *（1）本级通过initialReceiver接收上级传递来的初始化数据
 *（2）本级通过callbackReceiver接收下级回调的数据
 *（3）本级通过previousReceiver向上级回调数据
 */

@protocol View <Middleware>

/**
 路由源界面
 */
- (UIViewController*) routeSource;

@end

