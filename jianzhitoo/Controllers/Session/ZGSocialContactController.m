//
//  ZGSocialController.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/6.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGSocialContactController.h"
#import "ZGSocialContactViewIphone.h"

@interface ZGSocialContactController ()
{
    ZGSocialContactViewBase *_baseView;
    
    ZGSessionController *sessionController;
    ZGContactController *contactController;
}

@end

@implementation ZGSocialContactController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[ZGSocialContactViewIphone alloc]init];
        self.view = _baseView;
        
        [self initRootView];
    }
}

- (void)initRootView
{
    self.title = @"消息";
    self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(menuBtnClicked:) spacing:-15];
    
    contactController = [[ZGContactController alloc]init];
    [contactController.view setNeedsLayout];
    sessionController = [[ZGSessionController alloc]init];
    [self addChildViewController:contactController];
    [self addChildViewController:sessionController];
    [self.view addSubview:sessionController.view];
    
    [_baseView.segController addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
}

-(void)segChange:(id)sender
{
    int index = (int)_baseView.segController.selectedSegmentIndex;
    
    if(index == 0)
    {
        [self transitionFromViewController:contactController toViewController:sessionController duration:0.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
        } completion:^(BOOL finished) {
            
         self.title = @"消息";
            
        }];
    }
    
    if(index == 1)
    {
        [self transitionFromViewController:sessionController toViewController:contactController duration:0.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
        } completion:^(BOOL finished) {
          
            [sessionController closeAllCell];
            self.title = @"联系人";
        }];
    }
}

#pragma mark - menuBtnClicked
- (void)menuBtnClicked:(UIButton *)btn
{
    [sessionController closeAllCell];
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
