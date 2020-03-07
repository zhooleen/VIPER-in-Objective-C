//
//  AccountRouter.m
//  NONE
//
//  Created by none on 2020/1/22.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "AccountRouter.h"
#import "EventNames.h"

@interface AccountRouter ()
@property (strong, nonatomic) VIPBuilder *builder;
@end

@implementation AccountRouter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _builder = [[VIPBuilder alloc] init];
        _builder.router = self;
    }
    return self;
}

- (BOOL) canRoute:(id<Event>)event {
    NSArray *names = @[kRoute2About,
                       kRoute2Settings];
    if([names containsObject:event.name]) {
        return YES;
    }
    return NO;
}

- (void)present:(id<Event>)event from:(UIViewController<View> *)controller {
    UIViewController *target = [self targetController:event from:controller];
    if(target) {
        [controller presentViewController:target animated:YES completion:nil];
    } else {
        [[VIPRouter router] present:event from:controller];
    }
}

- (void)push:(id<Event>)event from:(UIViewController<View> *)controller {
    UIViewController *target = [self targetController:event from:controller];
    if(target) {
        target.hidesBottomBarWhenPushed = YES;
        [controller.navigationController pushViewController:target animated:YES];
    } else {
        [[VIPRouter router] push:event from:controller];
    }
}

- (void) route:(id<Event>)event from:(UIViewController<View> *)controller {
    if(controller.navigationController) {
        [self push:event from:controller];
    } else {
        [self present:event from:controller];
    }
}

- (UIViewController*) targetController:(id<Event>)event from:(UIViewController<View> *)controller{
    self.builder.storyboard = nil;
    self.builder.initialData = nil;
    if([kRoute2About isEqualToString:event.name]) {
        self.builder.prefix = @"About";
    } else if([kRoute2Settings isEqualToString:event.name]) {
        self.builder.prefix = @"Settings";
    }
    else {
        return nil;
    }
    self.builder.initialData = event.data;
    self.builder.previous = controller;
    UIViewController *target = [self.builder build];
    return target;
}

@end
