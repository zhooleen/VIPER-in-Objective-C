//
//  Presenter.h
//  VIPER
//
//  Created by zhooleen on 2018/9/28.
//  Copyright © 2018年 NONE. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Event.h"
#import "View.h"

@protocol Router;

/**
 * Presenter：
 *(1)控制View的展示
 *(2)接收View产生的事件，处理后分发给Interactor/Router
 *(3)接收来自Interactor的数据，处理后转发给View
 *
 *数据处理：
 *1、格式化：将原始数据格式化为可展示的格式
 *2、数据验证：验证用户输入的数据的有效性
 *3、数据持有：同时持有原始数据与格式化后的数据
 */
@protocol Presenter <Middleware>

@property (weak, nonatomic) id<Router> router;

@property (weak, nonatomic) id<View> view;

@end
