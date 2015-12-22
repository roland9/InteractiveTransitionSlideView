//
//  SlideViewController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "SlideViewController.h"
#import "InteractivePresentationTransition.h"

@interface SlideViewController ()

@end

#define kSlideTransitionViewWidth   80.f
#define kSlideTransitionViewHeight  80.f

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


# pragma mark - SlideTransitionProtocol

- (void)dismissSlideViewController {
    NSCAssert(self.delegate, @"expected delegate");
    
    self.transitioningDelegate = self.delegate;    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
