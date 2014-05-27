//
//  TouchEventViewController.m
//  PropertyTest
//
//  Created by BB9z on 5/27/14.
//
//

#import "TouchEventViewController.h"
#import "dout.h"

@implementation TouchEventTestView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    dout(@"touchesBegan in %@", self.name);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    dout(@"touchesEnded in %@", self.name);
    [super touchesEnded:touches withEvent:event];
}

@end

@implementation TouchEventTestButton

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    dout(@"touchesBegan in %@", self.name);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    dout(@"touchesEnded in %@", self.name);
    [super touchesEnded:touches withEvent:event];
}

@end

@interface TouchEventViewController ()

@end

@implementation TouchEventViewController


@end
