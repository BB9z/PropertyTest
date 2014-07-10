
#import "ViewLifeCycleViewController.h"
#import "dout.h"

@interface ViewLifeCycleViewController ()
@end

@implementation ViewLifeCycleViewController

#pragma mark - init

- (id)init {
    doutwork()
    self = [super init];
    if (self) {
        [self onInit];
        [self performSelector:@selector(afterInit) withObject:self afterDelay:0];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // Load start
    douts(@"--------------------")

    doutwork()
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self onInit];
        [self performSelector:@selector(afterInit) withObject:self afterDelay:0];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    doutwork()
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self onInit];
        [self performSelector:@selector(afterInit) withObject:self afterDelay:0];
    }
    return self;
}

- (void)onInit {
    doutwork()
}

- (void)afterInit {
    doutwork()
}

#pragma mark - Awake

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    doutwork()
    return [super awakeAfterUsingCoder:aDecoder];
}

- (void)awakeFromNib {
    doutwork()
    [super awakeFromNib];
    dout(@"At awakeFromNib lifeCycleTestView = %@", self.lifeCycleTestView);
}

#pragma mark -

- (void)viewDidLoad {
    doutwork()
    dout(@"At viewDidLoad lifeCycleTestView = %@", self.lifeCycleTestView);
    [super viewDidLoad];

    // Creat view using code.
    LifeCycleManualCreatTestView *v = [LifeCycleManualCreatTestView new];
    [self.view addSubview:v];
}

- (void)viewWillAppear:(BOOL)animated {
    doutwork()
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    doutwork()
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    doutwork()
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    doutwork()
    [super viewDidDisappear:animated];
}

- (void)viewWillLayoutSubviews {
    doutwork()
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    doutwork()
    [super viewDidLayoutSubviews];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    doutwork()
    [super willMoveToParentViewController:parent];
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    doutwork()
    [super didMoveToParentViewController:parent];

    // Load finished
    if (parent) {
        douts(@"--------------------")
        douts(@"iOS 7 上会再调用布局通知")
    }
}

#pragma mark - Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    doutwork()
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    doutwork()
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    doutwork()
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

@end

@implementation LifeCycleTestView

#pragma mark - init

- (id)init {
    doutwork()
    self = [super init];
    if (self) {
        [self onInit];
        [self performSelector:@selector(afterInit) withObject:self afterDelay:0];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    doutwork()
    self = [super initWithFrame:frame];
    if (self) {
        [self onInit];
        [self performSelector:@selector(afterInit) withObject:self afterDelay:0];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    doutwork()
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self onInit];
        [self performSelector:@selector(afterInit) withObject:self afterDelay:0];
    }
    return self;
}

- (void)onInit {
    doutwork()
}

- (void)afterInit {
    doutwork()
}

#pragma mark - Awake

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    doutwork()
    return [super awakeAfterUsingCoder:aDecoder];
}

- (void)awakeFromNib {
    doutwork()
    [super awakeFromNib];
}

#pragma mark - 

- (void)willMoveToSuperview:(UIView *)newSuperview {
    doutwork()
    [super willMoveToSuperview:newSuperview];
}

- (void)didMoveToSuperview {
    doutwork()
    [super didMoveToSuperview];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    doutwork()
    [super willMoveToWindow:newWindow];
}

- (void)didMoveToWindow {
    doutwork()
    [super didMoveToWindow];
}

- (void)layoutSubviews {
    doutwork()
    [super layoutSubviews];
}

@end

@implementation LifeCycleManualCreatTestView

#pragma mark - init

- (id)init {
    doutwork()
    self = [super init];
    if (self) {
        [self onInit];
        [self performSelector:@selector(afterInit) withObject:self afterDelay:0];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    doutwork()
    self = [super initWithFrame:frame];
    if (self) {
        [self onInit];
        [self performSelector:@selector(afterInit) withObject:self afterDelay:0];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    doutwork()
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self onInit];
        [self performSelector:@selector(afterInit) withObject:self afterDelay:0];
    }
    return self;
}

- (void)onInit {
    doutwork()
}

- (void)afterInit {
    doutwork()
}

#pragma mark - Awake

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    doutwork()
    return [super awakeAfterUsingCoder:aDecoder];
}

- (void)awakeFromNib {
    doutwork()
    [super awakeFromNib];
}

#pragma mark -

- (void)willMoveToSuperview:(UIView *)newSuperview {
    doutwork()
    [super willMoveToSuperview:newSuperview];
}

- (void)didMoveToSuperview {
    doutwork()
    [super didMoveToSuperview];

    if (!self.superview) {
        // Unload finished
        douts(@"--------------------")
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    doutwork()
    [super willMoveToWindow:newWindow];
}

- (void)didMoveToWindow {
    doutwork()
    [super didMoveToWindow];
}

- (void)layoutSubviews {
    doutwork()
    [super layoutSubviews];
}

@end
