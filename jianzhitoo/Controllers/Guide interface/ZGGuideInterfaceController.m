//
//  GuideInterfaceControllerViewController.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGGuideInterfaceController.h"
#import "ZGGuideInterfaceViewIphone.h"
#import "ZGLoginController.h"
#import "ZGMainPageController.h"
#import "ZGLeftMenuController.h"
#import "ZGDrawerController.h"

@interface ZGGuideInterfaceController ()<UIScrollViewDelegate>
{
    ZGGuideInterfaceViewBase *_baseView;
    
    BOOL isEnterMainController;
}



@end

@implementation ZGGuideInterfaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        isEnterMainController = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        UIImageView *view1 = [[UIImageView alloc]init];
        UIImageView *view2 = [[UIImageView alloc]init];
        UIImageView *view3 = [[UIImageView alloc]init];
        
        if(IS_IPHONE4)
        {
            view1.image = [UIImage imageNamed:@"guide_page_img_640x960_1"];
            view2.image = [UIImage imageNamed:@"guide_page_img_640x960_2"];
            view3.image = [UIImage imageNamed:@"guide_page_img_640x960_3"];
        }
        else
        {
            view1.image = [UIImage imageNamed:@"guide_page_img_1"];
            view2.image = [UIImage imageNamed:@"guide_page_img_2"];
            view3.image = [UIImage imageNamed:@"guide_page_img_3"];
        }
        
        self.images = [NSMutableArray array];
        [self.images addObject:view1];
        [self.images addObject:view2];
        [self.images addObject:view3];
        
        _baseView = [[ZGGuideInterfaceViewIphone alloc]init];
        _baseView.images = self.images;
        [_baseView initWitgets];
        _baseView.scrollView.delegate = self;
        
        [_baseView.enterBtn addTarget:self action:@selector(enterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.view = _baseView;
        
//        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
//        NSDictionary *dic = [[NSDictionary alloc]initWithObjects:@[@"55555"] forKeys:@[@"values"]];
//        [[ZGGuideInterfaceProcess shareInstance]listWithParameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"success!");
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"fail!");
//        }];
    }
}

- (void)enterBtnClicked:(UIButton *)button
{
//    ZGLoginController *loginController = [[ZGLoginController alloc]init];
//    [self.navigationController pushViewController:loginController animated:YES];
    
    ZGMainPageController *mainPageController = [[ZGMainPageController alloc]init];
    ZGLeftMenuController *userCenterController = [[ZGLeftMenuController alloc]init];
    
    ZGBaseNavigationController * centerSideNavController = [[ZGBaseNavigationController alloc] initWithRootViewController:mainPageController];
    [centerSideNavController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    ZGBaseNavigationController * leftSideNavController = [[ZGBaseNavigationController alloc] initWithRootViewController:userCenterController];
    [leftSideNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
    
    ZGDrawerController *mainNavigation = [[ZGDrawerController alloc]
                                          initWithCenterViewController:centerSideNavController
                                          leftDrawerViewController:leftSideNavController];
    mainNavigation.showsStatusBarBackgroundView = NO;
    [self.navigationController pushViewController:mainNavigation animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
    [_baseView.pageControl setCurrentPage: targetContentOffset->x / SCREEN_WIDTH ];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if(point.x > ((self.images.count - 1) * SCREEN_WIDTH + 40) && !isEnterMainController)
    {
        [self enterBtnClicked:nil];
        isEnterMainController = YES;
    }
}

@end
