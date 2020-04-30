//
//  AboutPresenter.m
//  NONE
//
//  Created by none on 2020/2/10.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "AboutPresenter.h"
#import "AppStoreService.h"
#import "EventNames.h"

@implementation AboutPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.eventMapping registerSelector:@selector(setupPageModel:) forKey:kEventViewDidLoad];
    }
    return self;
}

- (void) setupPageModel:(id<Event>)event {

    NSDictionary *model1 = @{@"reuseIdentifier":@"BasicTableCell",
                            @"icon":@"icon_upgrade",
                            @"title":@"升级",
                             @"event":kEventGoToAppStore.event
    };
    
    NSDictionary *model2 = @{@"reuseIdentifier":@"BasicTableCell",
                            @"icon":@"icon_rate",
                            @"title":@"评分",
                             @"event":kEventAppStoreRate.event
    };
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    version = [NSString stringWithFormat:@"Version %@", version];
    NSDictionary *user = @{@"reuseIdentifier":@"AboutTableCell",
                           @"icon":@"AppIcon",
                           @"title":@"DEMO",
                           @"subtitle":version
    };
    
    id<SectionViewModel> area1 = @{}.proxy;
    area1.models = @[user.proxy];
    
    id<SectionViewModel> area2 = @{}.proxy;
    area2.models = @[model2.proxy, model1.proxy];

    
    id<PageViewModel> page = @{}.proxy;
    page.sections = @[area1, area2];
    
    id<Result> result = [Result resultWithName:kEventViewDidLoad data:page];
    [self.receiver receiveResult:result];
}

@end

