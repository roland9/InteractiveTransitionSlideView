//
//  ViewController.m
//  slideView
//
//  Created by Roland Gröpmair on 14/06/2015.
//  Copyright (c) 2015 mApps.ie. All rights reserved.
//

#import "ViewController.h"
#import "SlideViewController.h"

@interface ViewController ()

@property (nonatomic, strong) SlideTransitionView *slideTransitionView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    [self addSlideTransitionView];
}


- (void)addSlideTransitionView {
    self.slideTransitionView = [[SlideTransitionView alloc] initWithFrame:CGRectMake(0, 0, 80, 80) delegate:self];
    self.slideTransitionView.center = CGPointMake(CGRectGetWidth(self.view.bounds)-40, CGRectGetHeight(self.view.bounds)-40);
    [self.view addSubview:self.slideTransitionView];
}


# pragma mark - SlideTransitionProtocol

- (void)presentSlideViewController {
    SlideViewController *slideViewController = [[SlideViewController alloc] init];

    slideViewController.modalPresentationStyle = UIModalPresentationCustom;
    slideViewController.transitioningDelegate = self.slideTransitionView.transition;
    
    [self presentViewController:slideViewController animated:YES completion:nil];
}

@end
