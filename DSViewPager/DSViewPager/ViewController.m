//
//  ViewController.m
//  DSViewPager
//
//  Created by Sean Yang on 2015/6/17.
//  Copyright (c) 2015年 Sean Yang. All rights reserved.
//

#import "ViewController.h"
#import "LiveViewPageView.h"

@interface ViewController ()

@property (strong, nonatomic) DSViewPager *sdViewPager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *testView = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [testView addObject:[[LiveViewPageView alloc] init]];
    }
    
    self.sdViewPager = [[DSViewPager alloc] initWithArrayView:testView andWithFrame:self.page.bounds];
    //self.page = self.sdViewPager;
    [self.page addSubview:self.sdViewPager];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
