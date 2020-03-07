//
//  VIPPresenter.h
//  HaoTiger
//
//  Created by none on 2020/2/7.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "Event.h"
#import "Presenter.h"
#import "Router.h"
#import "SelectorMapping.h"

@interface VIPPresenter : NSObject <Presenter, DataReceiver>

@property (strong, nonatomic, readonly) SelectorMapping *eventMapping;

@property (strong, nonatomic, readonly) SelectorMapping *resultMapping;

@property (strong, nonatomic) id<EventHandler> handler;

@property (weak, nonatomic) id<ResultReceiver> receiver;

@property (weak, nonatomic) id<Router> router;

@property (weak, nonatomic) id<View> view;

- (void) sendEvent:(NSString*)name;

- (void) sendEvent:(NSString*)name withData:(id)data;

@end
