//
//  InteractiveTransition.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "InteractiveDismissTransition.h"
#import "SlideViewController.h"
#import "ViewController.h"

@interface InteractiveTransition()

@property (nonatomic, strong) UIViewController *viewControllerFrom;
@property (nonatomic, strong) UIViewController *viewControllerTo;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning>context;

@end

@implementation InteractiveTransition

# pragma mark - Public

- (void)didCompleteTransition:(BOOL)didComplete {
    NSCAssert(NO, @"to be overwritten by subclass");
}


# pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSCAssert(NO, @"to be overwritten by subclass");
}

- (void)animationEnded:(BOOL)transitionCompleted {
    NSCAssert(NO, @"to be overwritten by subclass");
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSCAssert(NO, @"to be overwritten by subclass");
    return 1.f;
}


#pragma mark - UIViewControllerInteractiveTransitioning

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext{

    NSCAssert(NO, @"to be overwritten by subclass");
}


- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    NSCAssert(NO, @"to be overwritten by subclass");
}

- (void)cancelInteractiveTransition {
    NSCAssert(NO, @"to be overwritten by subclass");
}


# pragma mark - UIViewControllerContextTransitioning

- (void)finishInteractiveTransition {
    NSCAssert(NO, @"to be overwritten by subclass");
}

@end
