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

typedef NS_ENUM(NSInteger, TransitioningState) {
    TransitioningStateRight,
    TransitioningStateInteractive,
    TransitioningStateLeft,
};


@interface ViewController ()

@property (nonatomic, strong) UIView *handleView;
@property (nonatomic, strong) InteractiveTransition *transition;
@property (nonatomic, assign) TransitioningState transitioningState;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    [self addHandleViewAndGestureRecognizer];
}

# pragma mark - handle pan gesture recognizer events

- (void)didPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIGestureRecognizerState state = panGestureRecognizer.state;
    
    if (state == UIGestureRecognizerStateBegan) {
        [self handlePanGestureStateBegan];

    } else if (state == UIGestureRecognizerStateChanged) {
        [self handlePanGestureChanged:panGestureRecognizer];

    } else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled || state == UIGestureRecognizerStateFailed) {
        [self handlePanGestureEndedOrCancelled:panGestureRecognizer];
    }
}

- (void)handlePanGestureStateBegan {
    [self presentSlideViewController];
}

- (void)handlePanGestureChanged:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    CGPoint location = [panGestureRecognizer translationInView:self.view];

    [self moveHandleViewWithX:location.x];

    [self updateInteractiveTransitionWithX:location.x];
}

- (void)handlePanGestureEndedOrCancelled:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    // depending on the velocity & direction of the pan gesture:
    //    a) right: snap back the handle view to original location
    //    b) left:  snap left to reveal view fullly
    
    CGPoint location = [panGestureRecognizer translationInView:self.view];
    BOOL isLocationinLeftHalfOfView = location.x <= CGRectGetWidth(self.view.bounds) / 2.f;

    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    BOOL isDirectionLeft = velocity.x < 0;
    
    if (isLocationinLeftHalfOfView) {
        
        // left half of view
        
        // **********************
        // todoRG here we should take into account velocity, that we can simulate 'slamming' the view into the target position
        // **********************
        
        
        if (isDirectionLeft) {
            [self handlePanFinishWithTargetState:TransitioningStateLeft];
        } else {
            [self handlePanFinishWithTargetState:TransitioningStateRight];
        }
        
    } else {

        // right half of view
        
        if (isDirectionLeft) {
            [self handlePanFinishWithTargetState:TransitioningStateLeft];
        } else {
            [self handlePanFinishWithTargetState:TransitioningStateRight];
        }

    }
}

# pragma mark - Private methods

- (void)moveHandleViewWithX:(CGFloat)x {
    // move the handleView along with the touch events
    NSLog(@"%s: x=%f", __FUNCTION__, x);
    
    CGAffineTransform transformCurrentLocation = CGAffineTransformMakeTranslation(x, 0);
    
    self.handleView.transform = self.transitioningState == TransitioningStateLeft ?
    CGAffineTransformConcat([self transformTranslationHandleViewLeft], transformCurrentLocation) :
    transformCurrentLocation;
}

- (void)updateInteractiveTransitionWithX:(CGFloat)x {
    CGFloat width = CGRectGetWidth(self.view.bounds);
    NSCAssert(self.transition, @"expected transition here");
    
    CGFloat animationRatio = (width - CGRectGetMaxX(self.handleView.frame)) / width;

    NSLog(@"%s: animationRatio=%f", __FUNCTION__, animationRatio);
    [self.transition updateInteractiveTransition:animationRatio];
}

- (void)handlePanFinishWithTargetState:(TransitioningState)state {
    NSCAssert(state == TransitioningStateLeft || state == TransitioningStateRight, @"expected right or left as target");
    
    [UIView animateWithDuration:0.2 delay:0.f usingSpringWithDamping:.6f initialSpringVelocity:.9f options:0 animations:^{
        
        if (state == TransitioningStateLeft) {
            self.handleView.transform = [self transformTranslationHandleViewLeft];
            [self.transition finishInteractiveTransition];

        } else {
            self.handleView.transform = [self transformTranslationHandleViewRight];
            [self.transition cancelInteractiveTransition];
        }
        
    } completion:^(BOOL finished) {
        
        if (state == TransitioningStateLeft) {
            self.transitioningState = TransitioningStateLeft;
            [self.transition didCompleteTransition:YES];
            
        } else {
            self.transitioningState = TransitioningStateRight;
            [self.transition didCompleteTransition:NO];
        }
    }];

}

- (CGAffineTransform)transformTranslationHandleViewLeft {
    return CGAffineTransformMakeTranslation(-CGRectGetWidth(self.view.bounds) + CGRectGetWidth(self.handleView.bounds), 0.f);
}

- (CGAffineTransform)transformTranslationHandleViewRight {
    return CGAffineTransformMakeTranslation(0, 0);
}

- (void)addHandleViewAndGestureRecognizer {
    self.handleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.handleView.backgroundColor = [UIColor blueColor];
    self.handleView.center = CGPointMake(CGRectGetWidth(self.view.bounds)-40, CGRectGetHeight(self.view.bounds)-40);
    self.transitioningState = TransitioningStateRight;
    [self.view addSubview:self.handleView];
    
    // add gesture recognizer
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.handleView addGestureRecognizer:pan];
}

- (void)presentSlideViewController {
    
    self.transition = [[InteractiveTransition alloc] init];
    
    SlideViewController *slideViewController = [[SlideViewController alloc] init];
    slideViewController.modalPresentationStyle = UIModalPresentationCustom;
    slideViewController.transitioningDelegate = self.transition;
    
    [self presentViewController:slideViewController animated:YES completion:nil];
}

@end
