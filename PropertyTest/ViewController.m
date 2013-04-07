//
//  ViewController.m
//  PropertyTest
//
//  Created by BB9z on 13-4-5.
//
//

#import "ViewController.h"
#import "dout.h"
#import "NSObject+ARCDebug.h"

@implementation Person
- (NSString *)unsafe_iVarString {
    return self->iVarString;
}

- (void)blockRetainTestIVar {
    __weak __typeof(&*self)weakSelf = self;
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        douts(@"\n\n* Block retain test: iVar")
        douto(weakSelf)
        NSString *str = iVarString;     // Cause retain cycle
        douto(str)
    });
}

- (void)blockRetainTestStrongSelf {
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        douts(@"\n\n* Block retain test: StrongSelf")
        douto(self)
    });
}

- (void)blockRetainTestPropertyWithWeakSelf {
    double delayInSeconds = 0.1;
    __weak __typeof(&*self)weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        douts(@"\n\n* Block retain test: Property with weakSelf")
        douto(weakSelf)
        douto(weakSelf.propertyString)
    });
}

- (void)strongPropertyStringTest {
    douts(@"\n\n* Strong property string test")
    
    @autoreleasepool {
        douts(@"\n-- Test: string change")
        NSMutableString *str = [NSMutableString stringWithString:@"S1"];
        
        self.strongPropertyString = str;
        self.propertyString = str;
        douto(self.strongPropertyString)
        douto(self.propertyString)
        
        douts(@"Now string was changed:")
        [str appendString:@" and something"];
        douto(self.strongPropertyString)
        douto(self.propertyString)
    }
    
    __weak NSString *weakStringRef = nil;
    
    douts(@"\n-- Memory Test: strong property")
    @autoreleasepool {
        weakStringRef = [NSString stringWithCString:"SS1" encoding:NSUTF8StringEncoding];
        self.strongPropertyString = weakStringRef;
    }
    douto(self.strongPropertyString)
    douto(weakStringRef)
    
    
    douts(@"\n-- Memory Test: copy property")
    weakStringRef = nil;
    @autoreleasepool {
        weakStringRef = [NSString stringWithCString:"SS2" encoding:NSUTF8StringEncoding];
        self.propertyString = weakStringRef;
    }
    douto(self.propertyString)
    douto(weakStringRef)
    
    
    douts(@"\n-- Memory Test: weak reference")
    weakStringRef = nil;
    @autoreleasepool {
        weakStringRef = [NSString stringWithCString:"SS3" encoding:NSUTF8StringEncoding];
    }
    douto(weakStringRef)
    
    
    douts(@"\n-- Memory Test: weak reference, but constant string")
    weakStringRef = nil;
    @autoreleasepool {
        weakStringRef = @"A constant string";
    }
    douto(weakStringRef)
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-redundant-literal-use"
    // Retain count test
    // 比较有意思的结果
    @autoreleasepool {
        douts(@"\n\n* Retain count test")

        dout_int([@"ConstantString" d_retainCount])
        
        NSString *stringInitFromString = [[NSString alloc] initWithString:@"Something"];    // 直接变成常量，并会产生警告
        douto(stringInitFromString)
        dout_int([stringInitFromString d_retainCount])
        
        dout_int([[[NSString alloc] initWithCString:"GGG" encoding:NSUTF8StringEncoding] d_retainCount])        // 1
        dout_int([[NSString stringWithFormat:@"%@", @"TTT"] d_retainCount])
        
        Person *aPerson = [[Person alloc] init];
        dout_int([aPerson d_retainCount])
    }
#pragma clang diagnostic pop
    
    
    // Block retain test: iVar
    // 错误的结果，在 block 中直接使用 iVar 会导致循环引用
    @autoreleasepool {
        Person *aPerson = [[Person alloc] init];
        aPerson->iVarString = @"TESTBLOCK: iVar";
        [aPerson blockRetainTestIVar];
    }
    
    
    // Block retain test: StrongSelf
    // 当然错误，不解释
    @autoreleasepool {
        Person *aPerson = [[Person alloc] init];
        aPerson->iVarString = @"TESTBLOCK: strongRef";
        [aPerson blockRetainTestStrongSelf];
    }
    
    
    // Block retain test: Property with weakSelf
    // 正确的结果，self 被正确释放了
    @autoreleasepool {
        Person *aPerson = [[Person alloc] init];
        aPerson.propertyString = @"TESTBLOCK: Property with weakSelf";
        [aPerson blockRetainTestPropertyWithWeakSelf];
    }
    
    
    // Strong property string test
    @autoreleasepool {
        Person *aPerson = [[Person alloc] init];
        [aPerson strongPropertyStringTest];
    }
}

@end
