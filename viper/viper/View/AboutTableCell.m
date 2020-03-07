//
//  AboutTableCell.m
//  NONE
//
//  Created by none on 2020/2/10.
//  Copyright © 2020 NONE. All rights reserved.
//

#import <SDWebImage/SDWebImage.h>

#import "AboutTableCell.h"
#import "Core.h"
#import "UIView+Util.h"
#import "UIView+Geometry.h"

@interface AboutTableCell ()

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *subtitle;

@end

@implementation AboutTableCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        [self setupViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) prepareForReuse {
    [super prepareForReuse];
    
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.icon.origin = CGPointMake((self.contentView.width-self.icon.width)/2.0f, 10);
    self.title.frame = CGRectMake(0, self.icon.bottom+20, self.contentView.width, self.title.height);
    self.subtitle.frame = CGRectMake(0, self.title.bottom+6, self.contentView.width, self.subtitle.height);
}

+ (CGSize) cellSizeWithModel:(id)m {
    return CGSizeMake(0, 150);
}

- (void) updateWithModel:(id<CellViewModel>)model {
    self.title.text = model.title;
    self.subtitle.text = model.subtitle;
    self.icon.image = [UIImage imageNamed:model.icon];
}

- (void) setupViews {
    self.icon = [UIView largeIcon];
    self.title = [UIView titleStyleLabel];
    self.subtitle = [UIView subtitleStyleLabel];
    
    self.title.font = [UIFont boldSystemFontOfSize:20];
    self.subtitle.textColor = [UIColor blackColor];
    
    self.title.textAlignment = NSTextAlignmentCenter;
    self.subtitle.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.subtitle];
}

@end
