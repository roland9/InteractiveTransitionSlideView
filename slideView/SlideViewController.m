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
@property (nonatomic, strong) SlideTransitionView *slideTransitionView;

@end

#define kSlideTransitionViewWidth   80
#define kSlideTransitionViewHeight  80

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self addSlideTransitionView];
}

- (void)addSlideTransitionView {
    self.slideTransitionView = [[SlideTransitionView alloc] initWithFrame:CGRectMake(0, 0, kSlideTransitionViewWidth, kSlideTransitionViewHeight) delegate:self];
    
    self.slideTransitionView.center = CGPointMake(0, CGRectGetHeight(self.view.bounds)-kSlideTransitionViewHeight);
    [self.view addSubview:self.slideTransitionView];

    self.slideTransitionView.backgroundColor = [UIColor yellowColor];
}

# pragma mark - SlideTransitionProtocol

- (void)dismissSlideViewController {
//    self.modalTransitionStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self.slideTransitionView.transition;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
