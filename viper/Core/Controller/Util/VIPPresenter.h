//
//  VIPPresenter.h
//  VIPER
//
//  Created by zhooleen on 2020/2/7.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "Event.h"
#import "Presenter.h"
#import "Router.h"
#import "SelectorMapping.h"

@interface VIPPresenter : NSObject <Presenter>

@property (strong, nonatomic, readonly) SelectorMapping *eventMapping;       //事件与方法的映射
 
@property (strong, nonatomic, readonly) SelectorMapping *resultMapping;      //结果与方法的映射

@property (strong, nonatomic) id<EventHandler> handler;

@property (weak, nonatomic) id<ResultReceiver> receiver;

@property (weak, nonatomic) id<Router> router;

@property (weak, nonatomic) id<View> view;

- (void) sendEvent:(NSString*)name;

- (void) sendEvent:(NSString*)name withData:(id)data;

@end
