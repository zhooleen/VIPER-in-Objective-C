//
//  VIPRouter.m
//  VIPER
//
//  Created by zhooleen on 2020/1/19.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "VIPRouter.h"
#import "View.h"

@interface VIPRouter ()

@property (strong, nonatomic) NSMutableArray<id<Router>> *routers;

@end

@implementation VIPRouter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _routers = [NSMutableArray arrayWithCapacity:32];
    }
    return self;
}

+ (instancetype) router {
    static dispatch_once_t onceToken;
    static VIPRouter *mgr = nil;
    dispatch_once(&onceToken, ^{
        mgr = [[VIPRouter alloc] init];
    });
    return mgr;
}

- (BOOL) canRoute:(id<Event>)event type:(RoutingType)type{
    for (id<Router> router in self.routers) {
        if([router canRoute:event type:type]) {
            return YES;
        }
    }
    return NO;
}

- (void) push:(id<Event>)event from:(UIViewController<View> *)controller {
    for (id<Router> router in self.routers) {
        if([router canRoute:event type:PushRouting]) {
            [router push:event from:controller];
        }
    }
}

- (void) present:(id<Event>)event from:(UIViewController<View> *)controller {
    for (id<Router> router in self.routers) {
        if([router canRoute:event type:PresentRouting]) {
            [router present:event from:controller];
        }
    }
}

- (void) route:(id<Event>)event from:(UIViewController<View> *)controller {
    for (id<Router> router in self.routers) {
        if([router canRoute:event type:AnyRouting]) {
            [router route:event from:controller];
        }
    }
}

- (id<Router>) _routerOfClass:(Class)klass {
    for (id<Router> router in self.routers) {
        if([router isKindOfClass:klass]) {
            return router;
        }
    }
    return nil;
}

- (void) registerRouter:(NSString*)className {
    Class klass = NSClassFromString(className);
    if(klass) {
        id<Router> router = [[klass alloc] init];
        if(router) {
            [self.routers addObject:router];
        }
    }
}

- (void) registerRouters:(NSArray*)classNames {
    for (NSString *name in classNames) {
        [self registerRouter:name];
    }
}

- (id<Router>) routerOfClass:(NSString*)className {
    Class klass = NSClassFromString(className);
    return [self _routerOfClass:klass];
}

@end
