//
//  ViewController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "ViewController.h"
#import "SlideViewController.h"
#import "PresentationInteractionController.h"
#import "PresentationAnimationController.h"
#import "DismissalInteractionController.h"
#import "DismissalAnimationController.h"
#import "TransitioningDelegate.h"

@interface ViewController ()

@property (nonatomic, strong) TransitioningDelegate *transitioningDelegate;
@property (nonatomic, strong) PresentationInteractionController *presentationInteractionController;
@property (nonatomic, strong) PresentationAnimationController *presentationAnimationController;
@property (nonatomic, strong) DismissalInteractionController *dismissalInteractionController;
@property (nonatomic, strong) DismissalAnimationController *dismissalAnimationController;

@property (nonatomic, strong) SlideViewController *slideViewController;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"View Controller";
    
    [self addSlideTransitionView];
    
    self.transitioningDelegate.presentingViewController = self;
}


- (void)addSlideTransitionView {
    SlideTransitionView *slideTransitionView =
    [[SlideTransitionView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)
                                      delegate:self
                           animationController:self.presentationAnimationController
                                  initialState:TransitioningStateRight];
    slideTransitionView.center = CGPointMake(CGRectGetWidth(self.view.bounds)-40, CGRectGetHeight(self.view.bounds)-40);
    [self.view addSubview:slideTransitionView];
}


# pragma mark - SlideTransitionProtocol

- (void)presentSlideViewController {
    SlideViewController *slideViewController = self.slideViewController;
    slideViewController.delegate = self.transitioningDelegate;
    slideViewController.transitioningDelegate = self.transitioningDelegate;
    slideViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:slideViewController animated:YES completion:nil];
}


# pragma mark - Properties, Lazy alloocation

- (TransitioningDelegate *)transitioningDelegate {
    if (!_transitioningDelegate) {
        _transitioningDelegate = [[TransitioningDelegate alloc] initWithPresentationInteractionController:self.presentationInteractionController
                                                                          presentationAnimationController:self.presentationAnimationController dismissalInteractionController:self.dismissalInteractionController dismissalAnimationController:self.dismissalAnimationController];
    }
    return _transitioningDelegate;
}

- (SlideViewController *)slideViewController {
    if (!_slideViewController) {
        _slideViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SlideViewController"];
        _slideViewController.presentationAnimationController = self.presentationAnimationController;
    }
    return _slideViewController;
}

- (PresentationAnimationController *)presentationAnimationController {
    if (!_presentationAnimationController) {
        _presentationAnimationController = [[PresentationAnimationController alloc] init];
    }
    return _presentationAnimationController;
}

- (PresentationInteractionController *)presentationInteractionController {
    if (!_presentationInteractionController) {
        _presentationInteractionController = [[PresentationInteractionController alloc] init];
        _presentationInteractionController.viewController = self;
    }
    return _presentationInteractionController;
}

- (DismissalAnimationController *)DismissalAnimationController {
    if (!_dismissalAnimationController) {
        _dismissalAnimationController = [[DismissalAnimationController alloc] init];
    }
    return _dismissalAnimationController;
}

- (DismissalInteractionController *)dismissalInteractionController {
    if (!_dismissalInteractionController) {
        _dismissalInteractionController = [[DismissalInteractionController alloc] init];
    }
    return _dismissalInteractionController;
}

@end
