//
//  AboutInteractor.m
//  NONE
//
//  Created by none on 2020/2/10.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "AboutInteractor.h"
#import "AppStoreService.h"
#import "EventNames.h"

@interface AboutInteractor ()
@property (strong, nonatomic) AppStoreService *service;
@end

@implementation AboutInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        _service = [[AppStoreService alloc] init];
        [self.eventMapping registerSelector:@selector(rate:) forKey:kEventAppStoreRate];
        [self.eventMapping registerSelector:@selector(gotoAppStore:) forKey:kEventGoToAppStore];
    }
    return self;
}

- (void) rate:(id<Event>)event {
    [self.service rate];
}

- (void) gotoAppStore:(id<Event>)event {
    [self.service gotoAppStore];
}

@end
