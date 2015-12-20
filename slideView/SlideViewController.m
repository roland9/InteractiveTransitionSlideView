//
//  SlideViewController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "SlideViewController.h"
#import "InteractiveTransition.h"

@interface SlideViewController ()

@end

#define kSlideTransitionViewWidth   80.f
#define kSlideTransitionViewHeight  80.f

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addSlideTransitionView];
}

- (void)addSlideTransitionView {
    NSCAssert(self.interactiveTransition, @"expected transition");
    
    SlideTransitionView *slideTransitionView =
    [[SlideTransitionView alloc] initWithFrame:CGRectMake(0.f, 0.f, kSlideTransitionViewWidth, kSlideTransitionViewHeight)
                                      delegate:self
                                    transition:self.interactiveTransition
                                  initialState:TransitioningStateLeft];
  
    slideTransitionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:slideTransitionView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:slideTransitionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:slideTransitionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:slideTransitionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kSlideTransitionViewWidth]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:slideTransitionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kSlideTransitionViewHeight]];

    slideTransitionView.backgroundColor = [UIColor yellowColor];
}

# pragma mark - SlideTransitionProtocol

- (void)dismissSlideViewController {
    NSCAssert(self.delegate, @"expected delegate");
    
    self.transitioningDelegate = self.delegate;    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
