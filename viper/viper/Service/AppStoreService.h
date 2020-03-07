//
//  AppStoreService.h
//  NONE
//
//  Created by none on 2020/2/9.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "Core.h"

@interface AppStoreService : NSObject

@property (strong, nonatomic) NSString *appID;

/**
 跳转到App Store
 */
- (void) gotoAppStore;

/**
 获取App Store中本应用的最新版本号
 */
- (void) queryVersionWithCallback:(ResultCallback)callback;

/**
 给本应用评分
 */
- (void) rate;

@end
