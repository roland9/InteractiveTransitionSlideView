//
//  ViewController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "ViewController.h"
#import "SlideViewController.h"
#import "InteractivePresentTransition.h"

@interface ViewController ()

@property (nonatomic, strong) SlideTransitionView *slideTransitionView;
@property (nonatomic, strong) InteractivePresentTransition *interactivePresentationTransition;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    [self addSlideTransitionView];
}


- (void)addSlideTransitionView {
    self.slideTransitionView =
    [[SlideTransitionView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)
                                      delegate:self
                                    transition:self.interactivePresentationTransition
                                  initialState:TransitioningStateRight];
    self.slideTransitionView.center = CGPointMake(CGRectGetWidth(self.view.bounds)-40, CGRectGetHeight(self.view.bounds)-40);
    [self.view addSubview:self.slideTransitionView];
}


# pragma mark - SlideTransitionProtocol

- (void)presentSlideViewController {
    SlideViewController *slideViewController = [[SlideViewController alloc] init];

    slideViewController.modalPresentationStyle = UIModalPresentationCustom;
    slideViewController.transitioningDelegate = self;
    
    [self presentViewController:slideViewController animated:YES completion:nil];
}


# pragma mark - Properties

- (InteractivePresentTransition *)interactivePresentationTransition {
    if (!_interactivePresentationTransition) {
        _interactivePresentationTransition = [[InteractivePresentTransition alloc] init];
    }
    return _interactivePresentationTransition;
}


# pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    NSLog(@"%s: presentedVC=%@  presentingVC=%@  source=%@", __FUNCTION__, presented, presenting, source);
    return self.interactivePresentationTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    NSLog(@"%s", __FUNCTION__);
    return self.interactivePresentationTransition;
}

@end
