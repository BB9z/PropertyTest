
#import "SimpleLogger.h"

@interface SimpleLogger ()
@property (readwrite, strong, atomic) NSMutableString *buffer;
@property (assign, atomic) BOOL noticeFlag;
@end

@implementation SimpleLogger
+ (instancetype)sharedInstance {
	static SimpleLogger *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
	return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _buffer = [NSMutableString stringWithCapacity:256 * 1024];
    }
    return self;
}

- (void)log:(NSString *)string {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH':'mm':'ss'.'SSS"];
    });

    NSString *timeString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *logString = [NSString stringWithFormat:@"%@: %@", timeString, string];
    NSLog(@"%@", logString);
    @synchronized(self.buffer) {
        [self.buffer appendString:logString];
        [self noticeDelegate];
    }
}

- (void)clear {
    [self.buffer setString:@""];
    [self noticeDelegate];
}

- (void)noticeDelegate {
    if (self.noticeFlag) {
        return;
    }

    self.noticeFlag = YES;
    if ([self.delegate respondsToSelector:@selector(logger:bufferChanged:)]) {
        __weak __typeof(&*self)weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(&*weakSelf)strongSelf = weakSelf;
            [strongSelf.delegate logger:strongSelf bufferChanged:@""];
            strongSelf.noticeFlag = NO;
        });
    }
}

@end
