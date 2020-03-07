//
//  AppStoreService.m
//  NONE
//
//  Created by none on 2020/2/9.
//  Copyright © 2020 NONE. All rights reserved.
//
#import <StoreKit/StoreKit.h>

#import "AppStoreService.h"
#import "ThirdPartyAPI.h"
#import "VIPEvent.h"

@interface AppStoreService ()

@property (strong, nonatomic) ThirdPartyAPI *request;

@end

@implementation AppStoreService

- (instancetype) init {
    if(self = [super init]) {
        _request = [[ThirdPartyAPI alloc] init];
    }
    return self;
}

- (void) queryVersionWithCallback:(ResultCallback)callback {
    [self.request request:[self urlRequest] callback:^(id<Result> result){
        if([kResultStatusSuccess isEqualToString:result.status]) {
            NSArray *results = [result.data objectForKey:@"results"];
            NSDictionary *info = [results objectAtIndex:0];
            NSString *version = [info objectForKey:@"version"];
            result.data = version;
            callback(result);
        } else {
            callback(result);
        }
    }];
}

/**
 给本应用评分
 */
- (void) rate {
    if(@available(iOS 10.3, *)) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        [SKStoreReviewController requestReview];
    } else {
        [self goToAppStore2];
    }
}

- (NSURLRequest*) urlRequest {
    //1025746703
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",self.appID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
    req.timeoutInterval = 60.0f;
    req.HTTPMethod = @"GET";
    return req;
}

- (void) gotoAppStore {
    NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/%@?mt=8",self.appID];
    NSURL *url = [NSURL URLWithString:urlString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (void) goToAppStore2 {
    NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/%@?mt=8&action=write-review",self.appID];
    NSURL *url = [NSURL URLWithString:urlString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

@end
