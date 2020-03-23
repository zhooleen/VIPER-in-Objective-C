//
//  VIPBuilder.m
//  VIPER
//
//  Created by zhooleen on 2020/2/10.
//  Copyright © 2020 VIPER. All rights reserved.
//

#import "VIPBuilder.h"
#import "View.h"
#import "Presenter.h"
#import "Interactor.h"
#import "Router.h"
#import "VIPPresenter.h"
#import "VIPInteractor.h"
#import "VIPRouter.h"
#import "Logger.h"
#import "VIPEvent.h"

@implementation VIPBuilder

- (UIViewController<View>*) build {
    if(self.router == nil) {
        self.router = [VIPRouter router];
    }
    
    //构建VIP结构
    
    
    UIViewController<View> *view = [self viewWithPrefix:self.prefix storyboard:self.storyboard];
    id<Presenter> presenter = [self presenterWithPrefix:self.prefix];
    id<Interactor> interactor = [self interactorWithPrefix:self.prefix];
    
    /**
     建立中间件链
     */
    id<Middleware> first;//第一个中间件
    id<Middleware> last; //最后一个中间件
#if DEBUG
    first = [[Logger alloc] init];
    last = [[Logger alloc] init];
    first.handler = presenter;
    presenter.handler = last;
    last.receiver = presenter;
    presenter.receiver = first;
#else
    first = presenter;
    last = presenter;
#endif
    
    view.handler = first;
    last.handler = interactor;
    
    interactor.receiver = last;
    first.receiver = view;

    
    presenter.router = self.router;
    presenter.view = view;
    
    //VIP参数初始化
    if(self.initialData) {
        id<Event> event = [Event eventWithName:kEventInitialize data:self.initialData];
        [view handleEvent:event];
    }
    
    //VIP参数回调
    if(self.previous) {
        view.receiver = self.previous;
    }
    
    return view;
}


- (UIViewController<View>*) viewWithPrefix:(NSString*)prefix storyboard:(NSString*)sbname{
    NSString *name = [NSString stringWithFormat:@"%@Controller", prefix];
    UIViewController<View>* vc = nil;
    if(sbname == nil) {
        Class klass = NSClassFromString(name);
        vc = [[klass alloc] init];
    } else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:sbname bundle:nil];
        vc = [sb instantiateViewControllerWithIdentifier:name];
    }
    return vc;
}

- (id<Presenter>) presenterWithPrefix:(NSString*)prefix {
    NSString *name = [NSString stringWithFormat:@"%@Presenter", prefix];
    Class klass = NSClassFromString(name);
    if(klass == nil) {
        klass = [VIPPresenter class];
    }
    id<Presenter> obj = [[klass alloc] init];
    return obj;
}

- (id<Interactor>) interactorWithPrefix:(NSString*)prefix {
    NSString *name = [NSString stringWithFormat:@"%@Interactor", prefix];
    Class klass = NSClassFromString(name);
    if(klass == nil) {
        klass = [VIPInteractor class];
    }
    id<Interactor> vc = [[klass alloc] init];
    return vc;
}

- (id<Router>) routerWithPrefix:(NSString*)prefix {
    NSString *name = [NSString stringWithFormat:@"%@Router", prefix];
    id<Router> router = [[VIPRouter router] routerOfClass:name];
    if(router == nil) {
        router = [VIPRouter router];
    }
    return router;
}

+ (UIViewController<View>*) buildWithPrefix:(NSString*)prefix router:(id<Router>)router {
    VIPBuilder *builder = [[VIPBuilder alloc] init];
    builder.prefix = prefix;
    builder.router = router;
    return [builder build];
}

@end
