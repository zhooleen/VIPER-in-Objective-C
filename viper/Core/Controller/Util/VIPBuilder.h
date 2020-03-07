//
//  VIPBuilder.h
//  VIPER
//
//  Created by zhooleen on 2020/2/10.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Router.h"
#import "View.h"

@interface VIPBuilder : NSObject

@property (strong, nonatomic) NSString *prefix;

@property (weak, nonatomic) id<Router> router;

@property (strong, nonatomic) NSString *storyboard;

@property (strong, nonatomic) id initialData;

@property (strong, nonatomic) UIViewController<View> *previous;

- (UIViewController<View>*) build;

+ (UIViewController<View>*) buildWithPrefix:(NSString*)prefix router:(id<Router>)router;

@end
