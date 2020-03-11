//
//  SelectorMapping.h
//  VIPER
//
//  Created by zhooleen on 2020/2/28.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "Event.h"

/**
 基于Event的处理方式，存在判断name的if else分支较多
 故采用将name映射到一个具体执行函数，解决这个问题
 */
@interface SelectorMapping : NSObject

/**
 event.name与selector映射
 */
- (void) registerSelector:(SEL)sel forKey:(NSString*)key;
- (SEL) selectorForKey:(NSString*)key;

/**
 代handler执行handleEvent
 */
- (void) handleEvent:(id<Event>)event forHandler:(id<EventHandler>)handler;

/**
 代receiver执行receiveResult
 */
- (void) receiveResult:(id<Result>)result forReceiver:(id<ResultReceiver>)receiver;

@end

