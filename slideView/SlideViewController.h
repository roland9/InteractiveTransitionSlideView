//
//  SlideViewController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideTransitionView.h"

@interface SlideViewController : UIViewController <SlideTransitionProtocol>

//- (instancetype)initWithDelegate:(id<UIViewControllerTransitioningDelegate>)delegate interactiveTransition:(InteractiveTransition *)interactiveTransition;

@property (nonatomic, weak) id<UIViewControllerTransitioningDelegate>delegate;
@property (nonatomic, weak) InteractivePresentationTransition *interactiveTransition;

@end
