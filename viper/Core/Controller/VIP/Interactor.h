//
//  Interactor.h
//  NONE
//
//  Created by none on 2018/9/28.
//  Copyright © 2018年 NONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

/**
 Interactor：基于用例的逻辑处理层
 1、访问数据库
 2、调用服务端接口
 3、对系统服务的封装
 4、该层处理的数据是原始数据，不做格式化
 5、由于用例的复用性，Interactor可复用
 */
@protocol Interactor <EventHandler>

@property (weak, nonatomic) id<ResultReceiver> receiver;

@end
