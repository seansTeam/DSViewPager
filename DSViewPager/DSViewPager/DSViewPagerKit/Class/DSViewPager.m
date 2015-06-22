//
//  DSViewPager.m
//  DSViewPager
//
//  Created by Sean Yang on 2015/6/18.
//  Copyright (c) 2015年 Sean Yang. All rights reserved.
//

#import "DSViewPager.h"
#import "PageCollectionViewCell.h"

@interface DSViewPager ()

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
    
    self.PageCollectionView.delegate = self;
    self.PageCollectionView.dataSource = self;
    [self.PageCollectionView registerClass:[PageCollectionViewCell class] forCellWithReuseIdentifier:@"PageCollectionViewCell"];
    self.currentPageIndex = 0;
    
    // Observer when device orientation.
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)dealloc {
    // Remove observer.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)AddPageWithView:(UIView *)view {
    
}

- (void)setPageViewWithArrayView:(NSArray *)arrayView {
    
}

- (void)reloadUI {
    [self.PageCollectionView reloadData];
}

- (void)updatePager {
    [self.delegate didLeavePage:self.currentPageIndex];
    CGFloat pageWidth = self.PageCollectionView.frame.size.width;
    NSInteger currentPageIndex =  floor((self.PageCollectionView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.currentPageIndex = currentPageIndex;
    [self.delegate didEnterPage:self.currentPageIndex];
    NSLog(@"%tu", currentPageIndex);
}

- (void)moveToCurrentPage:(NSInteger)page {
    [self.PageCollectionView setContentOffset:CGPointMake(CGRectGetWidth(self.PageCollectionView.bounds)*page,0) animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.page count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PageCollectionViewCell *cell = (PageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PageCollectionViewCell" forIndexPath:indexPath];
    UIView *pageView = self.page[indexPath.row];
    cell.pageView.frame = pageView.frame;
    [cell.pageTitle setText:[NSString stringWithFormat:@"%tu", indexPath.row]];
    for (UIView *view in cell.pageView.subviews) {
        if (view != self.page[indexPath.row]) {
            [view removeFromSuperview];
            [cell.pageView addSubview:pageView];
        }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return self.frame.size;
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
