#if __has_include("Quick7-Swift.h")
#import "Quick7-Swift.h"
#else
#import <Quick7/Quick7-Swift.h>
#endif

@interface AsyncSpec (testMethodSelectors)
@end

@implementation AsyncSpec (testMethodSelectors)

+ (NSArray<NSInvocation *> *)testInvocations {
    NSArray<NSString *> *selectors = [self darwinXCTestMethodSelectors];
    NSMutableArray<NSInvocation *> *invocations = [NSMutableArray arrayWithCapacity:selectors.count];

    for (NSString *selectorString in selectors) {
        SEL selector = NSSelectorFromString(selectorString);
        NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.selector = selector;

        [invocations addObject:invocation];
    }

    return invocations;
}

@end
