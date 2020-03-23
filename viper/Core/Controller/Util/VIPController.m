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
@property (strong, nonatomic) NSMutableDictionary *observers;
@end

@implementation VIPController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _resultMapping = [[SelectorMapping alloc] init];
        _observers = [NSMutableDictionary dictionaryWithCapacity:16];

    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _resultMapping = [[SelectorMapping alloc] init];
        _observers = [NSMutableDictionary dictionaryWithCapacity:16];
    }
    return self;
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _resultMapping = [[SelectorMapping alloc] init];
        _observers = [NSMutableDictionary dictionaryWithCapacity:16];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideBackBarButtonItemTitle];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
}

- (BOOL) prefersStatusBarHidden {
    return self.statusBarHidden;
}

#pragma mark - VIPER

- (UIViewController*) routeSource {
    return self;
}
                       
- (void) receiveResult:(id<Result>)result {
    if([kEventCalback isEqualToString:result.name]) {
        [self.handler handleEvent:result];
    }
    [self.resultMapping receiveResult:result forReceiver:self];
}

- (void) handleEvent:(id<Event>)event {
    if([kEventInitialize isEqualToString:event.name]) {
        [self.handler handleEvent:event];
    }
}

#pragma mark - UTIL

- (void) setStatusBarHidden:(BOOL)hidden {
    _statusBarHidden = hidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void) hideBackBarButtonItemTitle {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
}

- (void) exit {
    [self removeAllObservers];
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

#pragma mark - Notification

- (void) addObserverForNotificationName:(NSString*)name {
    __weak typeof(self) that = self;
    NSObject *observer = [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(that) this = that;
        NSObject *data = note.object;
        id<Event> event = [Event eventWithName:name data:data];
        [this.handler handleEvent:event];
    }];
    [self.observers setObject:observer forKey:name];
}

- (void) removeObserverForNotificationName:(NSString*)name {
    NSObject *object = [self.observers objectForKey:name];
    if(object) {
        [[NSNotificationCenter defaultCenter] removeObserver:object];
        [self.observers removeObjectForKey:name];
    }
}

- (void) removeAllObservers {
    for (NSObject* obj in self.observers.copy) {
        [[NSNotificationCenter defaultCenter] removeObserver:obj];
    }
    [self.observers removeAllObjects];
}

- (void) dealloc {
    [self removeAllObservers];
}

@end
