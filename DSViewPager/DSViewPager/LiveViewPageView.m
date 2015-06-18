//
//  ControlPanelView.m
//  BabyDiary
//
//  Created by Sean Yang on 2015/1/29.
//  Copyright (c) 2015年 sean.yang. All rights reserved.
//

#import "LiveViewPageView.h"

@implementation LiveViewPageView

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"LiveViewPageView" owner:self options:nil];
    LiveViewPageView *liveViewPageView = [views lastObject];

    [liveViewPageView initControlPanel];
    return liveViewPageView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)initControlPanel {
    // !!!: Fake data.
}

@end
