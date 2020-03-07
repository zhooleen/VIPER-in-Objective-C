//
//  VIPInteractor.m
//  VIPER
//
//  Created by zhooleen on 2020/2/11.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "VIPInteractor.h"
#import "VIPEvent.h"

@implementation VIPInteractor 

- (void) handleEvent:(id<Event>)event {
    [self.eventMapping performSelectorWithTarget:self key:event.name param:event];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _eventMapping = [[SelectorMapping alloc] init];
    }
    return self;
}

@end
