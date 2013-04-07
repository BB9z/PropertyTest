
#if __has_feature(objc_arc)
#   error Build this file with -fno-objc-arc build phase.
#endif


#import "NSObject+ARCDebug.h"

@implementation NSObject (ARCDebug)
- (NSUInteger)d_retainCount {
    return [self retainCount];
}

@end