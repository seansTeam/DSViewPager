//
//  ViewController.m
//  DSViewPager
//
//  Created by Sean Yang on 2015/6/17.
//  Copyright (c) 2015年 Sean Yang. All rights reserved.
//

#import "ViewController.h"
#import "LiveViewPageView.h"

@interface ViewController () <DSViewPagerDelegate>

@property (strong, nonatomic) DSViewPager *sdViewPager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    NSMutableArray *testView = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [testView addObject:[[LiveViewPageView alloc] init]];
    }
    self.sdViewPager = [[DSViewPager alloc] initWithArrayView:testView andWithFrame:self.page.bounds];
    [self.sdViewPager initPagerUIWithFrame:self.page.bounds];
    self.sdViewPager.delegate = self;
    [self.page addSubview:self.sdViewPager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            self.navigationController.navigationBarHidden = NO;
        case UIInterfaceOrientationPortraitUpsideDown:
            
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            self.navigationController.navigationBarHidden = YES;
            break;
            
        default:
            break;
    }
}

- (void)didEnterPage:(NSInteger)page {
    
}

- (void)didLeavePage:(NSInteger)page {
    
}

@end
