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

@property (nonatomic, strong) PresentationAnimationController *presentationAnimationController;
@property (nonatomic, strong) PresentationInteractionController *presentationInteractionController;

@property (nonatomic, strong) DismissalAnimationController *dismissalAnimationController;
@property (nonatomic, strong) DismissalInteractionController *dismissalInteractionController;

@end


@implementation TransitioningDelegate

- (instancetype)initWithPresentationInteractionController:(PresentationInteractionController *)presentationInteractionController
                          presentationAnimationController:(PresentationAnimationController *)presentationAnimationController
                           dismissalInteractionController:(DismissalInteractionController *)dismissalInteractionController
                             dismissalAnimationController:(DismissalAnimationController *)dismissalAnimationController {
    self = [super init];
    if (self) {
        _presentationInteractionController = presentationInteractionController;
        _presentationAnimationController = presentationAnimationController;
        _dismissalInteractionController = dismissalInteractionController;
        _dismissalAnimationController = dismissalAnimationController;
    }
    
    return self;
}

- (void)setPresentingViewController:(UIViewController<SlideTransitionProtocol> *)presentingViewController {
    _presentingViewController = presentingViewController;
    self.presentationInteractionController.viewController = presentingViewController;
}

- (void)setSlideViewController:(UIViewController<SlideTransitionProtocol> *)slideViewController {
    _slideViewController = slideViewController;
    self.dismissalInteractionController.viewController = slideViewController;
}

# pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[PresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}


// animationController and interactionController for Presentation
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentationAnimationController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.presentationInteractionController;
}


// animationController and interactionController for Dismissal
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissalAnimationController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.dismissalInteractionController;
}

@end
