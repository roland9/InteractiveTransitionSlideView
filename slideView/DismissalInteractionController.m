//
//  DismissalInteractionController.m
//  slideView
//
//  Created by Roland Gröpmair on 22/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

#import "DismissalInteractionController.h"

@implementation DismissalInteractionController

- (void)setViewController:(UIViewController<SlideTransitionProtocol> *)viewController {
    _viewController = viewController;

    UIPanGestureRecognizer *presentationPanGesture = [[UIPanGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(handleDismissalPan:)];
    [_viewController.view addGestureRecognizer:presentationPanGesture];
}


#define kPanningThreshold 0.5f
#define kTargetViewInset  80.f

- (void)handleDismissalPan:(UIPanGestureRecognizer *)pan {
    
    CGFloat distancePannedX = [pan translationInView:pan.view.superview].x;
    CGFloat superviewWidth = CGRectGetWidth(pan.view.superview.bounds);
    
    CGFloat fractionOfEntireTranslation = distancePannedX / (superviewWidth - kTargetViewInset);
    NSLog(@"distanceXPanned=%f  animationFraction=%f", distancePannedX, fractionOfEntireTranslation);
    
    switch (pan.state) {
            
        case UIGestureRecognizerStateBegan:
            [self dismissViewController];
            break;
            
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:fractionOfEntireTranslation];
            break;
            
        default: // .Ended, .Cancelled, .Failed
        {
            BOOL didCrossPanningThreshold = fractionOfEntireTranslation > kPanningThreshold;
            if (didCrossPanningThreshold) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        }
            break;
    }
}


# pragma mark - Private methods

- (void)dismissViewController {
    if ([self.viewController respondsToSelector:@selector(dismissSlideViewController)]) {
        [self.viewController dismissSlideViewController];
    }
}

@end
