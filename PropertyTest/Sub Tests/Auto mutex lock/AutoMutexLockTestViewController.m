
#import "AutoMutexLockTestViewController.h"
#import "dout.h"
#import "SimpleLogger.h"

#define DoutLogString(STR)\
[[SimpleLogger sharedInstance] log:[STR stringByAppendingString:@"\n"]]

static long LockTestRunCount;

/// 简单的终止队列标志
static BOOL LockTestEndFlag;

@interface AutoMutexLockTestViewController ()
@property (nonatomic, strong) dispatch_queue_t backgroundQueue;
@end

@implementation AutoMutexLockTestViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    // 并行队列
    self.backgroundQueue = dispatch_queue_create("Test Lock", DISPATCH_QUEUE_CONCURRENT);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LockTestEndFlag = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    LockTestEndFlag = YES;
}

- (IBAction)onClearLog:(id)sender {
    [[SimpleLogger sharedInstance] clear];
}

#define MakeTestSelector(TEST_NUMBER, WORKER_COUNT, LOOP_COUNT)\
    - (IBAction)onTest ## TEST_NUMBER:(UIButton *)sender {\
        sender.enabled = NO;\
        dispatch_group_t group = dispatch_group_create();\
        for (int l = 0; l < WORKER_COUNT; l++) {\
            dispatch_group_enter(group);\
            dispatch_async(self.backgroundQueue, ^{\
                for (int i = 0; i < LOOP_COUNT; i++) {\
                    if (LockTestEndFlag) break;\
                    [self doTask ## TEST_NUMBER];\
                }\
                dispatch_group_leave(group);\
            });\
        }\
        dispatch_async(self.backgroundQueue, ^{\
            dispatch_group_wait(group, DISPATCH_TIME_FOREVER);\
            dispatch_async(dispatch_get_main_queue(), ^{\
                sender.enabled = YES;\
                dout(@"Test %d End", TEST_NUMBER)\
            });\
        });\
    }

MakeTestSelector(1, 3, 5)

/// 测试 1 是多个任务并行执行的
- (void)doTask1 {
    long count = LockTestRunCount;
    LockTestRunCount++;
    dout(@"Task 1(%3ld) start", count);
    u_int32_t r = arc4random_uniform(5) + 1;
    sleep(r);
    dout(@"Task 1(%3ld) end after %d s", count, r);
}

MakeTestSelector(2, 3, 3)

/// 测试 2 除了在执行时使用 @synchronized 上锁外，其余跟测试 1 一致。
/// 但就因为这个锁，保证了测试 2 的每个任务是依次执行的
- (void)doTask2 {
    @synchronized(self) {
        long count = LockTestRunCount;
        LockTestRunCount++;
        dout(@"Task 2(%3ld) start", count);
        u_int32_t r = arc4random_uniform(5) + 1;
        sleep(r);
        dout(@"Task 2(%3ld) end after %d s", count, r);
    }
}

MakeTestSelector(3, 3, 3)

/// 测试 3，任务中包含多个子任务
- (void)doTask3 {
    @synchronized(self) {
        long count = LockTestRunCount;
        LockTestRunCount++;
        dout(@"Task 3(%3ld) start", count);
        dispatch_group_t subGP = dispatch_group_create();
        for (int i = 0; i < 4; i++) {
            dispatch_group_enter(subGP);
            dispatch_async(self.backgroundQueue, ^{
                [self subTask:i];
                dispatch_group_leave(subGP);
            });
        }
        dispatch_group_wait(subGP, DISPATCH_TIME_FOREVER);
        dout(@"Task 3(%3ld) end", count);
    }
}

- (void)subTask:(int)idx {
    dout(@"  START: Sub task %d", idx);
    u_int32_t r = arc4random_uniform(5) + 1;
    sleep(r);
    dout(@"  END: Sub task %d", idx);
}

MakeTestSelector(4, 1, 1)

/// 测试 4，相同 thread 嵌套 @synchronized 没什么问题
- (void)doTask4 {
    @synchronized(self) {
        long count = LockTestRunCount;
        LockTestRunCount++;
        dout(@"Task 4(%3ld) start", count);
        [self subTaskWithLock:0];
        dout(@"Task 4(%3ld) end", count);
    }
}

MakeTestSelector(5, 1, 1)

/// 测试 5，不同 thread 嵌套 @synchronized 可能导致死锁
/// The object passed to the @synchronized directive is a unique identifier used to distinguish the protected block.
/// If you execute the preceding method in two different threads, passing a different object for the anObj parameter on each thread, each would take its lock and continue processing without being blocked by the other.
/// If you pass the same object in both cases, however, one of the threads would acquire the lock first and the other would block until the first thread completed the critical section.
- (void)doTask5 {
    dout(@"Warning: Test 5 will cause dead lock");
    @synchronized(self) {
        long count = LockTestRunCount;
        LockTestRunCount++;
        dout(@"Task 5(%3ld) start", count);
        dispatch_group_t subGP = dispatch_group_create();
        for (int i = 0; i < 1; i++) {
            dispatch_group_enter(subGP);
            dispatch_async(self.backgroundQueue, ^{
                [self subTaskWithLock:i];
                dispatch_group_leave(subGP);
            });
        }
        dispatch_group_wait(subGP, DISPATCH_TIME_FOREVER);
        dout(@"Task 5(%3ld) end", count);
    }
}

- (void)subTaskWithLock:(int)idx {
    dout(@"  START: Sub task with lock %d", idx);
    @synchronized(self) {
        u_int32_t r = arc4random_uniform(5) + 1;
        sleep(r);
    }
    dout(@"  END: Sub task with lock %d", idx);
}

@end
