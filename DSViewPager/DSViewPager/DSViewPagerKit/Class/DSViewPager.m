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
}

- (void)AddPageWithView:(UIView *)view {
    
}

- (void)setPageViewWithArrayView:(NSArray *)arrayView {
    
}

- (void)reloadUI {
    [self.PageCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.page count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PageCollectionViewCell *cell = (PageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PageCollectionViewCell" forIndexPath:indexPath];
    UIView *pageView = self.page[indexPath.row];
    cell.pageView.frame = pageView.frame;
    [cell.pageTitle setText:[NSString stringWithFormat:@"%tu", indexPath.row]];
    //[cell.pageView addSubview:self.page[indexPath.row]];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return self.frame.size;
}

@end
