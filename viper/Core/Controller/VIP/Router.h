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

- (BOOL) canRoute:(id<Event>)event;

/**
 模块间路由使用以下方法
 */
- (void) push:(id<Event>)event from:(id<View>)view;
- (void) present:(id<Event>)event from:(id<View>)view;

@optional
//是present还是push，由该router自己实现，一般是模块内部的路由
- (void) route:(id<Event>)event from:(id<View>)view;

@end


