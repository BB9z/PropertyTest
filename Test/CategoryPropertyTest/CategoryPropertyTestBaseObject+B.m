//
//  CategoryPropertyTestBaseObject+B.m
//  PropertyTest
//
//  Created by BB9z on 12/26/13.
//
//

#import "CategoryPropertyTestBaseObject+B.h"

static NSString *const CategoryModifiedProperty = @"CategoryPropertyTestBaseObject + B";

@implementation CategoryPropertyTestBaseObject (B)

- (NSString *)accessHiddenProperty {
    return CategoryModifiedProperty;
}

@end
