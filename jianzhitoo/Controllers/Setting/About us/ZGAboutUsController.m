//
//  ZGAboutUsController.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAboutUsController.h"

@interface ZGAboutUsController ()
{
    ZGAboutUsViewBase *_baseView;
}

@end

@implementation ZGAboutUsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(IS_PHONE)
    {
        self.title = @"关于我们";
        _baseView = [[ZGAboutUsViewIphone alloc]init];
        self.view = _baseView;
        
//        self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(backBtnClicked:) spacing:-15];
    }
}

//#pragma mark - backBtnClicked
//- (void)backBtnClicked:(UIButton *)button
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

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
