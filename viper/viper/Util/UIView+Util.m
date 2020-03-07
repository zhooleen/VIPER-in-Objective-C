//
//  UIView+Util.m
//  NONE
//
//  Created by none on 2020/2/7.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "UIView+Util.h"
#import <SDWebImage/SDWebImage.h>


@implementation UIView (Util)


+ (UILabel*) titleStyleLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0,0,0,20}];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:18];
    return label;
}

+ (UILabel*) subtitleStyleLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0,0,0,16}];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    return label;
}

+ (UILabel*) detailStyleLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0,0,0,16}];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:14];
    return label;
}
+ (UILabel*) textStyleLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0,0,0,18}];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:16];
    return label;
}

+ (UIImageView*) largeIcon {
    UIImageView *icon = [[UIImageView alloc] initWithFrame:(CGRect){0,0,60,60}];
    icon.image = [UIImage imageNamed:@"icon_avatar_large"];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    return icon;
}
+ (UIImageView*) normalIcon {
    UIImageView *icon = [[UIImageView alloc] initWithFrame:(CGRect){0,0,40,40}];
    icon.image = [UIImage imageNamed:@"icon_avatar_normal"];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    return icon;
}
+ (UIImageView*) smallIcon {
    UIImageView *icon = [[UIImageView alloc] initWithFrame:(CGRect){0,0,24,24}];
    icon.image = [UIImage imageNamed:@"icon_avatar_small"];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    return icon;
}

+ (UITableView*) tableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    [self configTableView:tableView];
    return tableView;
}

+ (UIButton*) buttonWithImage:(NSString*)named {
    UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){0,0,44,44}];
    [button setImage:[UIImage imageNamed:named] forState:(UIControlStateNormal)];
    return button;
}

+ (void) configTableView:(UITableView*)tableView {
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = [UIColor colorWithWhite:0xf0/255.0 alpha:1.0];
    tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, 0.01)];
    tableView.backgroundColor = [UIColor colorWithWhite:0xf0/255.0 alpha:1.0];
}

+ (void) configImageView:(UIImageView*)iv withModel:(id<CommonViewModel>)model {
    if (model.image) {
        iv.image = [UIImage imageNamed:model.image];
    } else if(model.imageUrl){
        [iv sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    }
}

+ (void) configIconView:(UIImageView*)iv withModel:(id<CommonViewModel>)model {
    if (model.icon) {
        iv.image = [UIImage imageNamed:model.icon];
    } else if(model.iconUrl){
        [iv sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    }
}

+ (void) configLabel:(UILabel*)label withStyle:(id<TextStyle>)style {
    if(label == nil || style == nil) {
        return;
    }
    if(style.color) {
        label.textColor = style.color;
    }
    if(style.font) {
        label.font = style.font;
    }
    [self configView:label withStyle:style];
}

+ (void) configView:(UIView*)view withStyle:(id<ViewStyle>)style {
    if(view == nil || style == nil) {
        return;
    }
    if(style.backgroundColor) {
        view.backgroundColor = style.backgroundColor;
    }
    if(style.borderStyle) {
        if(style.borderStyle.radius) {
            view.layer.cornerRadius = style.borderStyle.radius.doubleValue;
        }
        if(style.borderStyle.color) {
            view.layer.borderColor = style.borderStyle.color.CGColor;
        }
        if(style.borderStyle.width) {
            view.layer.borderWidth = style.borderStyle.width.doubleValue;
        }
    }
}

@end
