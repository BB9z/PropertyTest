//
//  ModelPresentedViewController.m
//  PropertyTest
//
//  Created by BB9z on 9/17/15.
//
//

#import "ModelPresentedViewController.h"
#import "dout.h"

@interface ModelPresentedViewController ()

@end

@implementation ModelPresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDismissThenPushImmediately:(id)sender {
    UINavigationController *parent = (id)self.presentingViewController;
    RFAssert([parent isKindOfClass:[UINavigationController class]], nil);
    [self dismissModalViewControllerAnimated:YES];
    [parent pushViewController:[self testViewControllerToPush] animated:YES];
}

- (IBAction)onDismissThenPresentImmediately:(id)sender {
    UINavigationController *parent = (id)self.presentingViewController;
    RFAssert([parent isKindOfClass:[UINavigationController class]], nil);
    [self dismissModalViewControllerAnimated:YES];
    UIViewController *vc = [self.class newFromStoryboard];
    [parent presentModalViewController:vc animated:YES];
}

- (IBAction)onPushFirstThenDismiss:(id)sender {
    UINavigationController *parent = (id)self.presentingViewController;
    RFAssert([parent isKindOfClass:[UINavigationController class]], nil);
    [parent pushViewController:[self testViewControllerToPush] animated:YES];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)onDismissAndWaitToPresent:(id)sender {
    UINavigationController *parent = (id)self.presentingViewController;
    RFAssert([parent isKindOfClass:[UINavigationController class]], nil);
    [self dismissViewControllerAnimated:YES completion:^{
        UIViewController *vc = [self.class newFromStoryboard];
        [parent presentModalViewController:vc animated:YES];
    }];
}

- (IBAction)onDismiss:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

+ (instancetype)newFromStoryboard {
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    return [main instantiateViewControllerWithIdentifier:@"ModelPresentedViewController"];
}

- (UIViewController *)testViewControllerToPush {
    return [self.storyboard instantiateViewControllerWithIdentifier:@"ModelTest"];
}

@end
