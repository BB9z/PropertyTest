//
//  CategoryPropertyTest.m
//  PropertyTest
//
//  Created by BB9z on 12/25/13.
//
//

#import <XCTest/XCTest.h>
#import "CategoryPropertyTestBaseObject.h"
#import "CategoryPropertyTestBaseObject+A.h"
#import "CategoryPropertyTestBaseObject+B.h"

@interface CategoryPropertyTest : XCTestCase
@property (strong, nonatomic) CategoryPropertyTestBaseObject *testObject;
@end

@implementation CategoryPropertyTest

- (void)setUp {
    [super setUp];
    self.testObject = CategoryPropertyTestBaseObject.new;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCategoryMethodOverwrite {
    id oo = [self.testObject accessHiddenProperty];
    douto(oo)
}

- (void)testAdditionalPropertyInCategroy {

    XCTAssertThrows((self.testObject.additionalPropertyInCategroy = 20), @"Cannot ");
    ;
}

@end
