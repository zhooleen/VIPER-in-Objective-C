//
//  View.h
//  viper
//
//  Created by zlpro on 2020/3/7.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "ViewModel.h"

@protocol CellDelegate <NSObject>
@optional
/**
 区域中的CELL被选中
 */
- (void) onSelectCell:(id<CellViewModel>)cell inSection:(id<SectionViewModel>)section;

/**
区域中CELL的某个事件被触发
*/
- (void) onTriggerAction:(NSString*)action ofCell:(id<CellViewModel>)cell inSection:(id<SectionViewModel>)section;

/**
区域中Header/Footer的某个事件被触发
*/
- (void) onTriggerAttachmentAction:(NSString*)action inSection:(id<SectionViewModel>)section;

@end

/**
 小部件, 一般用于UITableViewCell / UICollectionViewCell 等
 */
@protocol Cell <NSObject>

- (void) updateWithModel:(id<CellViewModel>)model;

+ (CGSize) cellSizeWithModel:(id<CellViewModel>)model;

@optional
@property(weak, nonatomic) id<CellDelegate> delegate;

@end


/**
  区块部件：UITableViewCell / UICollectionViewCell 中的一个Section
 */
@protocol SectionCell <Cell>

@end

/**
  附件：UITableViewCell / UICollectionViewCell 中的HeaderView、FooterView
 */
@protocol SectionAttachment <Cell>

@end
