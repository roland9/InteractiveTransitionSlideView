//
//  TransitioningDelegate.h
//  slideView
//
//  Created by Roland Gröpmair on 19/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

@import UIKit;
#import "InteractivePresentationTransition.h"

@interface TransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

- (instancetype)initWithInteractiveTransition:(InteractivePresentationTransition *)interactiveTransition;

@end
