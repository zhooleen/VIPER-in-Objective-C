//
//  VIPController.h
//  VIPER
//
//  Created by zhooleen on 2020/1/21.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "View.h"
#import "SelectorMapping.h"

@interface VIPController : UIViewController <View, DataReceiver>

@property (strong, nonatomic, readonly) SelectorMapping *resultMapping;

@property (strong, nonatomic) id<EventHandler> handler;

@property (weak, nonatomic) id<DataReceiver> previousReceiver;

/**
 定义一些常用的功能函数
 */
- (void) setStatusBarHidden:(BOOL)hidden;

- (void) hideBackBarButtonItemTitle;

- (void) exit;

- (void) sendEvent:(NSString*)name;

- (void) sendEvent:(NSString*)name withData:(id)data;

/**
 通知的监听
 1、通知在VIPER建立时完成注册，也可以在ViewWillAppear中注册
 2、通知在VIPER销毁时完成注销，也可以在ViewWillDisappear中注销
 3、接收到通知后，默认封装成Event，转发给EventHandler
 4、View接收通知，Presenter处理通知，符合Event从View到Presenter的顺序
 */
- (void) addObserverForNotificationName:(NSString*)name;
- (void) removeObserverForNotificationName:(NSString*)name;
- (void) removeAllObservers;

@end
