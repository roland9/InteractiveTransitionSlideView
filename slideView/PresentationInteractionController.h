//
//  PresentationInteractiveController.h
//  slideView
//
//  Created by Roland Gröpmair on 22/12/15.
//  Copyright © 2015 mApps.ie. All rights reserved.
//

@import UIKit;
#import "SlideTransitionView.h"

@interface PresentationInteractionController : UIPercentDrivenInteractiveTransition

@property (nonatomic, weak) UIViewController<SlideTransitionProtocol> *viewController;

@end
