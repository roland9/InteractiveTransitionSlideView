//
//  SlideViewController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "SlideViewController.h"
#import "PresentationAnimationController.h"

@interface SlideViewController ()

@end

#define kSlideTransitionViewHeight  80.f
#define kSlideTransitionInset       40.f

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addSlideTransitionView];
}

- (void)addSlideTransitionView {
    NSCAssert(self.presentationAnimationController, @"expected animationController");
    
    SlideTransitionView *slideTransitionView =
    [[SlideTransitionView alloc] initWithFrame:CGRectZero
                                      delegate:self
                           animationController:self.presentationAnimationController
                                  initialState:TransitioningStateLeft];
    
    slideTransitionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:slideTransitionView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:slideTransitionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.f constant:-kSlideTransitionInset]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:slideTransitionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:slideTransitionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.f constant:kSlideTransitionInset]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:slideTransitionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kSlideTransitionViewHeight]];
    
    slideTransitionView.backgroundColor = [UIColor blueColor];
}

# pragma mark - SlideTransitionProtocol

- (void)dismissSlideViewController {
    NSCAssert(self.delegate, @"expected delegate");
    
//    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self.delegate;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
