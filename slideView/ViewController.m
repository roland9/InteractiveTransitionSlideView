//
//  ViewController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "ViewController.h"
#import "SlideViewController.h"
#import "InteractiveTransition.h"

@interface ViewController ()

@property (nonatomic, strong) InteractiveTransition *interactiveTransition;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    [self addSlideTransitionView];
}


- (void)addSlideTransitionView {
    SlideTransitionView *slideTransitionView =
    [[SlideTransitionView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)
                                      delegate:self
                                    transition:self.interactiveTransition
                                  initialState:TransitioningStateRight];
    slideTransitionView.center = CGPointMake(CGRectGetWidth(self.view.bounds)-40, CGRectGetHeight(self.view.bounds)-40);
    [self.view addSubview:slideTransitionView];
}


# pragma mark - SlideTransitionProtocol

- (void)presentSlideViewController {
    SlideViewController *slideViewController =
    [[SlideViewController alloc] initWithDelegate:self
                            interactiveTransition:self.interactiveTransition];

    slideViewController.modalPresentationStyle = UIModalPresentationCustom;
    slideViewController.transitioningDelegate = self;
    
    [self presentViewController:slideViewController animated:YES completion:nil];
}


# pragma mark - Properties

- (InteractiveTransition *)interactiveTransition {
    if (!_interactiveTransition) {
        _interactiveTransition = [[InteractiveTransition alloc] init];
    }
    return _interactiveTransition;
}


# pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
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
