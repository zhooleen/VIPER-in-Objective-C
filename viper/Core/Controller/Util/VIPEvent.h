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

