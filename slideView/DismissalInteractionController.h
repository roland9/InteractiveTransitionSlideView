//
//  DismissalInteractionController.h
//  slideView
//
//  Created by Roland Gröpmair on 22/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

@import UIKit;
#import "ViewController.h"

@interface DismissalInteractionController : UIPercentDrivenInteractiveTransition

@property (nonatomic, weak) UIViewController<SlideTransitionProtocol> *viewController;
@property (nonatomic, weak) UIView *slidingView;

@end
