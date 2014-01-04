
#import "CategoryPropertyTestBaseObject.h"

@interface CategoryPropertyTestBaseObject ()
@property (copy, nonatomic) NSString *hiddenProperty;
@end

@implementation CategoryPropertyTestBaseObject

- (id)init {
    self = [super init];
    if (self) {
        self.hiddenProperty = @"Hidden";
    }
    return self;
}

- (NSString *)accessHiddenProperty {
    douto(self.hiddenProperty)
    return self.hiddenProperty;
}

@end
