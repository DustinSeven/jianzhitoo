//
//  ZGLoginController.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGLoginController.h"
#import "ZGLoginViewIphone.h"
#import "ZGRegisterController.h"
#import "ZGUserParam.h"
#import "ZGLoginProcess.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGUserInfoController.h"

@interface ZGLoginController()<UITextFieldDelegate>
{
    ZGLoginViewBase *_baseView;
    ZGRegisterController *registerController;
}

@end

@implementation ZGLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.title = @"登陆";
        
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        _baseView = [[ZGLoginViewIphone alloc]init];
        
        
        self.view = _baseView;
        
        _baseView.photoNumText.delegate = self;
        _baseView.passwordText.delegate = self;
        
        [_baseView.loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        registerController = [[ZGRegisterController alloc]init];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    switch (self.loginReturnType) {
        case LoginReturnType_LeftMenu:
            self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(backBtnClicked:) spacing:-15];
            break;
        case LoginReturnType_Nav:
            self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(backBtnClicked:) spacing:-15];
            break;
        case LoginReturnType_Diss:
        default:
            self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"down_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"down_btn_icon_pressed"] text:@"" target:self action:@selector(backBtnClicked:) spacing:-15];
            break;
    }
}

#pragma mark - Login btn clicked
- (void)loginBtnClicked:(UIButton *)button
{
    ZGUserParam *loginParam = [[ZGUserParam alloc]init];
    loginParam.mobile = _baseView.photoNumText.text;
    loginParam.pwd = _baseView.passwordText.text;
    
    
    [[ZGLoginProcess shareInstance] loginWithParam:[loginParam getDictionary] parentView:nil progressText:@"登录中..." loginSuccess:^(AFHTTPRequestOperation *loginOperation, id loginResponseObject) {
        
//        if([[loginResponseObject objectForKey:@"code"]intValue] == 200)
//        {
//            NSArray *data = [loginResponseObject objectForKey:@"data"];
//            ZGUserEntity *userEntity = [[ZGUserEntity alloc]initWithAttributes:[data objectAtIndex:0]];
//            userEntity.password = loginParam.pwd;
//            [ZGUtility removeUserDefaults:USERDEFAULTS_USER_KEY];
//            [ZGUtility saveUserDefaults:userEntity key:USERDEFAULTS_USER_KEY];
//        }
        
    } loginFailure:^(AFHTTPRequestOperation *loginOperation, NSError *LoginError) {
        
        [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
        
    } getInfoSuccess:^(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject) {
        
        if([[getInfoResponseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [getInfoResponseObject objectForKey:@"data"];
            ZGUserInfoEntity *userEntity = [[ZGUserInfoEntity alloc]initWithAttributes:[data objectAtIndex:0]];
            [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
            [ZGUtility saveUserDefaults:userEntity key:USERDEFAULTS_USER_INFO_KEY];
            
            if(self.jobDetailController)
                self.jobDetailController.isDataChanged = YES;
            switch (self.loginReturnType) {
                case LoginReturnType_LeftMenu:
                case LoginReturnType_Nav:
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                case LoginReturnType_Diss:
                default:
                    [self.navigationController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                    break;
            }
        }
        else
        {
            [ZGUtility showAlertWithText:[getInfoResponseObject objectForKey:@"message"] parentView:nil];
        }
        
    } getInfoFailure:^(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError) {
        
        [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
        
    }];
}

#pragma mark - bac btn clicked
- (void)backBtnClicked:(UIButton *)button
{
    switch (self.loginReturnType) {
        case LoginReturnType_LeftMenu:
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            break;
        case LoginReturnType_Nav:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case LoginReturnType_Diss:
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
            
        default:
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - register btn clicked
- (void)registerBtnClicked:(UIButton *)button
{
//    [self.navigationController pushViewController:registerController animated:YES];
    registerController.userCenterController = self.userCenterController;
    registerController.jobDetailController = self.jobDetailController;
    [self presentViewController:registerController animated:YES completion:^{
    }];
}

#pragma mark - ZGRegisterDelegate
- (void)setValue:(NSString *)str
{
    _baseView.photoNumText.text = str;
    _baseView.passwordText.text = @"";
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = LoginForgetPasswordBackgroundNormal.CGColor;
    if(textField.tag == 101)
    {
        _baseView.photoNumTextIcon.image = [UIImage imageNamed:@"login_user_name_text_left_icon_pressed"];
    }
    else
    {
        _baseView.passwordTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_pressed"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderColor = LoginTextBorderColorNormal.CGColor;
    if(textField.tag == 101)
    {
        _baseView.photoNumTextIcon.image = [UIImage imageNamed:@"login_user_name_text_left_icon_normal"];
    }
    else
    {
        _baseView.passwordTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_normal"];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        [_baseView.photoNumText resignFirstResponder];
        [_baseView.passwordText resignFirstResponder];
    }
    return YES;
}
@end
