//
//  RACKVOWrapperTest.m
//  PropertyTest
//
//  Created by BB9z on 13-7-9.
//
//

#import "RACKVOWrapperTest.h"
#import "dout.h"
#import "NSObject+ARCDebug.h"

static void *const TestKVOContext = (void *)&TestKVOContext;

@implementation RACKVOWrapperTest

- (void)testSubclassObserver {
    __weak RACTestSubclassObject *weakRef = nil;
    
    @autoreleasepool {
        RACTestSubclassObject *obj = [[RACTestSubclassObject alloc] init];
        obj.count = 1;
        obj.count = 2;
        weakRef = obj;
    }
}

- (void)testTraditionalKVORetainTest {
    __weak TestObject *weakRef;
    @autoreleasepool {
        TestObject *obj = [[TestObject alloc] init];
        [obj addObserver:self forKeyPath:@keypath(obj, count) options:NSKeyValueObservingOptionNew context:NULL];
        obj.count = 1;
        weakRef = obj;
        dout_int([obj d_retainCount]);
        [obj removeObserver:self forKeyPath:@keypath(obj, count)];
    }
    STAssertNil(weakRef, @"Tradition KVO not retain observer, but you must remove observer");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    douto(change)
}

@end

@implementation TestObject

+ (id)alloc {
    doutwork();
    return [super alloc];
}

- (void)dealloc {
    doutwork()
}

@end

@implementation RACTestObject

+ (id)alloc {
    doutwork();
    return [super alloc];
}

- (id)init {
    self = [super init];
    if (self) {
        @weakify(self)
        [self rac_addObserver:self forKeyPath:@keypath(self, count) options:NSKeyValueObservingOptionNew queue:nil block:^(id observer, NSDictionary *change) {
            @strongify(self)
            dout(@"Catch change in rootclass, count = %d", self.count);
        }];
    }
    return self;
}

- (void)dealloc {
    doutwork()
}

@end

@implementation RACTestSubclassObject

- (id)init {
    self = [super init];
    if (self) {
        @weakify(self);
        [self rac_addObserver:self forKeyPath:@keypath(self, count) options:NSKeyValueObservingOptionNew queue:nil block:^(id observer, NSDictionary *change) {
            @strongify(self);
            dout(@"Catch change in subclass, count = %d", self.count);
        }];
    }
    return self;
}

@end
