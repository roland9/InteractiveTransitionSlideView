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

@property (nonatomic, strong) UIView *handleView;
@property (nonatomic, strong) InteractiveTransition *transition;
@property (nonatomic, assign) BOOL isHandleViewLeft;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];
    
    // add handle view
    self.handleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.handleView.backgroundColor = [UIColor blueColor];
    self.handleView.center = CGPointMake(CGRectGetWidth(self.view.bounds)-40, CGRectGetHeight(self.view.bounds)-40);
    self.isHandleViewLeft = NO;
    [self.view addSubview:self.handleView];
    
    // add gesture recognizer
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.handleView addGestureRecognizer:pan];
}

- (void)didPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIGestureRecognizerState state = panGestureRecognizer.state;
    
    if (state == UIGestureRecognizerStateBegan) {
        [self handlePanGestureStateBegan];
        return;
    }
    
    if (state == UIGestureRecognizerStateChanged) {
        [self handlePanGestureChanged:panGestureRecognizer];
        return;
    }
    
    if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
        [self handlePanGestureEndedOrCancelled:panGestureRecognizer];
        return;
    }
}

- (void)handlePanGestureStateBegan {
    //        [self presentSlideViewController];
}

- (void)handlePanGestureChanged:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    // move the handleView along with the touch events
    
    CGPoint location = [panGestureRecognizer translationInView:self.view];
    CGAffineTransform transformCurrentLocation = CGAffineTransformMakeTranslation(location.x, 0);
    
    self.handleView.transform = self.isHandleViewLeft ?
    CGAffineTransformConcat([self transformTranslationHandleViewLeft], transformCurrentLocation) :
    transformCurrentLocation;
    
    NSLog(@"%s: location=%@  leftEdgeHandleView=%f", __FUNCTION__, NSStringFromCGPoint(location), CGRectGetMinX(self.handleView.frame));
    //        CGFloat width = CGRectGetWidth(self.view.bounds);
    //        NSCAssert(self.transition, @"expected transition here");
    //        CGFloat animationRatio = (width - CGRectGetMinX(self.handleView.frame)) / width;
    //        [self.transition updateInteractiveTransition:animationRatio];
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
            [self handlePanFinishToLeft];
        } else {
            [self handlePanFinishToRight];
        }
        
    } else {

        // right half of view
        
        if (isDirectionLeft) {
            [self handlePanFinishToLeft];
        } else {
            [self handlePanFinishToRight];
        }

    }
}

- (void)handlePanFinishToLeft {
    [self handlePanFinishWithDirectionLeft:YES];
}

- (void)handlePanFinishToRight {
    [self handlePanFinishWithDirectionLeft:NO];
}

- (void)handlePanFinishWithDirectionLeft:(BOOL)isDirectionLeft {
    [UIView animateWithDuration:0.2 delay:0.f usingSpringWithDamping:.6f initialSpringVelocity:.9f options:0 animations:^{
        if (isDirectionLeft) {
            self.handleView.transform = [self transformTranslationHandleViewLeft];
        } else {
            self.handleView.transform = [self transformTranslationHandleViewRight];
        }
    } completion:^(BOOL finished) {
        //                [self.transition cancelInteractiveTransition];
        if (isDirectionLeft) {
            self.isHandleViewLeft = YES;
        } else {
            self.isHandleViewLeft = NO;
        }
    }];

}

- (CGAffineTransform)transformTranslationHandleViewLeft {
    return CGAffineTransformMakeTranslation(-CGRectGetWidth(self.view.bounds) + CGRectGetWidth(self.handleView.bounds), 0.f);
}

- (CGAffineTransform)transformTranslationHandleViewRight {
    return CGAffineTransformMakeTranslation(0, 0);
}

- (void)presentSlideViewController {
    // check that it's not already shown
    if (self.transition) {
        return;
    }
    
    self.transition = [[InteractiveTransition alloc] init];
    
    SlideViewController *slideViewController = [[SlideViewController alloc] init];
    slideViewController.modalPresentationStyle = UIModalPresentationCustom;
    slideViewController.transitioningDelegate = self.transition;
    
    [self presentViewController:slideViewController animated:YES completion:nil];
}

@end
