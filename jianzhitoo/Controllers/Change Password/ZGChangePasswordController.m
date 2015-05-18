//
//  ZGChangePasswordController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGChangePasswordController.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGChangePwdProcess.h"
#import "ZGPasswordParam.h"


@interface ZGChangePasswordController ()<UITextFieldDelegate>
{
    ZGChangePasswordViewBase *_baseView;

    ZGUserInfoEntity *userInfoEntity;
}

@end

@implementation ZGChangePasswordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if(IS_PHONE)
    {
        self.title = @"修改密码";
        
        userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
        
        _baseView = [[ZGChangePasswordViewIphone alloc]init];
        self.view = _baseView;
      
        _baseView.oldPwdText.delegate = self;
        _baseView.pwdText.delegate = self;
        _baseView.pwdAgainText.delegate = self;
        
        [_baseView.changeBtn addTarget:self action:@selector(changeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (void)changeBtnClicked:(UIButton *)button
{
    ZGPasswordParam *param = [[ZGPasswordParam alloc]init];
    
    if([_baseView.oldPwdText.text isEqualToString:@""])
    {
        [ZGUtility showAlertWithText:@"请输入旧密码!" parentView:nil];
        return;
    }
    
    if([_baseView.pwdText.text isEqualToString:@""])
    {
        [ZGUtility showAlertWithText:@"请输入新密码!" parentView:nil];
        return;
    }
    
    if([_baseView.pwdAgainText.text isEqualToString:@""])
    {
        [ZGUtility showAlertWithText:@"请再次输入新密!" parentView:nil];
        return;
    }
    
    if(![_baseView.pwdAgainText.text isEqualToString:_baseView.pwdText.text])
    {
        [ZGUtility showAlertWithText:@"两次输入密码不一致!" parentView:nil];
        return;
    }
    if(userInfoEntity)
    {
        param.userId = userInfoEntity.identity;
        param.password = _baseView.oldPwdText.text;
        param.mobile = userInfoEntity.mobile;
        param.changedPwd = _baseView.pwdText.text;
        
        [[ZGChangePwdProcess shareInstance]updatePwdWithParam:[param getDictionary] parentView:nil progressText:@"提交中..." success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            if([[responseObject objectForKey:@"code"]intValue] == 200)
            {
                ZGCommonAlertViewIphone *alertView = [ZGUtility showAlertWithText:@"密码修改成功，返回登录页面！" parentView:nil];
                [alertView.btn addTarget:self action:@selector(enterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
        }];
    }
}

- (void)enterBtnClicked:(UIButton *)button
{
    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];

    ZGLoginController *loginController = [[ZGLoginController alloc]init];
    ZGBaseNavigationController *loginNav = [[ZGBaseNavigationController alloc] initWithRootViewController:loginController];
    [self presentViewController:loginNav animated:YES completion:^{
        
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = ChangePwdTextBorderColorClicked.CGColor;
    if(textField.tag == 101)
    {
        _baseView.oldPwdTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_pressed"];
    }
    if(textField.tag == 102)
    {
        _baseView.pwdTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_pressed"];
    }
    if(textField.tag == 103)
    {
        _baseView.pwdAgainTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_pressed"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderColor = ChangePwdTextBorderColorNormal.CGColor;
    if(textField.tag == 101)
    {
        _baseView.oldPwdTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_normal"];
    }
    if(textField.tag == 102)
    {
        _baseView.pwdTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_normal"];
    }
    if(textField.tag == 103)
    {
        _baseView.pwdAgainTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_normal"];
    }
}

- (void)didReceiveMemoryWarning
{
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
