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

@property (nonatomic, weak) id<UIViewControllerTransitioningDelegate>delegate;
@property (nonatomic, strong) PresentationAnimationController *presentationAnimationController;
@property (nonatomic, readonly) SlideTransitionView *slideTransitionView;

@end
