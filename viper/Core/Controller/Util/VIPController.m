//
//  VIPController.m
//  VIPER
//
//  Created by zhooleen on 2020/1/21.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "VIPController.h"
#import "VIPEvent.h"

@interface VIPController ()
@property (assign, nonatomic) BOOL statusBarHidden;
@end

@implementation VIPController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _resultMapping = [[SelectorMapping alloc] init];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _resultMapping = [[SelectorMapping alloc] init];
    }
    return self;
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _resultMapping = [[SelectorMapping alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideBackBarButtonItemTitle];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
//    [self sendEvent:kEventViewDidLoad];
}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self sendEvent:kEventViewWillAppear];
//}
//
//- (void) viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self sendEvent:kEventViewDidAppear];
//}
//
//- (void) viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self sendEvent:kEventViewWillDisappear];
//}
//
//- (void) viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    [self sendEvent:kEventViewDidDisappear];
//}

- (BOOL) prefersStatusBarHidden {
    return self.statusBarHidden;
}
                       
- (void) receiveResult:(id<Result>)result {
    SEL sel = [self.resultMapping selectorForKey:result.name];
    if(sel && [self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void(*func)(id, SEL, id<Result>) = (void *)imp;
        func(self, sel, result);
    }
}

- (void) setStatusBarHidden:(BOOL)hidden {
    _statusBarHidden = hidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void) hideBackBarButtonItemTitle {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
}

- (void) exit {
    if(self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) sendEvent:(NSString*)name {
    if(self.handler) {
        Event *event = [Event eventWithName:name];
        [self.handler handleEvent:event];
    }
}

- (void) sendEvent:(NSString*)name withData:(id)data {
    if(self.handler) {
        Event *event = [Event eventWithName:name data:data];
        [self.handler handleEvent:event];
    }
}

- (id<DataReceiver>) initialReceiver {
    if(self.handler && [self.handler conformsToProtocol:@protocol(DataReceiver)]) {
        return (id<DataReceiver>)self.handler;
    }
    return (id<DataReceiver>)self;
}

- (id<DataReceiver>) callbackReceiver {
    if(self.handler && [self.handler conformsToProtocol:@protocol(DataReceiver)]) {
        return (id<DataReceiver>)self.handler;
    }
    return (id<DataReceiver>)self;
}

- (void) receiveInitialData:(id)data {
    
}

- (void) receiveCallbackData:(id)data {
    
}

@end
