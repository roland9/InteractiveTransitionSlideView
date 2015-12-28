//
//  DismissalAnimationController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "DismissalAnimationController.h"
#import "SlideViewController.h"
#import "ViewController.h"

@interface DismissalAnimationController()

@property (nonatomic, strong) UIViewController *viewControllerFrom;
@property (nonatomic, strong) UIViewController *viewControllerTo;
@end


@implementation DismissalAnimationController

# pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"%s: isInteractive=%d", __FUNCTION__, [transitionContext isInteractive]);

    UIView *presentedView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    if (presentedView) {
        CGPoint center = presentedView.center;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             presentedView.center = CGPointMake(presentedView.bounds.size.width * 1.5f, center.y);
                         } completion:^(BOOL finished) {
                             if (finished) {
                                 if ([transitionContext transitionWasCancelled]) {
                                     [transitionContext completeTransition:NO];
                                 } else {
                                     [transitionContext completeTransition:YES];
                                 }
                             }
                         }];
    }
}


- (void)animationEnded:(BOOL)transitionCompleted {
    NSLog(@"%s", __FUNCTION__);
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"%s", __FUNCTION__);
    return .4f;
}


@end
