//
//  VIPRouter.h
//  VIPER
//
//  Created by zhooleen on 2020/1/19.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Router.h"

@interface VIPRouter : NSObject <Router>

+ (instancetype) router;

- (void) registerRouters:(NSArray*)classNames;

- (id<Router>) routerOfClass:(NSString*)className;

@end
