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
@property (nonatomic) CGRect portraitFrame;
@property (nonatomic) CGRect scrollViewFrame;

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

- (void)initPagerUIWithFrame:(CGRect)frame andDelegate:(id)delegate {
    self.portraitFrame = frame;
    self.scrollViewFrame = self.pageScrollView.bounds;
    [self createPagesWithArrayView:self.page andFrame:(CGRect)frame andDelegate:delegate];
}

- (void)AddPageWithView:(UIView *)view {
    
}

- (void)setPageViewWithArrayView:(NSArray *)arrayView {
    
}

- (void)createPagesWithArrayView:(NSArray *)page andFrame:(CGRect)frame andDelegate:(id)delegate {
    NSInteger numberOfPages = [page count];
    
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

- (void)updatePageToLandscape {
    NSInteger numberOfPages = [self.page count];
    for (int i = 0; i < numberOfPages; i++) {
        
        [self.page[i] setFrame:CGRectMake(CGRectGetWidth(self.pageScrollView.bounds) * i, 0, CGRectGetWidth(self.pageScrollView.bounds), CGRectGetHeight(self.pageScrollView.bounds))];
    }
    
    [self.pageScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.pageScrollView.bounds) * (numberOfPages), 0)];
}

- (void)updatePageToPortrait {
    NSInteger numberOfPages = [self.page count];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    for (int i = 0; i < numberOfPages; i++) {
        [self.page[i] setFrame:CGRectMake(CGRectGetWidth(screenRect) * i, 0, CGRectGetWidth(screenRect), CGRectGetHeight(self.scrollViewFrame))];
    }
    
    [self.pageScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.portraitFrame) * (numberOfPages), 0)];
}

- (void)updatePager {
    CGFloat pageWidth = self.pageScrollView.frame.size.width;
    NSInteger currentPageIndex =  floor((self.pageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (self.currentPageIndex != currentPageIndex) {
        [self.delegate didLeavePage:self.currentPageIndex];
        
        self.currentPageIndex = currentPageIndex;
        [self.delegate didEnterPage:self.currentPageIndex];
        NSLog(@"%tu", currentPageIndex);
    }
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
        [self updatePageToPortrait];
    }
    // Landscape
    else if (uiDeviceOrientation == UIInterfaceOrientationLandscapeLeft ||
             uiDeviceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self updatePageToLandscape];
    }
    [self moveToCurrentPage:self.currentPageIndex];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updatePager];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updatePager];
}
@end
