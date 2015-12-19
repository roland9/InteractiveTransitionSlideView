//
//  TransitioningDelegate.m
//  slideView
//
//  Created by Roland Gröpmair on 19/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

#import "TransitioningDelegate.h"
#import "PresentationController.h"

@interface TransitioningDelegate ()

@property (nonatomic, strong) InteractiveTransition *interactiveTransition;

@end


@implementation TransitioningDelegate

- (instancetype)initWithInteractiveTransition:(InteractiveTransition *)interactiveTransition {
    self = [super init];
    if (self) {
        _interactiveTransition = interactiveTransition;
    }
    
    return self;
}

# pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[PresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.interactiveTransition;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.interactiveTransition;
}


- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    self.interactiveTransition.isPresenting = YES;
    
    return self.interactiveTransition;
}


- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    self.interactiveTransition.isPresenting = NO;
    
    return self.interactiveTransition;
}

@end
