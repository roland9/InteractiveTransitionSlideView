//
//  SlideTransitionView.h
//  slideView
//
//  Created by Roland Gröpmair on 13/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InteractiveTransition.h"

@protocol SlideTransitionProtocol <NSObject>

@optional
- (void)presentSlideViewController;
- (void)dismissSlideViewController;

@end


typedef NS_ENUM(NSInteger, TransitioningState) {
    TransitioningStateRight,
    TransitioningStateInteractive,
    TransitioningStateLeft,
};


@interface SlideTransitionView : UIView

- (id)initWithFrame:(CGRect)frame
           delegate:(id<SlideTransitionProtocol>)delegate
         transition:(InteractiveTransition *)transition
       initialState:(TransitioningState)initialState;

@end
