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

- (instancetype)init {
    self = [super init];
    if (self) {
        _presentationInteractionController = [[PresentationInteractionController alloc] init];
        _presentationAnimationController = [[PresentationAnimationController alloc] init];
        
        _dismissalInteractionController = [[DismissalInteractionController alloc] init];
        _dismissalAnimationController = [[DismissalAnimationController alloc] init];
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

- (void)setSlidingViewPresenting:(UIView *)slidingViewPresenting {
    _slidingViewPresenting = slidingViewPresenting;
    self.presentationInteractionController.slidingView = slidingViewPresenting;
}

- (void)setSlidingViewPresented:(UIView *)slidingViewPresented {
    _slidingViewPresented = slidingViewPresented;
    self.dismissalInteractionController.slidingView = slidingViewPresented;
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
