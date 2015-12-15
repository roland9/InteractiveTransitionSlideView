//
//  SlideViewController.m
//  
//
//  Created by Roland Gröpmair on 14/06/2015.
//
//

#import "SlideViewController.h"
#import "InteractiveDismissTransition.h"

@interface SlideViewController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) SlideTransitionView *slideTransitionView;
@property (nonatomic, strong) InteractiveDismissTransition *interactiveDismissTransition;

@end

#define kSlideTransitionViewWidth   80
#define kSlideTransitionViewHeight  80

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self addSlideTransitionView];
}

- (void)addSlideTransitionView {
    self.slideTransitionView =
    [[SlideTransitionView alloc] initWithFrame:CGRectMake(0, 0, kSlideTransitionViewWidth, kSlideTransitionViewHeight)
                                      delegate:self
                                    transition:self.interactiveDismissTransition
                                  initialState:TransitioningStateLeft];
  
    self.slideTransitionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.slideTransitionView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.slideTransitionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.slideTransitionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.slideTransitionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kSlideTransitionViewWidth]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.slideTransitionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kSlideTransitionViewHeight]];

    self.slideTransitionView.backgroundColor = [UIColor yellowColor];
}

# pragma mark - SlideTransitionProtocol

- (void)dismissSlideViewController {
    self.transitioningDelegate = self;
    [self dismissViewControllerAnimated:YES completion:nil];
}


# pragma mark - Properties

- (InteractiveDismissTransition *)interactiveDismissTransition {
    if (!_interactiveDismissTransition) {
        _interactiveDismissTransition = [[InteractiveDismissTransition alloc] init];
    }
    return _interactiveDismissTransition;
}


# pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    NSLog(@"%s: presentedVC=%@  presentingVC=%@  source=%@", __FUNCTION__, presented, presenting, source);
    return self.interactiveDismissTransition;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    NSLog(@"%s: dismissedVC=%@", __FUNCTION__, dismissed);
    return self.interactiveDismissTransition;
}

@end
