//
//  VIPPresenter.m
//  VIPER
//
//  Created by zhooleen on 2020/2/7.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "VIPPresenter.h"
#import "VIPEvent.h"

@implementation VIPPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _eventMapping = [[SelectorMapping alloc] init];
        _resultMapping = [[SelectorMapping alloc] init];
    }
    return self;
}

- (void) handleEvent:(id<Event>)event {
    SEL sel = [self.eventMapping selectorForKey:event.name];
    if(sel && [self respondsToSelector:sel]) {
        
        [self.eventMapping handleEvent:event forHandler:self];
        
    } else if([event.name hasPrefix:@"kRoute"]) {
        
        if(self.router && [self.router respondsToSelector:@selector(route:from:)]) {
            [self.router route:event from:self.view];
        }
        
    } else if([event.name hasPrefix:@"kEvent"]) {
        
        [self.handler handleEvent:event];
        
    }
}

- (void) receiveResult:(id<Result>)result {
    SEL sel = [self.resultMapping selectorForKey:result.name];
    if(sel && [self respondsToSelector:sel]) {
        
        [self.resultMapping receiveResult:result forReceiver:self];
        
    } else {
        
        [self.receiver receiveResult:result];
        
    }
}

- (void) sendEvent:(NSString*)name {
    if(self.handler) {
        id<Event> event = [Event eventWithName:name];
        [self.handler handleEvent:event];
    }
}

- (void) sendEvent:(NSString*)name withData:(id)data {
    if(self.handler) {
        id<Event> event = [Event eventWithName:name data:data];
         [self.handler handleEvent:event];
    }
}

@end
