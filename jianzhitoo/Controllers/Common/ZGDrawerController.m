//
//  ZGDrawerController.m
//  jianzhitoo
//
//  Created by 李明伟 on 14/12/29.
//  Copyright (c) 2014年 Lee Mingwei. All rights reserved.
//

#import "ZGDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface ZGDrawerController ()

@end

@implementation ZGDrawerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController
{
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    img.image = [UIImage imageNamed:@"user_center_bg_640x1136"];
    [self.view addSubview:img];
    self = [super initWithCenterViewController:centerViewController leftDrawerViewController:leftDrawerViewController];
    if(self)
    {
        [self setMaximumLeftDrawerWidth:LEFT_DRAWER_WIDTH];
        [self setMaximumRightDrawerWidth:LEFT_DRAWER_WIDTH];
        [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar | MMOpenDrawerGestureModePanningCenterView | MMOpenDrawerGestureModeBezelPanningCenterView | MMOpenDrawerGestureModeCustom];
        [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [self setRestorationIdentifier:@"MMDrawer"];
        self.showsStatusBarBackgroundView = YES;
        self.statusBarViewBackgroundColor = [UIColor blackColor];
        [self setShowsShadow:NO];
        [self setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
             MMDrawerControllerDrawerVisualStateBlock block;
//             block = [MMDrawerVisualState parallaxVisualStateB lockWithParallaxFactor:2.0];
             block = [MMDrawerVisualState slideAndScaleVisualStateBlock];
             if(block)
             {
                 block(drawerController, drawerSide, percentVisible);
             }
         }];
        
        self.shouldStretchDrawer = NO;

        
        
    }
    return self;
}

@end
