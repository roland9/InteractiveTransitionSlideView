//
//  PresentationInteractionController.m
//  slideView
//
//  Created by Roland Gröpmair on 22/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

#import "PresentationInteractionController.h"

@implementation PresentationInteractionController

- (void)setViewController:(UIViewController<SlideTransitionProtocol> *)viewController {
    _viewController = viewController;
    
    UIPanGestureRecognizer *presentationPanGesture = [[UIPanGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(handlePresentationPan:)];
    [_viewController.view addGestureRecognizer:presentationPanGesture];
}

#define kPanningThreshold 0.5f
#define kTargetViewInset  80.f

- (void)handlePresentationPan:(UIPanGestureRecognizer *)pan {
    
    CGFloat distancePannedX = [pan translationInView:pan.view.superview].x;
    CGFloat superviewWidth = CGRectGetWidth(pan.view.superview.bounds);
    
    CGFloat fractionOfEntireTranslation = -distancePannedX / (superviewWidth - kTargetViewInset);
    NSLog(@"distanceXPanned=%f  animationFraction=%f", distancePannedX, fractionOfEntireTranslation);
    
    switch (pan.state) {
            
        case UIGestureRecognizerStateBegan:
            [self presentViewController];
            break;
            
        case UIGestureRecognizerStateChanged:
            pan.view.transform = CGAffineTransformMakeTranslation(distancePannedX, 0);
            [self updateInteractiveTransition:fractionOfEntireTranslation];
            break;
            
        default: // .Ended, .Cancelled, .Failed
        {
            BOOL didCrossPanningThreshold = fractionOfEntireTranslation > kPanningThreshold;
            
            [self completeAnimationWithDidCrossThreshold:didCrossPanningThreshold
                                          superviewWidth:superviewWidth
                                                 panView:pan.view
                                         completionBlock:^(BOOL completed) {
                                             if (didCrossPanningThreshold) {
                                                 [self finishInteractiveTransition];
                                             } else {
                                                 [self cancelInteractiveTransition];
                                             }
                                         }];
        }
            break;
    }
}


# pragma mark - Private methods

- (void)presentViewController {
    if ([self.viewController respondsToSelector:@selector(presentSlideViewController)]) {
        [self.viewController presentSlideViewController];
    }
}


- (void)completeAnimationWithDidCrossThreshold:(BOOL)didCrossPanningThreshold
                                superviewWidth:(CGFloat)superviewWidth
                                       panView:(UIView *)panView
                               completionBlock:(void (^)(BOOL))completionBlock {
    [UIView animateWithDuration:0.4f
                          delay:0.f
         usingSpringWithDamping:0.6f
          initialSpringVelocity:0.9f
                        options:0
                     animations:^{
                         if (didCrossPanningThreshold) {
                             panView.transform =
                             CGAffineTransformMakeTranslation(-superviewWidth + kTargetViewInset, 0);
                         } else {
                             panView.transform = CGAffineTransformIdentity;
                         }
                     } completion:nil];
    
    // when we try to call this block in the completion of the animation, there's a gap
    completionBlock(YES);
}

@end
