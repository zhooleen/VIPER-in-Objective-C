//
//  ModelProxy.m
//  Run
//
//  Created by none on 07/12/2019.
//  Copyright © 2019 NONE. All rights reserved.
//

#import "ModelProxy.h"


@interface MLProxy : NSProxy
@property (strong, nonatomic) NSMutableDictionary *json;
- (instancetype) initWithDictionary:(NSDictionary*)json;
@end

@implementation NSDictionary (ModelProxy)
- (id) proxy {
    return [[MLProxy alloc] initWithDictionary:self];
}
@end



@implementation MLProxy

- (instancetype) initWithDictionary:(NSDictionary*)json {
    _json = json.mutableCopy;
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    SEL newSel = nil;
    NSString *name = NSStringFromSelector(aSelector);
    if([name hasPrefix:@"set"]) {
        newSel = @selector(setObject:forKey:);
    } else {
        newSel = @selector(objectForKey:);
    }
    NSMethodSignature *sig = [self.json methodSignatureForSelector:newSel];
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *selName = NSStringFromSelector(invocation.selector);
    
    if([selName hasPrefix:@"set"]) {
        NSString *tail = [selName substringFromIndex:4];
        NSString *first = [selName substringWithRange:(NSRange){3,1}];
        NSString *name = [NSString stringWithFormat:@"%@%@", first.lowercaseString, tail];
        
        name = [name stringByReplacingOccurrencesOfString:@":" withString:@""];
        invocation.selector = @selector(setObject:forKey:);
        [invocation setArgument:&name atIndex:3]; // self, _cmd, obj, key
        
    } else {
        
        invocation.selector = @selector(objectForKey:);
        [invocation setArgument:&selName atIndex:2]; // self, _cmd, key
    }
    
    [invocation invokeWithTarget:self.json];
}

@end

