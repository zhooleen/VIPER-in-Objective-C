//
//  AccountPresenter.m
//  NONE
//
//  Created by none on 2020/1/22.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "AccountPresenter.h"
#import "EventNames.h"

@implementation AccountPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.eventMapping registerSelector:@selector(setupPageModel:) forKey:kEventViewDidLoad];
    }
    return self;
}

- (void) setupPageModel:(id)obj {

    NSDictionary *model1 = @{@"reuseIdentifier":@"BasicTableCell",
                            @"icon":@"icon_settings",
                            @"title":@"设置",
                             @"event":kRoute2Settings.event
    };
    
    NSDictionary *model2 = @{@"reuseIdentifier":@"BasicTableCell",
                            @"icon":@"icon_about",
                            @"title":@"关于",
                             @"event":kRoute2About.event
    };

    
    NSString *name = @"孤独的旅行者";
    NSString *mobile = @"131-1313-1313";
    NSDictionary *user = @{@"reuseIdentifier":@"AccountTableCell",
                           @"title":name,
                           @"subtitle":mobile,
                           @"icon":@"icon_avatar_large"
    };
    
    id<SectionViewModel> area1 = @{}.proxy;
    area1.models = @[user.proxy];

    id<SectionViewModel> area3 = @{}.proxy;
    area3.models = @[model2.proxy, model1.proxy];
    
    id<PageViewModel> page = @{}.proxy;
    page.sections = @[area1, area3];
    
    id<Result> result = [Result resultWithName:kEventViewDidLoad data:page];
    [self.receiver receiveResult:result];
}

@end
