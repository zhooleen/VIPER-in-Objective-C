//
//  AccountTableCell.m
//  NONE
//
//  Created by none on 2020/2/9.
//  Copyright © 2020 NONE. All rights reserved.
//
#import "AccountTableCell.h"
#import "Core.h"
#import "UIView+Util.h"
#import "UIView+Geometry.h"

@interface AccountTableCell ()

@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *nickname;
@property (strong, nonatomic) UILabel *mobile;

@end

@implementation AccountTableCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.avatar.x = 20;
    self.avatar.y = (self.contentView.height-self.avatar.height)/2.0;
    
    self.nickname.x = self.avatar.right + 8;
    self.mobile.x = self.nickname.x;
    
    self.nickname.y = self.contentView.height/2.0 - self.nickname.height - 2;
    self.mobile.y = self.nickname.bottom + 8;
    
    self.nickname.width = self.contentView.width - self.avatar.width - 20 - 16;
    self.mobile.width = self.nickname.width;
}

+ (CGSize) cellSizeWithModel:(id)m {
    return CGSizeMake(0, 100);
}

- (void) updateWithModel:(id<CellViewModel>)model {
    self.nickname.text = model.title;
    self.mobile.text = model.subtitle;
    self.avatar.image = [UIImage imageNamed:model.icon];
    if(model.event) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void) setupViews {
    self.avatar = [UIView largeIcon];
    self.nickname = [UIView titleStyleLabel];
    self.mobile = [UIView subtitleStyleLabel];
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.nickname];
    [self.contentView addSubview:self.mobile];
}

@end
