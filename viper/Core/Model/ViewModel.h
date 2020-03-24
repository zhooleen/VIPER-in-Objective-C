//
//  ViewModel.h
//  viper
//
//  Created by zlpro on 2020/3/7.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "Model.h"
#import "Style.h"
#import "Event.h"

/**
 常见视图模型：仅为View的展示提供必需的格式化内容
 */
@protocol CommonViewModel <ViewModel>
@property (strong, nonatomic) NSString *title; //标题
@property (strong, nonatomic) NSString *subtitle; //副标题
@property (strong, nonatomic) NSString *detail; //详情
@property (strong, nonatomic) NSString *text; //正文
@property (strong, nonatomic) NSString *icon; //图标
@property (strong, nonatomic) NSString *iconUrl;
@property (strong, nonatomic) NSString *image; //图片
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *decoration; //装饰：热销、未读、火爆等
@property (strong, nonatomic) NSString *action;//事件：更多、查看详情、立即进入、j立即购买等
@property (strong, nonatomic) NSString *price;//价格
@end

/**
 可自定义样式的常见视图模型
 */
@protocol StyledViewModel <CommonViewModel>
@property (strong, nonatomic) id<TextStyle> titleStyle; //标题样式
@property (strong, nonatomic) id<TextStyle> subtitleStyle; //副标题样式
@property (strong, nonatomic) id<TextStyle> detailStyle; //详情样式
@property (strong, nonatomic) id<TextStyle> textStyle; //正文样式
@property (strong, nonatomic) id<ViewStyle> iconStyle; //图标样式
@property (strong, nonatomic) id<ViewStyle> imageStyle; //背景图样式
@property (strong, nonatomic) id<TextStyle> decorationStyle; //装饰样式
@property (strong, nonatomic) id<TextStyle> actionStyle; //事件样式
@property (strong, nonatomic) id<TextStyle> priceStyle; //价格样式
@end


/**
 为集合视图建模：UICollectionView UITableView
 PageViewModel: 包含集合视图中所需要的所有信息
 SectionViewModel：集合视图一个Section的信息
 CellViewModel：集合视图中的一个Cell信息
 */
@protocol CellViewModel <StyledViewModel>
/**
 Cell 重用标识，一般为Cell的类名
 */
@property (strong, nonatomic) NSString *reuseIdentifier;

/**
触发后，执行指定事件
事件及参数不会变的情况下使用，否则由Controller动态动态生成事件
*/
@property (strong, nonatomic) id<Event> event;

/**
 对于动态Cell，保存Cell Size的计算结果，避免重复计算
 */
@property (strong, nonatomic) NSValue *cellSize;

@end

/**
 有时候一个Section作为一个Cell来处理
 */
@protocol SectionViewModel <CellViewModel>
@property (strong, nonatomic) NSNumber *asCell;//是否作为一个整体考虑
@property (strong, nonatomic) NSArray<id<CellViewModel>> *models;
@end

@protocol PageViewModel <ViewModel>
@property (strong, nonatomic) NSArray<id<SectionViewModel>> *sections;
@end
