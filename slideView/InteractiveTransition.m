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
@property (nonatomic, strong) id<UIViewControllerContextTransitioning>context;
@end


@implementation InteractiveTransition

# pragma mark - Public

//- (void)didCompleteTransition:(BOOL)didComplete {
//
//    if (didComplete) {
////        [self.viewControllerFrom.view removeFromSuperview];
//    } else {
////        [self.viewControllerTo.view removeFromSuperview];
//    }
//
//    NSCAssert(self.context, @"expected context");
//    [self.context completeTransition:didComplete];
//    self.context = nil;
//}


# pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"%s: isInteractive=%d", __FUNCTION__, [transitionContext isInteractive]);
    self.context = transitionContext;
    
    UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    if (presentedView) {
        CGPoint center = presentedView.center;
        presentedView.center = CGPointMake(presentedView.bounds.size.width * 1.5f, center.y);
        [[transitionContext containerView] addSubview:presentedView];
        
        if ([transitionContext isInteractive]) {
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                  delay:0.f
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 presentedView.center = center;
                             } completion:^(BOOL finished) {
                                 // finished in
                                 if ([transitionContext transitionWasCancelled]) {
                                     [transitionContext completeTransition:NO];
                                 } else {
                                     [transitionContext completeTransition:YES];
                                 }
                             }];
        } else {
            // non-interactive - gradual stop
            [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                  delay:0.f
                 usingSpringWithDamping: 1.0
                  initialSpringVelocity: 1
                                options: 0
                             animations:^{
                                 presentedView.center = center;
                             } completion:^(BOOL finished) {
                                 // finished in??
                                 [transitionContext completeTransition:YES];
                             }];
        }
    }
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

//- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//
//    if (self.isPresenting) {
//
//        UIView *containerView = [transitionContext containerView];
//        self.context = transitionContext;
//
//        self.viewControllerFrom = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//        NSCAssert([self.viewControllerFrom isKindOfClass:[UINavigationController class]], @"invalid");
//
//        self.viewControllerTo = (SlideViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//        NSCAssert([self.viewControllerTo isKindOfClass:[SlideViewController class]], @"invalid");
//
//        CGFloat width = CGRectGetWidth(self.viewControllerFrom.view.frame);
//        CGFloat height = CGRectGetHeight(self.viewControllerFrom.view.frame);
//
//        self.viewControllerTo.view.frame = CGRectMake(width,
//                                                      0,
//                                                      width,
//                                                      height);
//        [containerView addSubview:self.viewControllerTo.view];
//
//    } else {
//
//        UIView *containerView = [transitionContext containerView];
//        self.context = transitionContext;
//
//        self.viewControllerFrom = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//        NSCAssert([self.viewControllerFrom isKindOfClass:[SlideViewController class]], @"invalid");
//
//        self.viewControllerTo = (SlideViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//        NSCAssert([self.viewControllerTo isKindOfClass:[UINavigationController class]], @"invalid");
//
//        CGFloat width = CGRectGetWidth(self.viewControllerFrom.view.frame);
//        CGFloat height = CGRectGetHeight(self.viewControllerFrom.view.frame);
//
//        self.viewControllerTo.view.frame = CGRectMake(width,
//                                                      0,
//                                                      width,
//                                                      height);
//        [containerView insertSubview:self.viewControllerTo.view belowSubview:self.viewControllerFrom.view];
//
//    }
//}


//- (void)updateInteractiveTransition:(CGFloat)percentComplete {
//    NSLog(@"%s: percent=%f", __FUNCTION__, percentComplete);
//    NSCAssert(self.viewControllerTo, @"expected self.viewControllerTo");
//
//    CGFloat scale = 1.f - 0.04f * percentComplete;
//    self.viewControllerFrom.view.transform = CGAffineTransformMakeScale(scale, scale);
//
//    CGFloat width = CGRectGetWidth(self.viewControllerTo.view.frame);
//    self.viewControllerTo.view.transform = CGAffineTransformMakeTranslation(-width * percentComplete, 0.f);
//}
//
//- (void)cancelInteractiveTransition {
//    NSLog(@"%s", __FUNCTION__);
//    NSCAssert(self.viewControllerTo, @"expected self.viewControllerTo");
//
//    self.viewControllerFrom.view.transform = CGAffineTransformIdentity;
//
//    self.viewControllerTo.view.transform = CGAffineTransformIdentity;
//}


# pragma mark - UIViewControllerContextTransitioning

//- (void)finishInteractiveTransition {
//    NSLog(@"%s", __FUNCTION__);
//    NSCAssert(self.viewControllerTo, @"expected self.viewControllerTo");
//
//    CGFloat width = CGRectGetWidth(self.viewControllerTo.view.frame);
//
//    self.viewControllerTo.view.transform = CGAffineTransformMakeTranslation(-width + 40.f, 0.f);
//}

@end
