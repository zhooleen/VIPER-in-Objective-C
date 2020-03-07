//
//  BasicTableCell.m
//  NONE
//
//  Created by none on 2020/2/7.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "BasicTableCell.h"
#import "UIView+Util.h"
#import "UIView+Geometry.h"

@interface BasicTableCell ()

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *subtitle;
@property (strong, nonatomic) UILabel *detail;
@property (strong, nonatomic) UIImageView *icon;

@end

@implementation BasicTableCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setupViews];
    }
    return self;
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void) prepareForReuse {
    [super prepareForReuse];
    
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self.detail sizeToFit];
    CGFloat width = self.contentView.width;
    self.icon.origin = CGPointMake(16, (self.contentView.height-self.icon.height)/2.0f);
    self.detail.frame = (CGRect){width - self.detail.width,22,self.detail.width, 16};
    self.subtitle.frame = (CGRect){self.icon.right+16,34,width - self.detail.width - 24 - self.icon.right, 16};
    self.title.frame = (CGRect){self.icon.right+16,11,width - self.detail.width - 24 - self.icon.right, 20};
    
    if(![self.subtitle.text isEqualToString:@""]) {
        self.subtitle.hidden = NO;
        self.title.y = 11;
    } else {
        self.subtitle.hidden = YES;
        self.title.y = 20;
    }
}

+ (CGSize) cellSizeWithModel:(id<CellViewModel>)m {
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width, 60);
}

- (void) updateWithModel:(id<CellViewModel>)model {
    self.title.text = model.title;
    self.detail.text = model.detail;
    if(model.subtitle) {
        self.subtitle.text = model.subtitle;
        self.subtitle.hidden = NO;
        self.title.y = 11;
    } else {
        self.subtitle.text = @"";
        self.subtitle.hidden = YES;
        self.title.y = 20;
    }
    [UIView configIconView:self.icon withModel:model];
    
    [UIView configLabel:self.title withStyle:model.titleStyle];
    [UIView configLabel:self.subtitle withStyle:model.subtitleStyle];
    [UIView configLabel:self.detail withStyle:model.detailStyle];
    [UIView configView:self.icon withStyle:model.iconStyle];
}

- (void) setupViews {
    self.title = [UIView titleStyleLabel];
    self.subtitle = [UIView subtitleStyleLabel];
    self.detail = [UIView detailStyleLabel];
    self.icon = [UIView smallIcon];
    self.detail.text = @"999999";
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.subtitle];
    [self.contentView addSubview:self.detail];
    [self.contentView addSubview:self.icon];
}

@end
