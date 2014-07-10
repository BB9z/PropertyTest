
#import "KVOChangeNotificationTestObjects.h"
#import "RFRuntime.h"

@implementation KVOTestNormalPropertyObject
@end

@implementation KVOTestUnequalAssignPropertyObject

- (void)setVaule:(int)vaule {
    if (_vaule != vaule) {
        _vaule = vaule;
    }
}

@end

@implementation KVOTestDirectAssignPropertyObject

- (void)setVaule:(int)vaule {
    _vaule = vaule;
}

@end

@implementation KVOTestDynamicPropertyObject
@dynamic vaule;

- (int)vaule {
    return _trueVaule;
}

- (void)setVaule:(int)vaule {
    _trueVaule = vaule;
}

@end

@implementation KVOTestManualNotificationObject

+ (BOOL)automaticallyNotifiesObserversOfVaule {
    return NO;
}

- (void)setVaule:(int)vaule {
    if (_vaule != vaule) {
        [self willChangeValueForKey:@keypath(self, vaule)];
        _vaule = vaule;
        [self didChangeValueForKey:@keypath(self, vaule)];
    }
}

@end

