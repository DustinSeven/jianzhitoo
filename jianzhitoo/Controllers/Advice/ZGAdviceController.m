//
//  ZGAdviceController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAdviceController.h"
#import "ZGAdviceProcess.h"
#import "ZGAdviceParam.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"

@interface ZGAdviceController ()<UITextViewDelegate>
{
    ZGAdviceViewBase *_baseView;
    
    ZGUserInfoEntity *userInfoEntity;
}

@end

@implementation ZGAdviceController

- (void)viewDidLoad
{
    [super viewDidLoad];

    userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    
    _baseView = [[ZGAdviceViewIphone alloc]init];
    self.view = _baseView;
    
    [_baseView.headView.backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _baseView.adviceText.delegate = self;
    
    [_baseView.adviceBtn addTarget:self action:@selector(adviceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - advice btn clicked
- (void)adviceBtnClicked:(UIButton *)button
{
    NSString *text = [_baseView.adviceText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    if([text isEqualToString:@""])
    {
        [ZGUtility showAlertWithText:@"您还没输入任何内容!" parentView:nil];
        return;
    }
    
    ZGAdviceParam *param = [[ZGAdviceParam alloc]init];
    if(userInfoEntity)
    {
        param.userId = userInfoEntity.identity;
        param.account = userInfoEntity.account;
    }
    if(userInfoEntity)
    {
        param.mobile = userInfoEntity.mobile;
        param.qq = userInfoEntity.qq;
    }
    param.content = _baseView.adviceText.text;
    
    [[ZGAdviceProcess shareInstance]adviceWithParam:[param getDictionary] parentView:nil progressText:@"加载中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
    }];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (_baseView.adviceText.text.length == 0) {
        _baseView.adviceTextPlaceHolderLab.text = _baseView.placeHolder;
    }else{
        _baseView.adviceTextPlaceHolderLab.text = @"";
    }
}

#pragma mark - back button clicked
- (void)backBtnClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
