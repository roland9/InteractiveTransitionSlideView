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
@property (nonatomic, weak)   IBOutlet UIView *slideView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"View Controller";
    
    self.transitioningDelegate.slidingViewPresenting = self.slideView;
    self.transitioningDelegate.presentingViewController = self;
}


# pragma mark - SlideTransitionProtocol

- (void)presentSlideViewController {
    SlideViewController *slideViewController = self.slideViewController;
    slideViewController.delegate = self.transitioningDelegate;
    slideViewController.modalPresentationStyle = UIModalPresentationCustom;
    slideViewController.transitioningDelegate = self.transitioningDelegate;
    self.transitioningDelegate.slideViewController = slideViewController;
    
    NSCAssert(slideViewController.slideTransitionView, @"expected slideTransitionView");
    self.transitioningDelegate.slidingViewPresented = slideViewController.slideTransitionView;
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
