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

    UIPanGestureRecognizer *presentationPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePresentationPan:)];
    [_viewController.view addGestureRecognizer:presentationPanGesture];
}

- (void)handlePresentationPan:(UIPanGestureRecognizer *)pan {
    
//    // how much distance have we panned in reference to the parent view?
    CGPoint translation = [pan translationInView:pan.view];
//    // do some math to translate this to a percentage based value
    double d = translation.x / CGRectGetWidth(pan.view.bounds) * -1.0; //* -0.5
    
    NSLog(@"here %f", d);
    
    switch (pan.state) {
            
        case UIGestureRecognizerStateBegan:
            
            if ([self.viewController respondsToSelector:@selector(presentSlideViewController)]) {
                [self.viewController presentSlideViewController];
            }
            
        case UIGestureRecognizerStateChanged:
            // update progress of the transition
            [self updateInteractiveTransition:d];
            
        default: // .Ended, .Cancelled, .Failed
            
            if (d > 0.2) {
                // threshold crossed: finish
                [self finishInteractiveTransition];
            } else {
                // threshold not met: cancel
                [self cancelInteractiveTransition];
            }
    }
}

@end
