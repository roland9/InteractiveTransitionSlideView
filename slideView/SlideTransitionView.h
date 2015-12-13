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


@interface SlideTransitionView : UIView

- (id)initWithFrame:(CGRect)frame delegate:(id<SlideTransitionProtocol>)delegate;

@property (nonatomic, readonly) InteractiveTransition *transition;

@end
