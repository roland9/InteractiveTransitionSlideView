//
//  TransitioningDelegate.h
//  slideView
//
//  Created by Roland Gröpmair on 19/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

@import UIKit;

#import "PresentationInteractionController.h"
#import "PresentationAnimationController.h"
#import "DismissalAnimationController.h"
#import "DismissalInteractionController.h"

@interface TransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIViewController<SlideTransitionProtocol> *presentingViewController;
@property (nonatomic, strong) UIViewController<SlideTransitionProtocol> *slideViewController;

@end
