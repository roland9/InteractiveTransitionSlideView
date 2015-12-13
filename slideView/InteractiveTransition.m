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

# pragma mark - Public

- (void)didCompleteTransition:(BOOL)didComplete {

    if (didComplete) {
//        [self.viewControllerFrom.view removeFromSuperview];
    } else {
        [self.viewControllerTo.view removeFromSuperview];
    }
    
    NSCAssert(self.context, @"expected context");
    [self.context completeTransition:didComplete];
    self.context = nil;
}


# pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"%s", __FUNCTION__);
}

- (void)animationEnded:(BOOL)transitionCompleted {
    NSLog(@"%s", __FUNCTION__);
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"%s", __FUNCTION__);
    return 1.f;
}


#pragma mark - UIViewControllerInteractiveTransitioning

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = [transitionContext containerView];
    self.context = transitionContext;
    
    if (self.isPresenting) {
        self.viewControllerFrom = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        NSCAssert([self.viewControllerFrom isKindOfClass:[UINavigationController class]], @"invalid");
        
        self.viewControllerTo = (SlideViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        NSCAssert([self.viewControllerTo isKindOfClass:[SlideViewController class]], @"invalid");
        
        CGFloat width = CGRectGetWidth(self.viewControllerFrom.view.frame);
        CGFloat height = CGRectGetHeight(self.viewControllerFrom.view.frame);
        
        self.viewControllerTo.view.frame = CGRectMake(width,
                                                      0,
                                                      width,
                                                      height);
        [containerView addSubview:self.viewControllerTo.view];
        
    } else {
        NSLog(@"!self.isPresenting -> pending");
    }
}


- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    NSLog(@"%s: percent=%f", __FUNCTION__, percentComplete);
//    NSCAssert(self.viewControllerTo, @"expected self.viewControllerTo");

    CGFloat scale = 1.f - 0.1f * percentComplete;
    self.viewControllerFrom.view.transform = CGAffineTransformMakeScale(scale, scale);

    CGFloat width = CGRectGetWidth(self.viewControllerTo.view.frame);
    self.viewControllerTo.view.transform = CGAffineTransformMakeTranslation(-width * percentComplete, 0.f);
}

- (void)cancelInteractiveTransition {
    NSLog(@"%s", __FUNCTION__);
    NSCAssert(self.viewControllerTo, @"expected self.viewControllerTo");
    
    self.viewControllerFrom.view.transform = CGAffineTransformIdentity;

    self.viewControllerTo.view.transform = CGAffineTransformIdentity;
}


# pragma mark - UIViewControllerContextTransitioning

- (void)finishInteractiveTransition {
    NSLog(@"%s", __FUNCTION__);
    NSCAssert(self.viewControllerTo, @"expected self.viewControllerTo");
    
    CGFloat width = CGRectGetWidth(self.viewControllerTo.view.frame);
    
    self.viewControllerTo.view.transform = CGAffineTransformMakeTranslation(-width + 40.f, 0.f);
}


# pragma mark - UIViewControllerTransitioningDelegate

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
