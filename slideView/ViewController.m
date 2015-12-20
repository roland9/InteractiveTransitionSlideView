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
#import "TransitioningDelegate.h"

@interface ViewController ()

@property (nonatomic, strong) TransitioningDelegate *transitioningDelegate;
@property (nonatomic, strong) InteractiveTransition *interactiveTransition;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"View Controller";
    
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
    SlideViewController *slideViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SlideViewController"];
    slideViewController.delegate = self.transitioningDelegate;
    slideViewController.interactiveTransition = self.interactiveTransition;
    slideViewController.transitioningDelegate = self.transitioningDelegate;
    slideViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:slideViewController animated:YES completion:nil];
}


# pragma mark - Properties

- (InteractiveTransition *)interactiveTransition {
    if (!_interactiveTransition) {
        _interactiveTransition = [[InteractiveTransition alloc] init];
    }
    return _interactiveTransition;
}

- (TransitioningDelegate *)transitioningDelegate {
    if (!_transitioningDelegate) {
        _transitioningDelegate = [[TransitioningDelegate alloc] initWithInteractiveTransition:self.interactiveTransition];
    }
    return _transitioningDelegate;
}

@end
