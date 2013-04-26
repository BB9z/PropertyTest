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

#define NSLog(...)\
printf("%s\n", [[NSString stringWithFormat:__VA_ARGS__] UTF8String])

@implementation Person
@synthesize copyedPropertyString = _copyedPropertyString;
@synthesize strongPropertyString = _strongPropertyString;
@synthesize weakPropertyString = _weakPropertyString;

- (NSString *)unsafe_iVarString {
    return self->iVarString;
}

- (void)strongPropertyStringTest {
    printf("\n* Strong property string test\n\n");
    
    @autoreleasepool {
        printf("-- Test: string change\n");
        NSMutableString *str = [NSMutableString stringWithString:@"S1"];
        
        self.strongPropertyString = str;
        printf("Set strong property: ");
        douto(self.strongPropertyString)
        
        self.copyedPropertyString = str;
        printf("Set copyed property: ");
        douto(self.copyedPropertyString)

        printf("\nChange string:\n");
        [str appendString:@" and something"];
        
        douto(self.strongPropertyString);
        douto(self.copyedPropertyString);
    }
    
    __weak NSString *weakStringRef = nil;
    
    printf("\n-- Memory Test: strong property\n");
    @autoreleasepool {
        weakStringRef = [NSString stringWithCString:"SS1" encoding:NSUTF8StringEncoding];
        self.strongPropertyString = weakStringRef;
    }
    douto(self.strongPropertyString)
    douto(weakStringRef)
    
    
    printf("\n-- Memory Test: copy property\n");
    weakStringRef = nil;
    @autoreleasepool {
        weakStringRef = [NSString stringWithCString:"SS2" encoding:NSUTF8StringEncoding];
        self.copyedPropertyString = weakStringRef;
    }
    douto(self.copyedPropertyString)
    douto(weakStringRef)
    
    
    printf("\n-- Memory Test: weak reference\n");
    weakStringRef = nil;
    @autoreleasepool {
        weakStringRef = [NSString stringWithCString:"SS3" encoding:NSUTF8StringEncoding];
    }
    douto(weakStringRef)
    
    
    printf("\n-- Memory Test: weak reference, but constant string\n");
    weakStringRef = nil;
    @autoreleasepool {
        weakStringRef = @"A constant string";
    }
    douto(weakStringRef)
}

- (void)iVarAccessTest {
    printf("\n* Property vs. iVar access test\n");
    
    printf("\n");
    @autoreleasepool {
        NSString *className = NSStringFromClass([self class]);
        _copyedPropertyString = className;
        _copyedPropertyString = className;
    }
    douto(_copyedPropertyString)
    dout_int([_copyedPropertyString d_retainCount])
    
    printf("\n");
    @autoreleasepool {
        NSString *className = NSStringFromClass([self class]);
        _strongPropertyString = className;
        _strongPropertyString = className;
    }
    douto(_strongPropertyString)
    dout_int([_strongPropertyString d_retainCount])
    
    printf("\n");
    @autoreleasepool {
        NSString *className = NSStringFromClass([self class]);
        _weakPropertyString = className;
        _weakPropertyString = className;
    }
    douto(_weakPropertyString)
    dout_int([_weakPropertyString d_retainCount])
    
    _strongPropertyString = nil;
    _copyedPropertyString = nil;
    _weakPropertyString = nil;
    
    printf("\n");
    @autoreleasepool {
        self.copyedPropertyString = NSStringFromClass([self class]);
    }
    douto(self.copyedPropertyString)
    dout_int([self.copyedPropertyString d_retainCount])
    
    printf("\n");
    @autoreleasepool {
        self.strongPropertyString = NSStringFromClass([self class]);
    }
    douto(self.strongPropertyString)
    dout_int([self.strongPropertyString d_retainCount])
    
    printf("\n");
    @autoreleasepool {
        self.weakPropertyString = NSStringFromClass([self class]);
    }
    douto(self.weakPropertyString)
    dout_int([self.weakPropertyString d_retainCount])
}


- (void)blockRetainTestIVar {
    __weak __typeof(&*self)weakSelf = self;
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        printf("\n* Block retain test: iVar\n");
        douto(weakSelf)
        NSString *str = iVarString;     // Cause retain cycle
        douto(str)
    });
}

- (void)blockRetainTestStrongSelf {
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        printf("\n* Block retain test: StrongSelf\n");
        douto(self)
    });
}

- (void)blockRetainTestPropertyWithWeakSelf {
    double delayInSeconds = 0.1;
    __weak __typeof(&*self)weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        printf("\n* Block retain test: Property with weakSelf\n");
        douto(weakSelf)
        douto(weakSelf.copyedPropertyString)
    });
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
        printf("\n* Retain count test\n");

        NSString *constantString = @"Example1";
        douto(constantString)
        dout_int([constantString d_retainCount])                         // -1
        printf("\n");
        
        NSString *stringInitFromString = [[NSString alloc] initWithString:@"Example2"];    // 直接变成常量，并会产生警告
        douto(stringInitFromString)
        dout_int([stringInitFromString d_retainCount])                      // -1
        printf("\n");
        
        dout_int([[[NSString alloc] initWithCString:"GGG" encoding:NSUTF8StringEncoding] d_retainCount])        // 1
        dout_int([[NSString stringWithFormat:@"%@", @"TTT"] d_retainCount]) // 2
        printf("\n");
        
        Person *aPerson = [[Person alloc] init];
        dout_int([aPerson d_retainCount])                                   // 1

    }
#pragma clang diagnostic pop
    
    // Strong property string test
    @autoreleasepool {
        Person *aPerson = [[Person alloc] init];
        [aPerson strongPropertyStringTest];
    }
    
    
    // Strong property ivar access test
    @autoreleasepool {
        Person *aPerson = [[Person alloc] init];
        [aPerson iVarAccessTest];
    }
    
    
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
        aPerson.copyedPropertyString = @"TESTBLOCK: Property with weakSelf";
        [aPerson blockRetainTestPropertyWithWeakSelf];
    }
}

@end
