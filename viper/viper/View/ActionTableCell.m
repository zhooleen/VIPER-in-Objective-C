//
//  ActionTableCell.m
//  NONE
//
//  Created by none on 2020/2/10.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "ActionTableCell.h"
#import "UIView+Util.h"
#import "UIView+Geometry.h"

@implementation ActionTableCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.textLabel.text = @"...";
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = [UIFont systemFontOfSize:18];
    }
    return self;
}

+ (CGSize) cellSizeWithModel:(id<CellViewModel>)m {
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width, 60);
}

- (void) updateWithModel:(id<CellViewModel>)model {
    self.textLabel.text = model.title;
    [UIView configLabel:self.textLabel withStyle:model.titleStyle];
}



@end
