//
//  ModelTestParentViewController.m
//  PropertyTest
//
//  Created by BB9z on 9/17/15.
//
//

#import "ModelTestParentViewController.h"
#import "ModelPresentedViewController.h"

@interface ModelTestParentViewController ()

@end

@implementation ModelTestParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPresentFromSelf:(id)sender {
    [self presentModalViewController:[ModelPresentedViewController newFromStoryboard] animated:YES];
}

@end
