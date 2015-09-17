


#import "HomeViewController.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

- (IBAction)onExit:(UIStoryboardSegue *)sender {
    NSLog(@"%@", sender.sourceViewController);
}

@end
