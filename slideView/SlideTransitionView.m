//
//  SlideTransitionView.m
//  slideView
//
//  Created by Roland Gröpmair on 13/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

#import "SlideTransitionView.h"

@interface SlideTransitionView()

@property (nonatomic, assign) TransitioningState initialState;
@property (nonatomic, assign) TransitioningState transitioningState;
@property (nonatomic, weak)   id<SlideTransitionProtocol> delegate;
@property (nonatomic, weak)   InteractiveTransition *transition;

@end


@implementation SlideTransitionView

- (id)initWithFrame:(CGRect)frame
           delegate:(id<SlideTransitionProtocol>)delegate
         transition:(InteractiveTransition *)transition
       initialState:(TransitioningState)initialState {
    self = [super initWithFrame:frame];
    
    if (self) {
        _delegate = delegate;
        _initialState = initialState;
        _transitioningState = initialState;
        _transition = transition;
        
        self.backgroundColor = [UIColor blueColor];

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
        [self addGestureRecognizer:pan];
    }
    
    return self;
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
    
    if ([self.delegate respondsToSelector:@selector(presentSlideViewController)]) {
        [self.delegate presentSlideViewController];
        
    } else if ([self.delegate respondsToSelector:@selector(dismissSlideViewController)]) {
        [self.delegate dismissSlideViewController];
    }
}

- (void)handlePanGestureChanged:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint location = [panGestureRecognizer translationInView:self.superview];
    
    [self moveHandleViewWithX:location.x];
    
    [self updateInteractiveTransitionWithX:location.x];
}

- (void)handlePanGestureEndedOrCancelled:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    // depending on the velocity & direction of the pan gesture:
    //    a) right: snap back the handle view to original location
    //    b) left:  snap left to reveal view fullly
    
    CGPoint location = [panGestureRecognizer translationInView:self.superview];
    BOOL isLocationinLeftHalfOfView = location.x <= CGRectGetWidth(self.superview.bounds) / 2.f;
    
    CGPoint velocity = [panGestureRecognizer velocityInView:self.superview];
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
    
    self.transform = self.transitioningState == TransitioningStateLeft ?
    CGAffineTransformConcat([self transformTranslationHandleViewLeft], transformCurrentLocation) :
    transformCurrentLocation;
}

- (void)updateInteractiveTransitionWithX:(CGFloat)x {
    CGFloat width = CGRectGetWidth(self.superview.bounds);
    NSCAssert(self.transition, @"expected transition here");
    
    CGFloat animationRatio = (width - CGRectGetMaxX(self.frame)) / width;
    
    NSLog(@"%s: animationRatio=%f", __FUNCTION__, animationRatio);
    [self.transition updateInteractiveTransition:animationRatio];
}

- (void)handlePanFinishWithTargetState:(TransitioningState)state {
    NSCAssert(state == TransitioningStateLeft || state == TransitioningStateRight, @"expected right or left as target");
    
    [UIView animateWithDuration:0.2 delay:0.f usingSpringWithDamping:.6f initialSpringVelocity:.9f options:0 animations:^{
        
        if (state == TransitioningStateLeft) {
            self.transform = [self transformTranslationHandleViewLeft];
            if (self.initialState == TransitioningStateRight) {
                [self.transition finishInteractiveTransition];
            } else {
                [self.transition cancelInteractiveTransition];
            }
            
        } else {
            self.transform = [self transformTranslationHandleViewRight];
            if (self.initialState == TransitioningStateLeft) {
                [self.transition finishInteractiveTransition];
            } else {
                [self.transition cancelInteractiveTransition];
            }
        }
        
    } completion:^(BOOL finished) {
        
        if (state == TransitioningStateLeft) {
            self.transitioningState = TransitioningStateLeft;
            [self.transition didCompleteTransition:self.initialState == TransitioningStateLeft ? NO : YES];
            
        } else {
            self.transitioningState = TransitioningStateRight;
            [self.transition didCompleteTransition:self.initialState == TransitioningStateRight ? NO : YES];
        }
    }];
    
}

- (CGAffineTransform)transformTranslationHandleViewLeft {
    return CGAffineTransformMakeTranslation(-CGRectGetWidth(self.superview.bounds) + CGRectGetWidth(self.bounds), 0.f);
}

- (CGAffineTransform)transformTranslationHandleViewRight {
    return CGAffineTransformMakeTranslation(0, 0);
}

@end
