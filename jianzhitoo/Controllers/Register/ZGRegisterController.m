//
//  ZGRegisterControllerViewController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/8/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegisterController.h"
#import "ZGUserParam.h"
#import "ZGLoginProcess.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGUserInfoController.h"

@interface ZGRegisterController ()<UITextFieldDelegate>
{
    ZGRegisterViewBase *_baseView;
    
    ZGRegisterParam *registerParam;
    
    NSTimer *timer;
    int timeTimeTotal;
}

@end

@implementation ZGRegisterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[ZGRegisterViewIphone alloc]init];
        self.view = _baseView;
        
        timeTimeTotal = 0;
        
        [_baseView.headView.backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _baseView.photoNumText.delegate = self;
        _baseView.pwdText.delegate = self;
        _baseView.pwdAgainText.delegate = self;
        
        [_baseView.registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        registerParam = [[ZGRegisterParam alloc]init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainViewTap:)];
        [_baseView addGestureRecognizer:tap];
    }
}

- (void)mainViewTap:(UITapGestureRecognizer *)tap
{
    [_baseView.photoNumText resignFirstResponder];
    [_baseView.pwdText resignFirstResponder];
    [_baseView.pwdAgainText resignFirstResponder];
}

- (BOOL)checkInfo
{
    NSString *mobile = [_baseView.photoNumText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd = [_baseView.pwdText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwdAgain = [_baseView.pwdAgainText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(![ZGUtility checkTel:mobile])
    {
        [ZGUtility showAlertWithText:@"请输入正确的手机号！" parentView:nil];
        
        return NO;
    }else if(![pwd isEqualToString:pwdAgain])
    {
        [ZGUtility showAlertWithText:@"两次输入密码不一致！" parentView:nil];
        return NO;
    }else if([pwd isEqualToString:@""])
    {
        [ZGUtility showAlertWithText:@"请输入密码！" parentView:nil];
        return NO;
    }
    else
    {
        registerParam.mobile = mobile;
        registerParam.pwd = pwd;
        return YES;
    }
    
}

#pragma mark - register btn clicked
- (void)registerBtnClicked:(UIButton *)button
{
    if([self checkInfo])
    {
         [[ZGRegisterProcess shareInstance]registerWithParam:[registerParam getDictionary] parentView:nil progressText:@"Registering..." success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            int code = [[responseObject objectForKey:@"code"]intValue];
            if(code == 200)
            {
                ZGCommonAlertViewIphone *alert = [ZGUtility showAlertWithText:@"注册成功,请及时设置真实个人信息（信息一旦被设置将无法修改）！" parentView:nil];
                alert.isBackViewEntable = NO;
                [alert.btn addTarget:self action:@selector(registerSuccess:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma  mark - register success
- (void)registerSuccess:(UIButton *)button
{
    
    ZGUserParam *loginParam = [[ZGUserParam alloc]init];
    loginParam.mobile = _baseView.photoNumText.text;
    loginParam.pwd = _baseView.pwdText.text;
    
    
    [[ZGLoginProcess shareInstance] loginWithParam:[loginParam getDictionary] parentView:nil progressText:@"登录中..." loginSuccess:^(AFHTTPRequestOperation *loginOperation, id loginResponseObject) {
        
        if([[loginResponseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [loginResponseObject objectForKey:@"data"];
            ZGUserInfoEntity *userInfoEntity = [[ZGUserInfoEntity alloc]initWithAttributes:[data objectAtIndex:0]];
            userInfoEntity.password = loginParam.pwd;
            [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
            [ZGUtility saveUserDefaults:userInfoEntity key:USERDEFAULTS_USER_INFO_KEY];
        }
        
    } loginFailure:^(AFHTTPRequestOperation *loginOperation, NSError *LoginError) {
        
        [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
        
    } getInfoSuccess:^(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject) {
        
        if([[getInfoResponseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [getInfoResponseObject objectForKey:@"data"];
            ZGUserInfoEntity *userEntity = [[ZGUserInfoEntity alloc]initWithAttributes:[data objectAtIndex:0]];
            [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
            [ZGUtility saveUserDefaults:userEntity key:USERDEFAULTS_USER_INFO_KEY];
            
            
            ZGUserInfoController *userInfoController = [[ZGUserInfoController alloc]init];
            [self dismissViewControllerAnimated:YES completion:^{
                
                if(self.userCenterController)
                {
                    [self.userCenterController.navigationController pushViewController:userInfoController animated:NO];
                    [self.userCenterController dismissViewControllerAnimated:NO completion:^{
                        
                    }];
                }
                
                if(self.jobDetailController)
                {
                    self.jobDetailController.isDataChanged = YES;
                    [self.jobDetailController.navigationController pushViewController:userInfoController animated:NO];
                    [self.jobDetailController dismissViewControllerAnimated:NO completion:^{
                        
                    }];
                }
            }];
        }
        else
        {
            [ZGUtility showAlertWithText:[getInfoResponseObject objectForKey:@"message"] parentView:nil];
        }
        
    } getInfoFailure:^(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError) {
        
        [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
        
    }];
}

#pragma mark - getVeriCodeBtn clicked
- (void)getVeriCodeBtnClicked:(UIButton *)button
{
    if(timeTimeTotal == 0)
    {
        NSString *mobile = _baseView.photoNumText.text;
        BOOL isRight = [ZGUtility checkTel:mobile];
        if(isRight)
        {
            ZGVeriCodeParam *veriCodeParam = [[ZGVeriCodeParam alloc]init];
            veriCodeParam.mobile = mobile;
            [[ZGRegisterProcess shareInstance]getVeriCodeWithParam:[veriCodeParam getDictionary] parentView:nil progressText:@"处理中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
                int code = [[responseObject objectForKey:@"code"]intValue];
                NSArray *dataArr = [responseObject objectForKey:@"data"];
                if(code == 200)
                {
                    [ZGUtility showAlertWithText:@"验证码获取成功，稍后会以短信的形式发送给您！" parentView:nil];
                    registerParam.veriCodeTime = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:0] objectForKey:@"regcodetime"] ];
                    timeTimeTotal = 30;
                    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
                }
                else
                {
                    [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error)
            {
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
            }];
        }
        else
        {
            [ZGUtility showAlertWithText:@"请输入正确的手机号！" parentView:nil];
        }
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = RegisterTextBorderColorClicked.CGColor;
    if(textField.tag == 201)
    {
        _baseView.photoNumIcon.image = [UIImage imageNamed:@"login_user_name_text_left_icon_pressed"];
    }
    if(textField.tag == 203)
    {
        _baseView.pwdTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_pressed"];
    }
    if(textField.tag == 204)
    {
        _baseView.pwdAgainTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_pressed"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderColor = RegisterTextBorderColorNormal.CGColor;
    if(textField.tag == 201)
    {
        _baseView.photoNumIcon.image = [UIImage imageNamed:@"login_user_name_text_left_icon_normal"];
    }
    if(textField.tag == 203)
    {
        _baseView.pwdTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_normal"];
    }
    if(textField.tag == 204)
    {
        _baseView.pwdAgainTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_normal"];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 203 || textField.tag ==204)
    {
        if(string.length > 0 && textField.text.length >= 16)
            return NO;
    }
    if ([string isEqualToString:@"\n"])
    {
        [_baseView.photoNumText resignFirstResponder];
        [_baseView.pwdAgainText resignFirstResponder];
        [_baseView.pwdText resignFirstResponder];
    }
    
    return YES;
}


#pragma mark - back button clicked
- (void)backBtnClick:(UIButton *)button
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
