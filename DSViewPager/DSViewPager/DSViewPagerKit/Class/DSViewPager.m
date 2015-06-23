//
//  DSViewPager.m
//  DSViewPager
//
//  Created by Sean Yang on 2015/6/18.
//  Copyright (c) 2015年 Sean Yang. All rights reserved.
//

#import "DSViewPager.h"

@interface DSViewPager () <UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *page;
@property (nonatomic) NSInteger currentPageIndex;

@end

@implementation DSViewPager

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"DSViewPager" owner:nil options:nil];
        DSViewPager *DSViewPager = [views lastObject];
        DSViewPager.frame = frame;
        self = DSViewPager;
        return self;
    }
    return self;
}

- (id)initWithArrayView:(NSArray *)arrayView andWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"DSViewPager" owner:nil options:nil];
        DSViewPager *DSViewPager = [views lastObject];
        DSViewPager.frame = frame;
        DSViewPager.page = [[NSMutableArray alloc] initWithArray:arrayView];
        self = DSViewPager;
        return self;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
    self.currentPageIndex = 0;
    self.pageScrollView.delegate = self;
    // Observer when device orientation.
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)dealloc {
    // Remove observer.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)initPagerUIWithFrame:(CGRect)frame {
    [self createPagesWithArrayView:self.page andFrame:(CGRect)frame];
}

- (void)AddPageWithView:(UIView *)view {
    
}

- (void)setPageViewWithArrayView:(NSArray *)arrayView {
    
}

- (void)reloadUI {
    [self.PageCollectionView reloadData];
}

- (void)createPagesWithArrayView:(NSArray *)page andFrame:(CGRect)frame {
    NSInteger numberOfPages = [page count];
    //self.pageBackgroundViews = [[NSMutableArray alloc] init];
    
    for (UIView *view in self.pageScrollView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < numberOfPages; i++) {

        [page[i] setFrame:CGRectMake(CGRectGetWidth(frame) * i, 0, CGRectGetWidth(self.pageScrollView.bounds), CGRectGetHeight(self.pageScrollView.bounds))];

        // Get double click event to prevent double click crash when mediaplayer stop
        [self headOffDoubleClickGesture:page[i]];
        
        [self.pageScrollView addSubview:page[i]];
    }
    
    [self.pageScrollView setContentSize:CGSizeMake(CGRectGetWidth(frame) * (numberOfPages), 0)];
}

- (void)updatePager {
    [self.delegate didLeavePage:self.currentPageIndex];
    CGFloat pageWidth = self.pageScrollView.frame.size.width;
    NSInteger currentPageIndex =  floor((self.pageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.currentPageIndex = currentPageIndex;
    [self.delegate didEnterPage:self.currentPageIndex];
    NSLog(@"%tu", currentPageIndex);
}

- (void)moveToCurrentPage:(NSInteger)page {
    [self.pageScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.pageScrollView.bounds)*page,0) animated:YES];
}

- (void)headOffDoubleClickGesture:(UIView *)view {
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(respondToTapGesture:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [view addGestureRecognizer:tapRecognizer];
}

- (IBAction)respondToTapGesture:(UITapGestureRecognizer *)recognizer {
    NSLog(@"Double click bug"); // FIXME: Get double click to fix vlc crash bug.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.page count];
}

- (void)orientationChanged:(NSNotification *)notification {
    UIDeviceOrientation uiDeviceOrientation = [UIDevice currentDevice].orientation;
    // Portrait
    if (uiDeviceOrientation == UIInterfaceOrientationPortrait) {
        
    }
    // Landscape
    else if (uiDeviceOrientation == UIInterfaceOrientationLandscapeLeft ||
             uiDeviceOrientation == UIInterfaceOrientationLandscapeRight) {
        
    }
    [self moveToCurrentPage:self.currentPageIndex];
    [self reloadUI];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updatePager];
}

@end
