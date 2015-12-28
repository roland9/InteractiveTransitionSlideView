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
                           animationController:[[PresentationAnimationController alloc] init]
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
    self.transitioningDelegate.slideViewController = slideViewController;
    
    [self presentViewController:slideViewController animated:YES completion:nil];
}


# pragma mark - Properties, Lazy alloocation

- (TransitioningDelegate *)transitioningDelegate {
    if (!_transitioningDelegate) {
        _transitioningDelegate = [[TransitioningDelegate alloc] init];
    }
    return _transitioningDelegate;
}

- (SlideViewController *)slideViewController {
    if (!_slideViewController) {
        _slideViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SlideViewController"];
        _slideViewController.presentationAnimationController = [[PresentationAnimationController alloc] init];
    }
    return _slideViewController;
}


@end
