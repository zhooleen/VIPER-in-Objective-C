//
//  ThirdPartyAPI.h
//  NONE
//
//  Created by lz on 2019/9/8.
//  Copyright © 2019年 NONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface ThirdPartyAPI : NSObject

- (void) request:(NSURLRequest*)request callback:(ResultCallback)callback;

@end
