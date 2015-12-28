//
//  PresentationController.m
//  slideView
//
//  Created by Roland Gröpmair on 19/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

#import "PresentationController.h"

@interface PresentationController()

@property (nonatomic, strong) UIView *dimmingView;

@end


@implementation PresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _dimmingView = [[UIView alloc] init];
        _dimmingView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3f];
    }
    
    return self;
}


- (void)presentationTransitionWillBegin {
    UIView *containerView = self.containerView;
    UIViewController *presentedViewController = self.presentedViewController;
    [self.dimmingView setFrame:[containerView bounds]];
    self.dimmingView.alpha = 0.f;
    
    [containerView insertSubview:self.dimmingView atIndex:0];
    
    [[presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 1.f;
    } completion:nil];
}


- (void)dismissalTransitionWillBegin {
    [[[self presentedViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.f;
    } completion:nil];
}


- (CGRect)frameOfPresentedViewInContainerView {
    CGRect presentedViewFrame = CGRectZero;
    CGRect containerBounds = [[self containerView] bounds];
    presentedViewFrame.size = [self sizeForChildContentContainer:
                               (UIView<UIContentContainer> *)[self presentedView]
                                         withParentContainerSize:containerBounds.size];
    presentedViewFrame.origin.x = containerBounds.size.width -
    presentedViewFrame.size.width;
    return presentedViewFrame;
}


- (void)containerViewWillLayoutSubviews {
    [self.dimmingView setFrame:[[self containerView] bounds]];
    [[self presentedView] setFrame:[self frameOfPresentedViewInContainerView]];
}

@end
