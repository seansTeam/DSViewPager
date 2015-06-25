//
//  DSViewPager.h
//  DSViewPager
//
//  Created by Sean Yang on 2015/6/18.
//  Copyright (c) 2015年 Sean Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSViewPagerDelegate <NSObject>

@optional
- (void)didEnterPage:(NSInteger)page;
- (void)didLeavePage:(NSInteger)page;

@end

@interface DSViewPager : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *pageScrollView;
@property (weak) id<DSViewPagerDelegate> delegate;

- (id)initWithArrayView:(NSArray *)arrayView andWithFrame:(CGRect)frame;
- (void)initPagerUIWithFrame:(CGRect)frame andDelegate:(id)delegate;
- (void)setPageViewWithArrayView:(NSArray *)arrayView;
- (void)AddPageWithView:(UIView *)view;

- (void)moveToCurrentPage:(NSInteger)page;

@end
