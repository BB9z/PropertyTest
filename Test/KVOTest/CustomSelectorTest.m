//
//  CustomSelecterTest.m
//  PropertyTest
//
//  Created by BB9z on 1/4/14.
//
//

#import <XCTest/XCTest.h>
#import "CustomSelectorObject.h"
#import "ViewController.h"

@interface CustomSelectorTest : XCTestCase

@end

@implementation CustomSelectorTest

- (void)setUp {
    [super setUp];

    printf("自定义 selector 测试\n\
---------------------\n\n");
}

- (void)tearDown {
    printf("\n");

    [super tearDown];
}

- (void)testAutoSynthesizedPropertyBehaviour {
    printf("自动生成的属性的 KVO 行为\n");

    // 通知接收到的次数
    __block int count;
    int lastCount;

    CustomSelectorObject *obj = [CustomSelectorObject new];
    NSNumber *number = @(1);

    count = 0;
    [obj rac_addObserver:self forKeyPath:@keypath(obj, propertyB) options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionPrior queue:nil block:^(id observer, NSDictionary *change) {
        count++;
        douto(change)
    }];

    printf("第一次设置\n");
    obj.propertyB = number;

    printf("重复设置\n");
    obj.propertyB = number;

    printf("另一次设置\n");
    obj.propertyB = @(2);

    XCTAssert(count == 7, @"通知应该发生7次");
    lastCount = count;

    printf("手写属性的 KVO 行为\n");
    count = 0;
    [obj rac_addObserver:self forKeyPath:@keypath(obj, propertyA) options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionPrior queue:nil block:^(id observer, NSDictionary *change) {
        count++;
        douto(change)
    }];

    printf("第一次设置\n");
    obj.propertyA = number;

    printf("重复设置\n");
    obj.propertyA = number;

    printf("另一次设置\n");
    obj.propertyA = @(2);

    XCTAssert(count == lastCount, @"两种写法的行为应该一致");
    lastCount = count;

    printf("无成员变量，空有 getter 和 setter 的属性的 KVO 行为\n");
    count = 0;
    [obj rac_addObserver:self forKeyPath:@keypath(obj, propertyC) options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionPrior queue:nil block:^(id observer, NSDictionary *change) {
        count++;
        douto(change)
    }];

    printf("第一次设置\n");
    obj.propertyC = number;

    printf("重复设置\n");
    obj.propertyC = number;

    printf("另一次设置\n");
    obj.propertyC = @(2);

    XCTAssert(count == lastCount, @"两种写法的行为应该一致");
}

@end
