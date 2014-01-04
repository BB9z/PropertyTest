//
//  CategoryPropertyTestBaseObject+A.m
//  PropertyTest
//
//  Created by BB9z on 12/26/13.
//
//

#import "CategoryPropertyTestBaseObject+A.h"

static NSString *const CategoryModifiedProperty = @"CategoryPropertyTestBaseObject + A";

@interface CategoryPropertyTestBaseObject ()
@property (assign, nonatomic) int additionalPropertyInCategroy;
@end

@implementation CategoryPropertyTestBaseObject (A)

- (NSString *)accessHiddenProperty {
    return CategoryModifiedProperty;
}

@end
