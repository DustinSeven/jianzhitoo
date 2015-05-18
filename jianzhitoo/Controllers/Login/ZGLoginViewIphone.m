//
//  ZGLoginViewIphone.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGLoginViewIphone.h"


@interface ZGLoginViewIphone()
{
    UILabel *forgetLab;
    UIImageView *backIcon;
    
    ZGBaseView *usernameIconBack;
    ZGBaseView *passwordIconBack;
}

@end

@implementation ZGLoginViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        [self initWitgets];
    }
    return self;
}

- (void)initWitgets
{
    self.backgroundColor = VIEW_BACKGROUND;
    
    self.photoNumText = [[UITextField alloc]init];
    self.photoNumText.backgroundColor = [UIColor clearColor];
    self.photoNumText.layer.cornerRadius = 3;
    self.photoNumText.layer.borderWidth = 1;
    self.photoNumText.layer.borderColor = LoginTextBorderColorNormal.CGColor;
    self.photoNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.photoNumText.placeholder = @"手机号";
    self.photoNumText.tag = 101;
    self.photoNumText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.photoNumText.leftViewMode = UITextFieldViewModeAlways;
    self.photoNumText.returnKeyType = UIReturnKeyDone;
    [self addSubview: self.photoNumText];
    
    self.photoNumTextIcon = [[UIImageView alloc]init];
    self.photoNumTextIcon.image = [UIImage imageNamed:@"login_user_name_text_left_icon_normal"];
    usernameIconBack = [[ZGBaseView alloc]init];
    usernameIconBack.backgroundColor = [UIColor clearColor];
    [usernameIconBack addSubview:self.photoNumTextIcon];
    [self.photoNumText setLeftView:usernameIconBack];
    
    self.passwordText = [[UITextField alloc]init];
    self.passwordText.backgroundColor = [UIColor clearColor];
    self.passwordText.layer.cornerRadius = 3;
    self.passwordText.layer.borderWidth = 1;
    self.passwordText.layer.borderColor = LoginTextBorderColorNormal.CGColor;
    self.passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordText.placeholder = @"密码";
    self.passwordText.secureTextEntry = YES;
    self.passwordText.tag = 102;
    self.passwordText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.passwordText.leftViewMode = UITextFieldViewModeAlways;
    self.passwordText.returnKeyType = UIReturnKeyDone;
    [self addSubview: self.passwordText];
    
    self.passwordTextIcon = [[UIImageView alloc]init];
    self.passwordTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_normal"];
    passwordIconBack = [[ZGBaseView alloc]init];
    passwordIconBack.backgroundColor = [UIColor clearColor];
    [passwordIconBack addSubview:self.passwordTextIcon];
    [self.passwordText setLeftView:passwordIconBack];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.backgroundColor = [UIColor clearColor];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 3;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn setBackgroundImage:[ZGUtility imageWithColor:LoginLoginButtonBackgroundNormal size:CGSizeMake(LoginTextWidth, LoginTextHeight)] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[ZGUtility imageWithColor:LoginLoginButtonBackgroundPressed size:CGSizeMake(LoginTextWidth, LoginTextHeight)] forState:UIControlStateHighlighted];
    [self addSubview:self.loginBtn];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.backgroundColor = [UIColor clearColor];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.registerBtn.layer.cornerRadius = 3;
    self.registerBtn.layer.masksToBounds = YES;
    [self.registerBtn setBackgroundImage:[ZGUtility imageWithColor:LoginForgetPasswordBackgroundNormal size:CGSizeMake(LoginTextWidth, LoginTextHeight)] forState:UIControlStateNormal];
    [self.registerBtn setBackgroundImage:[ZGUtility imageWithColor:LoginForgetPasswordBackgroundPressed size:CGSizeMake(LoginTextWidth, LoginTextHeight)] forState:UIControlStateHighlighted];
    [self addSubview:self.registerBtn];
    
    self.forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.forgetPasswordBtn.backgroundColor = [UIColor clearColor];
    self.forgetPasswordBtn.hidden = YES;
    [self addSubview:self.forgetPasswordBtn];
    forgetLab = [[UILabel alloc]init];
    forgetLab.textAlignment = NSTextAlignmentRight;
    forgetLab.textColor = LoginForgetPasswordBackgroundNormal;
    forgetLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    forgetLab.text = @"忘记密码";
    [self.forgetPasswordBtn addSubview:forgetLab];
    
    self.photoNumText.text = @"18888888888";
    self.passwordText.text = @"1";
}

- (void)layoutSubviews
{
    self.photoNumText.frame = CGRectMake((SCREEN_WIDTH - LoginTextWidth) / 2, HeadViewHeight + 40, LoginTextWidth, LoginTextHeight);
    self.passwordText.frame = CGRectMake((SCREEN_WIDTH - LoginTextWidth) / 2, CGRectGetMaxY(self.photoNumText.frame) + 20, LoginTextWidth, LoginTextHeight);
    
    usernameIconBack.frame = CGRectMake(0, 0, 43.5, 21);
    self.photoNumTextIcon.frame = CGRectMake(14.5, 0, 14.5, 21);
    passwordIconBack.frame = CGRectMake(0, 0, 43.5, 21);
    self.passwordTextIcon.frame = CGRectMake(14, 0, 15.5, 21);
    
    self.loginBtn.frame = CGRectMake((SCREEN_WIDTH - LoginTextWidth) / 2, CGRectGetMaxY(self.passwordText.frame) + 20, LoginTextWidth, LoginTextHeight);
    self.registerBtn.frame = CGRectMake((SCREEN_WIDTH - LoginTextWidth) / 2, CGRectGetMaxY(self.loginBtn.frame) + 20, LoginTextWidth, LoginTextHeight);
    self.forgetPasswordBtn.frame = CGRectMake((SCREEN_WIDTH - LoginTextWidth) / 2, CGRectGetMaxY(self.registerBtn.frame) + 5, LoginTextWidth, LoginTextHeight);
    forgetLab.frame = CGRectMake(0, 10, LoginTextWidth, 20);
}
@end
