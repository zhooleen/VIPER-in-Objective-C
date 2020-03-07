//
//  AppDelegate.m
//  NONE
//
//  Created by none on 2020/1/18.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "AppDelegate.h"
#import "VIPRouter.h"
#import "AccountController.h"
#import "VIPBuilder.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - APP LIFE CYCLE

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self registerRouters];
    
    id<Router> router = [VIPRouter.router routerOfClass:@"AccountRouter"];
    id<View> view = [VIPBuilder buildWithPrefix:@"Account" router:router];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:view.routeSource];
    
    CGRect frame = UIScreen.mainScreen.bounds;
    self.window = [[UIWindow alloc] initWithFrame:frame];
    self.window.rootViewController = navi;
    self.window.backgroundColor = [UIColor blueColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark -
- (void) registerRouters {
    NSArray *names = @[@"AccountRouter"];
    [[VIPRouter router] registerRouters:names];
}


@end
