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

- (void)didCompleteTransition:(BOOL)didComplete {
}


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
                                 if (finished) {
                                     if ([transitionContext transitionWasCancelled]) {
                                         [transitionContext completeTransition:NO];
                                     } else {
                                         [transitionContext completeTransition:YES];
                                     }
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
                                 if (finished) {
                                     [transitionContext completeTransition:YES];
                                 }
                             }];
        }
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
