//
//  SettingsPresenter.m
//  NONE
//
//  Created by none on 2020/2/10.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "SettingsPresenter.h"
#import "EventNames.h"

@implementation SettingsPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.eventMapping registerSelector:@selector(setupPageModel:) forKey:kEventViewDidLoad];
    }
    return self;
}

- (void) setupPageModel:(id)obj {

    NSDictionary *model1 = @{@"reuseIdentifier":@"ActionTableCell",
                            @"title":@"切换用户",
                             @"event":kEventSwitchUser.event
    };
    
    NSDictionary *model2 = @{@"reuseIdentifier":@"ActionTableCell",
                            @"title":@"退出登录",
                             @"event":kEventSignOut.event
    };
    
    id<SectionViewModel> area1 = @{}.proxy;
    area1.models = @[model1.proxy];
    
    id<SectionViewModel> area2 = @{}.proxy;
    area2.models = @[model2.proxy];
    
    id<PageViewModel> page = @{}.proxy;
    page.sections = @[area1, area2];
    
    id<Result> result = [Result resultWithName:kEventViewDidLoad data:page];
    [self.receiver receiveResult:result];
}

@end
