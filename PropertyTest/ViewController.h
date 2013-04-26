//
//  ViewController.h
//  PropertyTest
//
//  Created by BB9z on 13-4-5.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@end

@interface Person : NSObject {
@public
    NSString *iVarString;
    NSNumber *iVarNumber;
    
    __weak NSString *iVarWeak;
}

- (NSString *)unsafe_iVarString;

@property (copy, nonatomic) NSString *copyedPropertyString;
@property (strong, nonatomic) NSString *strongPropertyString;
@property (weak, nonatomic) NSString *weakPropertyString;

@property (copy, nonatomic) void (^retainTestBlock)(void);

- (void)blockRetainTestStrongSelf;
- (void)blockRetainTestIVar;

@end
