//
//  Logger.h
//  HaoTiger
//
//  Created by zlpro on 2020/3/6.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "Event.h"

@interface Logger : NSObject <Middleware>

@property (strong, nonatomic) id<EventHandler> handler;

@property (weak, nonatomic) id<ResultReceiver> receiver;

@end
