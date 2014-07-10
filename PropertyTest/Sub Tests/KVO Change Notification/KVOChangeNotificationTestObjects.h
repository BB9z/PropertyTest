//
//  KVOChangeNotificationTestObjects.h
//  PropertyTest
//
//  Created by BB9z on 6/13/14.
//
//

#import <Foundation/Foundation.h>

/// 自动生成的属性
@interface KVOTestNormalPropertyObject : NSObject
@property (assign, nonatomic) int vaule;
@end

/// 手写属性，仅当值不同时赋值
@interface KVOTestUnequalAssignPropertyObject : NSObject
@property (assign, nonatomic) int vaule;
@end

/// 手写属性，直接赋值，不做检查
@interface KVOTestDirectAssignPropertyObject : NSObject
@property (assign, nonatomic) int vaule;
@end

/// 非自动生成属性，手写 selector
@interface KVOTestDynamicPropertyObject : NSObject
@property (assign, nonatomic) int vaule;
@property (assign, nonatomic) int trueVaule;
@end

/// 手动发送通知的正确实现，仅当值不同时赋值并发送通知
@interface KVOTestManualNotificationObject : NSObject
@property (assign, nonatomic) int vaule;
@end

