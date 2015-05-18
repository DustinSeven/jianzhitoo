//
//  ZGWithdrawalController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/11/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGWithdrawalController.h"
#import "ZGWithdrawalViewIphone.h"

@interface ZGWithdrawalController ()
{
    ZGWithdrawalViewBase *_baseView;
}

@end

@implementation ZGWithdrawalController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[ZGWithdrawalViewIphone alloc]init];
        self.view = _baseView;
        
        [_baseView.headView.backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.alipayBtn addTarget:self action:@selector(payBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.bankBtn addTarget:self action:@selector(payBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

#pragma mark - back button clicked
- (void)backBtnClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - pay btn clicked
- (void)payBtnClicked:(UIButton *)button
{
    ZGWithdrawalDetailController *withdrawalDetailController = [[ZGWithdrawalDetailController alloc]init];
    withdrawalDetailController.enableMoney = self.enableMoney;
    if(button.tag == 101)
        withdrawalDetailController.controllerType = WithdrawalDetailType_Alipay;
    else
        withdrawalDetailController.controllerType = WithdrawalDetailType_Bank;
    [self.navigationController pushViewController:withdrawalDetailController animated:YES];
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
