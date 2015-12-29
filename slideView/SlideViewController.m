//
//  SlideViewController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "SlideViewController.h"
#import "PresentationAnimationController.h"

@interface SlideViewController ()

@property (nonatomic, strong) UIView *slideTransitionView;

@end

#define kSlideTransitionViewHeight  70.f
#define kSlideTransitionInset       80.f

@implementation SlideViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // instantiate this view already in the initializer, because we need the reference in ViewController.presentSlideViewController
        _slideTransitionView = [[UIView alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self addSlideTransitionView];
}

- (void)addSlideTransitionView {
    NSCAssert(self.presentationAnimationController, @"expected animationController");
    
    
    self.slideTransitionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.slideTransitionView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.slideTransitionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.f constant:-kSlideTransitionInset]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.slideTransitionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.slideTransitionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.f constant:kSlideTransitionInset]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.slideTransitionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kSlideTransitionViewHeight]];
    
    self.slideTransitionView.backgroundColor = [UIColor lightGrayColor];
}

# pragma mark - SlideTransitionProtocol

- (void)dismissSlideViewController {
    NSCAssert(self.delegate, @"expected delegate");
    
    // maybe this helps: http://www.raywenderlich.com/forums/viewtopic.php?f=2&t=18661
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self.delegate;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
