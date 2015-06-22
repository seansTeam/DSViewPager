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
    
    // Observer when device orientation.
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)dealloc {
    // Remove observer.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)initControlPanel {
    // !!!: Fake data.
}

- (void)orientationChanged:(NSNotification *)notification {
    UIDeviceOrientation uiDeviceOrientation = [UIDevice currentDevice].orientation;
    // Portrait
    if (uiDeviceOrientation == UIInterfaceOrientationPortrait) {
        
    }
    // Landscape
    else if (uiDeviceOrientation == UIInterfaceOrientationLandscapeLeft ||
             uiDeviceOrientation == UIInterfaceOrientationLandscapeRight) {
        //self.movieView.frame = self.bounds;
    }
}

@end
