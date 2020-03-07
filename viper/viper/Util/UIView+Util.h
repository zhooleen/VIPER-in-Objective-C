//
//  UIView+Util.h
//  NONE
//
//  Created by none on 2020/2/7.
//  Copyright © 2020 NONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Core.h"

@interface UIView (Util)

+ (UILabel*) titleStyleLabel;
+ (UILabel*) subtitleStyleLabel;
+ (UILabel*) detailStyleLabel;
+ (UILabel*) textStyleLabel;

+ (UIImageView*) largeIcon;
+ (UIImageView*) normalIcon;
+ (UIImageView*) smallIcon;

+ (UIButton*) buttonWithImage:(NSString*)named;

+ (UITableView*) tableView;
+ (void) configTableView:(UITableView*)tableView;

+ (void) configIconView:(UIImageView*)iv withModel:(id<CommonViewModel>)model;
+ (void) configImageView:(UIImageView*)iv withModel:(id<CommonViewModel>)model;

+ (void) configLabel:(UILabel*)label withStyle:(id<TextStyle>)style;
+ (void) configView:(UIView*)view withStyle:(id<ViewStyle>)style;

@end

