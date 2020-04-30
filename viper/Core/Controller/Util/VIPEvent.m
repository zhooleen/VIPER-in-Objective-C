//
//  VIPEvent.m
//  viper
//
//  Created by zlpro on 2020/3/7.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "VIPEvent.h"

@implementation Event

+ (instancetype) eventWithName:(NSString*)name {
    Event *e = [[Event alloc] init];
    e.name = name;
    return e;
}

+ (instancetype) eventWithName:(NSString*)name data:(id)data {
    Event *e = [[Event alloc] init];
    e.name = name;
    e.data = data;
    return e;
}

@end

@implementation Result

+ (instancetype) resultWithName:(NSString*)name data:(id)data {
    Result *e = [[Result alloc] init];
    e.name = name;
    e.data = data;
    return e;
}

@end

@implementation NSString (VIPEvent)

-(id<Event>) event {
    return [Event eventWithName:self];
}

@end

EventName kEventViewDidLoad         =   @"kEventViewDidLoad";
EventName kEventViewWillAppear      =   @"kEventViewWillAppear";
EventName kEventViewDidAppear       =   @"kEventViewDidAppear";
EventName kEventViewWilldisappear   =   @"kEventViewWilldisappear";
EventName kEventViewDidDisappear    =   @"kEventViewDidDisappear";

EventName kEventInitialize  =   @"kEventInitialize";
EventName kEventCalback     =   @"kEventCalback";


/**
 常见的响应状态
 */
ResultStatus kResultStatusError         =   @"kResultStatusError";
ResultStatus kResultStatusSuccess       =   @"kResultStatusSuccess";
ResultStatus kResultStatusWarning       =   @"kResultStatusWarning";
ResultStatus kResultStatusTimeout       =   @"kResultStatusTimeout";
ResultStatus kResultStatusNoMoreData    =   @"kResultStatusNoMoreData";
ResultStatus kResultStatusEmpty         =   @"kResultStatusEmpty";
