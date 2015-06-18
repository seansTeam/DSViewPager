//
//  DSViewPager.h
//  DSViewPager
//
//  Created by Sean Yang on 2015/6/18.
//  Copyright (c) 2015年 Sean Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSViewPager : UIView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *PageCollectionView;

- (id)initWithArrayView:(NSArray *)arrayView andWithFrame:(CGRect)frame;
- (void)setPageViewWithArrayView:(NSArray *)arrayView;
- (void)AddPageWithView:(UIView *)view;
- (void)reloadUI;

@end
