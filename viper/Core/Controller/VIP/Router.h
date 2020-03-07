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
/**
 *Router 路由：负责Controller之间的切换
 */
@protocol Router <NSObject>

@required

/**
 对外公开的界面需要在此得到支持
 */
- (BOOL) canRoute:(id<Event>)event;

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


