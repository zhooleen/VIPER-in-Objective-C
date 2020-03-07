//
//  VIPEvent.h
//  viper
//
//  Created by zlpro on 2020/3/7.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "Event.h"

@interface Event : NSObject <Event>

@property (strong , nonatomic) NSString *name; //事件名称

@property (strong , nonatomic) id data;  //事件参数

+ (instancetype) eventWithName:(NSString*)name;

+ (instancetype) eventWithName:(NSString*)name data:(id)data;

@end

@interface Result:NSObject <Result>

@property (strong , nonatomic) NSString *name; //事件名称

@property (strong , nonatomic) id data;  //事件参数

@property (strong , nonatomic) NSString *status;    //状态

@property (strong , nonatomic) NSString *title;     //标题

@property (strong , nonatomic) NSString *message;   //状态信息

+ (instancetype) resultWithName:(NSString*)name data:(id)data;


@end


/**
 常见的事件
 */
FOUNDATION_EXTERN EventName kEventViewDidLoad;
FOUNDATION_EXTERN EventName kEventViewWillAppear;
FOUNDATION_EXTERN EventName kEventViewDidAppear;
FOUNDATION_EXTERN EventName kEventViewWilldisappear;
FOUNDATION_EXTERN EventName kEventViewDidDisappear;


/**
 常见的响应状态
 */
FOUNDATION_EXTERN ResultStatus kResultStatusError;       //错误
FOUNDATION_EXTERN ResultStatus kResultStatusSuccess;     //成功
FOUNDATION_EXTERN ResultStatus kResultStatusWarning;     //警示
FOUNDATION_EXTERN ResultStatus kResultStatusTimeout;     //超时
FOUNDATION_EXTERN ResultStatus kResultStatusNoMoreData;  //没有更多数据了
FOUNDATION_EXTERN ResultStatus kResultStatusEmpty;       //没有记录
