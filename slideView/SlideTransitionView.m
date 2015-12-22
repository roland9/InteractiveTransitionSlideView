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
@property (nonatomic, weak)   PresentationAnimationController *animationController;

@end


@implementation SlideTransitionView

- (id)initWithFrame:(CGRect)frame
           delegate:(id<SlideTransitionProtocol>)delegate
animationController:(PresentationAnimationController *)animationController
       initialState:(TransitioningState)initialState {
    self = [super initWithFrame:frame];
    
    if (self) {
        _delegate = delegate;
        _initialState = initialState;
        _transitioningState = initialState;
        _animationController = animationController;
        
        self.backgroundColor = [UIColor blueColor];
    }
    
    return self;
}

@end
