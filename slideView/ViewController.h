//
//  ViewController.h
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideTransitionProtocol <NSObject>

@optional
- (void)presentSlideViewController;
- (void)dismissSlideViewController;

@end


@interface ViewController : UIViewController <SlideTransitionProtocol>

@end

