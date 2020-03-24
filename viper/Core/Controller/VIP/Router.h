//
//  Router.h
//  VIPER
//
//  Created by zhooleen on 2018/9/28.
//  Copyright © 2018年 NONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "View.h"

typedef NS_ENUM(NSUInteger, RoutingType) {
    PushRouting,
    PresentRouting,
    AnyRouting
};

/**
 *Router 路由：负责Controller之间的切换
 *Router 是一个模块的入口，需要声明该模块中有哪些界面，这些界面需要哪些数据进行初始化
 */
@protocol Router <NSObject>

@required

/**
 对外公开的界面需要在此得到支持
 */
- (BOOL) canRoute:(id<Event>)event type:(RoutingType)type;

/**
 以PUSH的方式路由到指定界面
 */
- (void) push:(id<Event>)event from:(id<View>)view;

/**
以PRESENT的方式路由到指定界面
*/
- (void) present:(id<Event>)event from:(id<View>)view;

/**
其他路由，如TAB间切换等
模块内部的路由也使用该方法
*/
- (void) route:(id<Event>)event from:(id<View>)view;

@end


