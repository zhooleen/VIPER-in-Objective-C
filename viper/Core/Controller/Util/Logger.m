//
//  Logger.m
//  HaoTiger
//
//  Created by zlpro on 2020/3/6.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "Logger.h"

@implementation Logger

- (void) handleEvent:(id<Event>)event {
    NSLog(@"事件：%@",event.name);
    if(self.handler) {
        [self.handler handleEvent:event];
    }
}

- (void) receiveResult:(id<Result>)result {
    NSLog(@"事件：%@, 标题：%@, 状态：%@, 消息：%@",result.name, result.title, result.status, result.message);
    if(self.receiver) {
        [self.receiver receiveResult:result];
    }
}

@end
