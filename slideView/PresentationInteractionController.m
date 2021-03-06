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
}

- (void)setSlidingView:(UIView *)slidingView {
    _slidingView = slidingView;
    
    UIPanGestureRecognizer *presentationPanGesture = [[UIPanGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(handlePresentationPan:)];
    [_slidingView addGestureRecognizer:presentationPanGesture];
}

#define kPanningThreshold 0.5f
#define kTargetViewInset  80.f
#define kMaxScaleOffset   0.06f

- (void)handlePresentationPan:(UIPanGestureRecognizer *)pan {
    
    CGFloat distancePannedX = [pan translationInView:pan.view].x;
    CGFloat viewWidth = CGRectGetWidth(pan.view.superview.bounds);
    
    CGFloat fractionOfEntireTranslation = -distancePannedX / (viewWidth - kTargetViewInset);
//    NSLog(@"distanceXPanned=%f  animationFraction=%f", distancePannedX, fractionOfEntireTranslation);
    
    switch (pan.state) {
            
        case UIGestureRecognizerStateBegan:
            [self presentViewController];
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat scale = 1.f - kMaxScaleOffset*fractionOfEntireTranslation;
            pan.view.superview.layer.transform = CATransform3DMakeScale(scale, scale, 1.f);
            
            [self updateInteractiveTransition:fractionOfEntireTranslation];
        }
            break;
            
        default: // .Ended, .Cancelled, .Failed
        {
            BOOL didCrossPanningThreshold = fractionOfEntireTranslation > kPanningThreshold;
            CGFloat scale = 1.f - kMaxScaleOffset;

            [UIView animateWithDuration:0.4f
                                  delay:0.f
                                options:0
                             animations:^{
                                 if (didCrossPanningThreshold) {
                                     pan.view.superview.layer.transform = CATransform3DMakeScale(scale, scale, 1.f);
                                     NSLog(@"pan.view.superview=%@", pan.view.superview);
                                     
                                 } else {
                                     pan.view.superview.layer.transform = CATransform3DIdentity;
                                 }
                             } completion:^(BOOL finished) {
                             }];
            
            // when we try to call this block in the completion of the animation, there's a gap
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

- (void)presentViewController {
    if ([self.viewController respondsToSelector:@selector(presentSlideViewController)]) {
        [self.viewController presentSlideViewController];
    }
}

@end
