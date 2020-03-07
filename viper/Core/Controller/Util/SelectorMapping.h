//
//  SelectorMapping.h
//  HaoTiger
//
//  Created by none on 2020/2/28.
//  Copyright © 2020 NONE. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 基于Event的处理方式，存在判断name的if else分支较多
 故采用将name映射到一个具体执行函数，解决这个问题
 */
@interface SelectorMapping : NSObject

- (void) registerSelector:(SEL)sel forKey:(NSString*)key;

- (SEL) selectorForKey:(NSString*)key;

@end

