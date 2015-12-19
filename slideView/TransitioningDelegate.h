//
//  TransitioningDelegate.h
//  slideView
//
//  Created by Roland Gröpmair on 19/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

@import UIKit;
#import "InteractiveTransition.h"

@interface TransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

- (instancetype)initWithInteractiveTransition:(InteractiveTransition *)interactiveTransition;

@end
