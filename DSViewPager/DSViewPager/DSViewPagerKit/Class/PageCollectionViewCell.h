//
//  PageCollectionViewCell.h
//  DSViewPager
//
//  Created by Sean Yang on 2015/6/17.
//  Copyright (c) 2015年 Sean Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *pageView;
@property (weak, nonatomic) IBOutlet UILabel *pageTitle;

@end
