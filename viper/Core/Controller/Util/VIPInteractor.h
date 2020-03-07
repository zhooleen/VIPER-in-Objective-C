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

/**
 系统通知的监听
 1 默认将通知转发给Presenter，由Presenter对通知进行处理后，要么直接更新View，要么转换为另一个事件返还给Interactor
 2 通知不能放在Presenter中监听，因为其不知道该默认转发给谁
 */
- (void) addObserverForNotificationName:(NSString*)name;
- (void) removeObserverForNotificationName:(NSString*)name;
- (void) removeAllObservers;

@end
