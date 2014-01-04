//
//  CustomSelectorObject.m
//  PropertyTest
//
//  Created by BB9z on 1/4/14.
//
//

#import "CustomSelectorObject.h"

static id CustomSelectorObjectPropertyC;

@interface CustomSelectorObject ()
@end

@implementation CustomSelectorObject
@synthesize propertyA = _propertyA;

- (NSNumber *)propertyA {
    return _propertyA;
}

- (void)setPropertyA:(NSNumber *)propertyA {
    // 这里 willChangeValueForKey/didChangeValueForKey 是不需要添加的
    // http://stackoverflow.com/a/3261294/945906
    if (_propertyA != propertyA) {
        _propertyA = propertyA;
    }
}

// propertyC 这么写跟自动生成属性的 KVO 行为也一致！
@dynamic propertyC;

- (NSNumber *)propertyC {
    return CustomSelectorObjectPropertyC;
}

- (void)setPropertyC:(NSNumber *)propertyC {
    CustomSelectorObjectPropertyC = propertyC;
}


@end

// 甚至在 category 中也一样
static id CustomSelectorObjectPropertyD;

@implementation CustomSelectorObject (KVOTest)

- (NSNumber *)propertyD {
    return CustomSelectorObjectPropertyD;
}

- (void)setPropertyD:(NSNumber *)propertyD {
    CustomSelectorObjectPropertyD = propertyD;
}

@end
