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
