//
//  SelectorMapping.m
//  VIPER
//
//  Created by zhooleen on 2020/2/28.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "SelectorMapping.h"

@interface SelectorMapping ()

@property (strong, nonatomic) NSMutableDictionary *mappings;

@end

@implementation SelectorMapping

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mappings = [NSMutableDictionary dictionaryWithCapacity:32];
    }
    return self;
}

- (void) registerSelector:(SEL)sel forKey:(NSString *)key {
    
    if(sel == NULL || key == nil) {
        return;
    }
    
    NSString *name = NSStringFromSelector(sel);
    
    [self.mappings setObject:name forKey:key];
    
}

- (SEL) selectorForKey:(NSString *)key {
    if(key == nil) {
        return nil;
    }
    NSString *name = [self.mappings objectForKey:key];
    if(name == nil) {
        return nil;
    }
    SEL sel = NSSelectorFromString(name);
    return sel;
}

@end
