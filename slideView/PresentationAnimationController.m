//
//  PresentationAnimationController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "PresentationAnimationController.h"
#import "SlideViewController.h"

@interface PresentationAnimationController()

@property (nonatomic, strong) UIViewController *viewControllerFrom;
@property (nonatomic, strong) UIViewController *viewControllerTo;
@end


@implementation PresentationAnimationController

# pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"%s: isInteractive=%d", __FUNCTION__, [transitionContext isInteractive]);
    
    UIView *presentedView  = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    if (presentedView) {
        CGPoint center = containerView.center;
        presentedView.center = CGPointMake(presentedView.bounds.size.width * 1.5f, center.y);
        [[transitionContext containerView] addSubview:presentedView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             presentedView.center = center;
                         } completion:^(BOOL finished) {
                             if ([transitionContext transitionWasCancelled]) {
                                 [transitionContext completeTransition:NO];
                             } else {
                                 [transitionContext completeTransition:YES];
                             }
                         }];
    } else {
        NSCAssert(NO, @"unexpected");
    }
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return .4f;
}

@end
