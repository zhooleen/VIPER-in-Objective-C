//
//  VIPTableDelegate.h
//  viper
//
//  Created by zlpro on 2020/3/24.
//  Copyright © 2020 None. All rights reserved.
//

#import "Cell.h"
#import "Animating.h"

@interface VIPTableDelegate : NSObject <UITableViewDelegate, UITableViewDataSource, CellDelegate>

@property (strong, nonatomic) id<PageViewModel> page;

@property(weak, nonatomic) id<CellDelegate> delegate;

@end

