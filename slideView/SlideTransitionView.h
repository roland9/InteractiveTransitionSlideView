//
//  SlideTransitionView.h
//  slideView
//
//  Created by Roland Gröpmair on 13/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InteractiveTransition.h"

typedef NS_ENUM(NSInteger, TransitioningState) {
    TransitioningStateRight,
    TransitioningStateInteractive,
    TransitioningStateLeft,
};


@protocol SlideTransitionProtocol <NSObject>

- (void)presentSlideViewController;

@end


@interface SlideTransitionView : UIView

- (id)initWithFrame:(CGRect)frame delegate:(id<SlideTransitionProtocol>)delegate;

@property (nonatomic, readonly) InteractiveTransition *transition;

@end
