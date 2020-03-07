//
//  VIPRouter.h
//  HaoTiger
//
//  Created by none on 2020/1/19.
//  Copyright © 2020 NONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Router.h"

@interface VIPRouter : NSObject <Router>

+ (instancetype) router;

- (void) registerRouters:(NSArray*)classNames;

- (id<Router>) routerOfClass:(NSString*)className;

@end
