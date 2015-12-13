//
//  SlideViewController.m
//  
//
//  Created by Roland Gröpmair on 14/06/2015.
//
//

#import "SlideViewController.h"

@interface SlideViewController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *handleView;

@end


@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

//    [self addHandleViewAndGestureRecognizer];
}

- (void)didPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    NSLog(@"%s", __FUNCTION__);
}

- (void)addHandleViewAndGestureRecognizer {
    self.handleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.handleView.backgroundColor = [UIColor yellowColor];
    self.handleView.center = CGPointMake(0, CGRectGetHeight(self.view.bounds)-40);
    [self.view addSubview:self.handleView];
    
    // add gesture recognizer
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.handleView addGestureRecognizer:pan];
}

@end
