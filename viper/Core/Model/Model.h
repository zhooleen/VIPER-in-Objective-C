//
//  VIPModel.h
//  viper
//
//  Created by zlpro on 2020/3/7.
//  Copyright © 2020 None. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 模型
 */
@protocol Model <NSObject>
@property (strong, nonatomic) NSString *identifier;//唯一标识
@end

/**
 领域模型：代表对现实世界中对象的抽象、建模
 */
@protocol DomainModel <Model>
@end

/**
 视图模型：仅为View的展示提供必需的格式化内容
 */
@protocol ViewModel <Model>
@end

