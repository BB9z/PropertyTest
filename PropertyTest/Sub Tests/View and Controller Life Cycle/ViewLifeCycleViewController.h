//
//  ViewLifeCycleViewController.h
//  PropertyTest
//
//  Created by BB9z on 7/10/14.
//
//

#import <UIKit/UIKit.h>
#import "RFInitializing.h"

@interface ViewLifeCycleViewController : UIViewController <
    RFInitializing
>
@property (weak, nonatomic) IBOutlet UIView *lifeCycleTestView;
@end



@interface LifeCycleTestView : UIView
@end

@interface LifeCycleManualCreatTestView : UIView
@end
