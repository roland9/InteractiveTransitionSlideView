//
//  InteractiveTransition.h
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

@import UIKit;

@interface InteractiveTransition : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

- (void)didCompleteTransition:(BOOL)didComplete;

@end