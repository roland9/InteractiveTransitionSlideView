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

@interface InteractiveTransition()

@property (nonatomic, strong) UIViewController *viewControllerFrom;
@property (nonatomic, strong) UIViewController *viewControllerTo;
@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning>context;

@end

@implementation InteractiveTransition

// UIViewControllerInteractiveTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    self.context = transitionContext;
    
    if (self.isPresenting) {
        self.viewControllerFrom = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        NSCAssert([self.viewControllerFrom isKindOfClass:[ViewController class]], @"invalid");
        
        self.viewControllerTo = (SlideViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        NSCAssert([self.viewControllerTo isKindOfClass:[SlideViewController class]], @"invalid");
        
        CGFloat width = CGRectGetWidth(self.viewControllerFrom.view.frame);
        CGFloat height = CGRectGetHeight(self.viewControllerFrom.view.frame);
        
        self.viewControllerTo.view.frame = CGRectMake(width,
                                                 0,
                                                 width,
                                                 height - 100);
        [containerView addSubview:self.viewControllerTo.view];
        
    } else {
        NSLog(@"!self.isPresenting -> pending");
    }
}


- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    NSLog(@"%s: percent=%f", __FUNCTION__, percentComplete);
    NSCAssert(self.viewControllerTo, @"expected self.viewControllerTo");

    CGFloat width = CGRectGetWidth(self.viewControllerTo.view.frame);
    self.viewControllerTo.view.transform = CGAffineTransformMakeTranslation(-width * percentComplete, 0.f);
}

- (void)animationEnded:(BOOL)transitionCompleted {
    NSCAssert(self.viewControllerTo, @"expected self.viewControllerTo");
    CGFloat width = CGRectGetWidth(self.viewControllerTo.view.frame);

    [UIView animateWithDuration:0.2 delay:0.f usingSpringWithDamping:1.f initialSpringVelocity:1.f options:0 animations:^{
        self.viewControllerTo.view.transform = transitionCompleted ? CGAffineTransformMakeTranslation(-width, 0.f) :  CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.viewControllerFrom.view removeFromSuperview];
        [self.viewControllerTo.view removeFromSuperview];
    }];
}

- (void)finishInteractiveTransition {
    NSLog(@"%s", __FUNCTION__);
    NSCAssert(self.viewControllerTo, @"expected self.viewControllerTo");
    NSCAssert(self.context, @"expected context");
    
    CGFloat width = CGRectGetWidth(self.viewControllerTo.view.frame);
    self.viewControllerTo.view.transform = CGAffineTransformMakeTranslation(-width, 0.f);
    [self.context completeTransition:YES];
}

- (void)cancelInteractiveTransition {
    NSLog(@"%s", __FUNCTION__);
    NSCAssert(self.viewControllerTo, @"expected self.viewControllerTo");
    NSCAssert(self.context, @"expected context");
    
    self.viewControllerTo.view.transform = CGAffineTransformIdentity;
//    [self.viewControllerTo.view removeFromSuperview];
    [self.context completeTransition:NO];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"%s", __FUNCTION__);
    return 1.f;
}

// UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    NSLog(@"%s: presentedVC=%@  presentingVC=%@  source=%@", __FUNCTION__, presented, presenting, source);
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    NSLog(@"%s: dismissedVC=%@", __FUNCTION__, dismissed);
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    NSLog(@"%s", __FUNCTION__);
    self.isPresenting = YES;
    return self;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    NSLog(@"%s", __FUNCTION__);
    self.isPresenting = NO;
    return self;
}

@end
