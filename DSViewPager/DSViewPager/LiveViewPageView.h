//
//  LiveViewPageView.h
//  BabyDiary
//
//  Created by Sean Yang on 2015/1/29.
//  Copyright (c) 2015年 sean.yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveViewPageView : UIView 

@property (weak, nonatomic) IBOutlet UIView *controlPanelView;
@property (weak, nonatomic) IBOutlet UIView *movieView;
@property (strong, nonatomic) NSMutableArray *pageBackgroundViews;


@end
