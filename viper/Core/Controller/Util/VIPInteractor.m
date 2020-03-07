//
//  VIPInteractor.m
//  VIPER
//
//  Created by zhooleen on 2020/2/11.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "VIPInteractor.h"
#import "VIPEvent.h"

@interface VIPInteractor ()
@property (strong, nonatomic) NSMutableDictionary *observers;
@end

@implementation VIPInteractor 

- (void) handleEvent:(id<Event>)event {
    SEL sel = [self.eventMapping selectorForKey:event.name];
    if(sel && [self respondsToSelector:sel]) {
        
        IMP imp = [self methodForSelector:sel];
        void(*func)(id, SEL, id<Event>) = (void *)imp;
        func(self, sel, event);
        
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _eventMapping = [[SelectorMapping alloc] init];
        _observers = [NSMutableDictionary dictionaryWithCapacity:16];
    }
    return self;
}

- (void) addObserverForNotificationName:(NSString*)name {
    __weak typeof(self) that = self;
    NSObject *observer = [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(that) this = that;
        NSObject *data = note.object;
        id<Result> result = [[Result alloc] init];
        
        [this.receiver receiveResult:result];
    }];
    [self.observers setObject:observer forKey:name];
}

- (void) removeObserverForNotificationName:(NSString*)name {
    NSObject *object = [self.observers objectForKey:name];
    if(object) {
        [[NSNotificationCenter defaultCenter] removeObserver:object];
        [self.observers removeObjectForKey:name];
    }
}

- (void) removeAllObservers {
    for (NSObject* obj in self.observers.copy) {
        [[NSNotificationCenter defaultCenter] removeObserver:obj];
    }
    [self.observers removeAllObjects];
}

- (void) dealloc {
    [self removeAllObservers];
}

@end
