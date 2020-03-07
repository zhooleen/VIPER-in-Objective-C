//
//  VIPController.h
//  HaoTiger
//
//  Created by none on 2020/1/21.
//  Copyright © 2020 NONE. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "View.h"
#import "SelectorMapping.h"

@interface VIPController : UIViewController <View, DataReceiver>

@property (strong, nonatomic, readonly) SelectorMapping *resultMapping;

@property (strong, nonatomic) id<EventHandler> handler;

@property (strong, nonatomic) id<DataReceiver> previousReceiver;

- (void) setStatusBarHidden:(BOOL)hidden;

- (void) hideBackBarButtonItemTitle;

- (void) exit;

- (void) sendEvent:(NSString*)name;

- (void) sendEvent:(NSString*)name withData:(id)data;

@end
