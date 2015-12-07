//
//  InteractiveTransition.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "InteractiveTransition.h"
#import "SlideViewController.h"
#import "ViewController.h"

@implementation InteractiveTransition
{
    UIViewController *viewControllerFrom;
    UIViewController *viewControllerTo;
    BOOL isPresenting;
}

// UIViewControllerInteractiveTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];

    if (isPresenting) {
        viewControllerFrom = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        NSCAssert([viewControllerFrom isKindOfClass:[ViewController class]], @"invalid");
        
        viewControllerTo = (SlideViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        NSCAssert([viewControllerTo isKindOfClass:[SlideViewController class]], @"invalid");
        viewControllerTo.view.frame = CGRectMake(0, 0, CGRectGetWidth(viewControllerFrom.view.frame), CGRectGetHeight(viewControllerFrom.view.frame) - 100);
        [containerView addSubview:viewControllerFrom.view];
        [containerView addSubview:viewControllerTo.view];
    } else {
        NSLog(@"bla");
    }
}


- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    NSLog(@"percent=%f", percentComplete);
    NSCAssert(viewControllerTo, @"expected viewControllerTo");

    CGFloat width = CGRectGetWidth(viewControllerTo.view.frame);
    viewControllerTo.view.transform = CGAffineTransformMakeTranslation(-width * percentComplete, 0.f);
}

- (void)animationEnded:(BOOL)transitionCompleted {
    NSCAssert(viewControllerTo, @"expected viewControllerTo");
    CGFloat width = CGRectGetWidth(viewControllerTo.view.frame);

    [UIView animateWithDuration:0.2 delay:0.f usingSpringWithDamping:1.f initialSpringVelocity:1.f options:0 animations:^{
        viewControllerTo.view.transform = transitionCompleted ? CGAffineTransformMakeTranslation(-width, 0.f) :  CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [viewControllerFrom.view removeFromSuperview];
        [viewControllerTo.view removeFromSuperview];
    }];
}

- (void)finishInteractiveTransition {
    NSCAssert(viewControllerTo, @"expected viewControllerTo");

    CGFloat width = CGRectGetWidth(viewControllerTo.view.frame);
    viewControllerTo.view.transform = CGAffineTransformMakeTranslation(-width, 0.f);
}
//- (void)cancelInteractiveTransition {
//    NSCAssert(viewControllerTo, @"expected viewControllerTo");
//    viewControllerTo.view.transform = CGAffineTransformIdentity;
//    [viewControllerTo.view removeFromSuperview];
//}
//
//- (void)finishInteractiveTransition {
//    NSCAssert(viewControllerTo, @"expected viewControllerTo");
//    
//}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.f;
}

// UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    isPresenting = YES;
    return self;
}

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//    isPresenting = NO;
//    return self;
//}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return nil; // We don't want to use interactive transition to dismiss the modal view, we are just going to use the standard animator.
}


@end
