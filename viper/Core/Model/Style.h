//
//  Style.h
//  viper
//
//  Created by zlpro on 2020/3/7.
//  Copyright © 2020 None. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 边框样式
 */
@protocol BorderStyle <NSObject>
@property (strong, nonatomic) UIColor *color;   //边框颜色
@property (strong, nonatomic) NSNumber *radius; //圆角半径
@property (strong, nonatomic) NSNumber *width;  //边框宽度
@end

/**
 视图样式
 */
@protocol ViewStyle <NSObject>
@property (strong, nonatomic) UIColor *backgroundColor;     //背景色
@property (strong, nonatomic) id<BorderStyle> borderStyle;//边框
@end

/**
 文字样式
 */
@protocol TextStyle <ViewStyle>
@property (strong, nonatomic) UIFont *font;  //字体大小
@property (strong, nonatomic) UIColor *color;//字体颜色
@end
