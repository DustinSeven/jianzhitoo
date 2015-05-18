//
//  ZGBaseController.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseController.h"
#import "MMDrawerVisualState.h"

@implementation ZGBaseController

- (id)init
{
    self = [super init];
    if(self)
    {
//        UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
//        [doubleTap setNumberOfTapsRequired:2];
//        [self.view addGestureRecognizer:doubleTap];
//
//        UITapGestureRecognizer * twoFingerDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerDoubleTap:)];
//        [twoFingerDoubleTap setNumberOfTapsRequired:2];
//        [twoFingerDoubleTap setNumberOfTouchesRequired:2];
//        [self.view addGestureRecognizer:twoFingerDoubleTap];
//        
//        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeTap:)];
//        [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
//        [self.view addGestureRecognizer:swipe];
    }
    return self;
}

- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO; //右滑返回上一级
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.navigationController.viewControllers.count > 1)
    {
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    }
    else
    {
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [self.mm_drawerController setShowsShadow:YES];
    }
}

#pragma mark - Button Handlers
-(void)swipeTap:(UISwipeGestureRecognizer *)sender{
    //    sender.direction;
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
//
//-(void)rightDrawerButtonPress:(id)sender{
//    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
//}

-(void)doubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

-(void)twoFingerDoubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideRight completion:nil];
}

@end
