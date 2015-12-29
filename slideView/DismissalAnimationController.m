//
//  DismissalAnimationController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "DismissalAnimationController.h"
#import "SlideViewController.h"

@interface DismissalAnimationController()

@property (nonatomic, strong) UIViewController *viewControllerFrom;
@property (nonatomic, strong) UIViewController *viewControllerTo;
@end


@implementation DismissalAnimationController

# pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"%s: isInteractive=%d", __FUNCTION__, [transitionContext isInteractive]);

    UIView *presentedView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIViewController *viewControllerTo = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSLog(@"viewControllerTo=%@", viewControllerTo);
    NSCAssert([viewControllerTo isKindOfClass:[UINavigationController class]], @"expected UINavigationController");
    // now that's an ugly hack!
    UIView *view = [[[(UINavigationController *)viewControllerTo viewControllers] firstObject] view];
    
    if (presentedView) {
        CGPoint center = presentedView.center;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             presentedView.center = CGPointMake(presentedView.bounds.size.width * 1.5f, center.y);
                             view.layer.transform = CATransform3DIdentity;

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
