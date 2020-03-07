//
//  ThirdPartyAPI.m
//  NONE
//
//  Created by lz on 2019/9/8.
//  Copyright © 2019年 NONE. All rights reserved.
//

#import "ThirdPartyAPI.h"
#import "VIPEvent.h"

@interface ThirdPartyAPI () <NSURLSessionDelegate> {
    
    NSURLSession *_session;
    NSMutableDictionary *_tasks;
    dispatch_queue_t _queue;
    
}
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSMutableDictionary *tasks;
@property (strong, nonatomic) dispatch_queue_t queue;
@end


@implementation ThirdPartyAPI


- (instancetype) init {
    self = [super init];
    if(self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        _queue = dispatch_get_main_queue();
        _tasks = [NSMutableDictionary dictionaryWithCapacity:32];
    }
    return self;
}

- (void) request:(NSURLRequest *)request callback:(ResultCallback)callback {
    
    [self removeTaskForURL:request.URL];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error){
        if(error) {
            if(callback) {
                
                id<Result> result = [[Result alloc] init];
                result.status = kResultStatusError;
                callback(result);
            }
        } else {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if(callback) {
                id<Result> result = [[Result alloc] init];
                result.status = kResultStatusSuccess;
                result.data = json;
                callback(result);
            }
        }
    }];
    [self addTask:task forURL:request.URL];
    [task resume];
}

- (void) addTask:(NSURLSessionDataTask*)task forURL:(NSURL*)url {
    if(task == nil || url == nil) {
        return;
    }
    [self.tasks setObject:task forKey:url.absoluteString];
}

- (void) removeTaskForURL:(NSURL*)url {
    if(url) {
        NSURLSessionDataTask *task = [self tasks][url];
        if(task) {
            [task cancel];
            [self.tasks removeObjectForKey:url.absoluteString];
        }
    }
}

@end
