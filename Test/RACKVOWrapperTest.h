//
//  RACKVOWrapperTest.h
//  PropertyTest
//
//  Created by BB9z on 13-7-9.
//
//

#import <XCTest/XCTest.h>

@interface RACKVOWrapperTest : XCTestCase

@end

@interface TestObject : NSObject
@property(assign, nonatomic) int count;
@end

@interface RACTestObject : NSObject
@property(assign, nonatomic) int count;
@end


@interface RACTestSubclassObject : RACTestObject

@end



