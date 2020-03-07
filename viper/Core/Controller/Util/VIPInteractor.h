//
//  VIPInteractor.h
//  VIPER
//
//  Created by zhooleen on 2020/2/11.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "Interactor.h"
#import "SelectorMapping.h"

@interface VIPInteractor : NSObject <Interactor>

@property (weak, nonatomic) id<ResultReceiver> receiver;

@property (strong, nonatomic, readonly) SelectorMapping *eventMapping;

@end
