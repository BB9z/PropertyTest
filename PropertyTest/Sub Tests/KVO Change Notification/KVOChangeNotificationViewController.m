//
//  KVOChangeNotificationViewController.m
//  PropertyTest
//
//  Created by BB9z on 6/8/14.
//
//

#import "KVOChangeNotificationViewController.h"
#import "dout.h"
#import "SimpleLogger.h"
#import "RFPerformance.h"

#define DoutLogString(STR)\
[[SimpleLogger sharedInstance] log:[STR stringByAppendingString:@"\n"]]

static void *const KVOChangeNotificationViewControllerKVOContext = (void *)&KVOChangeNotificationViewControllerKVOContext;

@interface KVOChangeNotificationViewController ()
@end

@implementation KVOChangeNotificationViewController
RFAlloctionLog

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startTest];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // 完整的实现必须要判断 context，仅判断 keyPath 和 object 一致是不够的，因为子类/父类也可能观察相同的对象和键值
    if (context != KVOChangeNotificationViewControllerKVOContext) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }

    if ([keyPath isEqualToString:@"vaule"]) {
        // 为了简化代码，这里就不再判断 object 是否和自身观察的对象是否一致了
        dout(@"Recive change: %@", change);
        return;
    }

    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)startTest {
    [[SimpleLogger sharedInstance] clear];
    dout(@"KVO Change Notification Test\n----------------");

    NSString *keypath = @"vaule";
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew;
    void *context = KVOChangeNotificationViewControllerKVOContext;

    {
        KVOTestNormalPropertyObject *obj = [KVOTestNormalPropertyObject new];
        dout(@"Test for %@", obj.class);
        [obj addObserver:self forKeyPath:keypath options:options context:context];
        obj.vaule = 3;
        obj.vaule = 3;
        [obj removeObserver:self forKeyPath:keypath context:context];
        dout(@"")
    }

    {
        KVOTestUnequalAssignPropertyObject *obj = [KVOTestUnequalAssignPropertyObject new];
        dout(@"Test for %@", obj.class);
        [obj addObserver:self forKeyPath:keypath options:options context:context];
        obj.vaule = 5;
        obj.vaule = 5;
        [obj removeObserver:self forKeyPath:keypath context:context];
        dout(@"")
    }

    {
        KVOTestDirectAssignPropertyObject *obj = [KVOTestDirectAssignPropertyObject new];
        dout(@"Test for %@", obj.class);
        [obj addObserver:self forKeyPath:keypath options:options context:context];
        obj.vaule = 7;
        obj.vaule = 7;
        [obj removeObserver:self forKeyPath:keypath context:context];
        dout(@"")
    }

    {
        KVOTestDynamicPropertyObject *obj = [KVOTestDynamicPropertyObject new];
        dout(@"Test for %@", obj.class);
        [obj addObserver:self forKeyPath:keypath options:options context:context];
        obj.vaule = 7;
        obj.vaule = 7;
        [obj removeObserver:self forKeyPath:keypath context:context];
        dout(@"")
    }

    dout(@"以上结果的解释：")
    dout(@"当使用 KVO 观察某一对象时，系统会 method swizzle 相应属性的 selector，添加通知发送的调用，而不是在自动生成的属性方法中添加的。")

    {
        KVOTestDynamicPropertyObject *obj = [KVOTestDynamicPropertyObject new];
        dout(@"Test for %@", obj.class);
        [obj addObserver:self forKeyPath:keypath options:options context:context];
        obj.vaule = 11;
        obj.vaule = 11;
        [obj removeObserver:self forKeyPath:keypath context:context];
        dout(@"")
    }

    {
        KVOTestManualNotificationObject *obj = [KVOTestManualNotificationObject new];
        dout(@"Test for %@", obj.class);
        [obj addObserver:self forKeyPath:keypath options:options context:context];
        obj.vaule = 15;
        obj.vaule = 15;
        [obj removeObserver:self forKeyPath:keypath context:context];
        dout(@"")
    }
}

@end
