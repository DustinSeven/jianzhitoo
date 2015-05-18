//
//  ZGChangePasswordViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGChangePasswordViewIphone.h"

@interface ZGChangePasswordViewIphone()
{
    ZGBaseView*oldPasswordIconBack;
    ZGBaseView *passwordIconBack;
    ZGBaseView *passwordAgainIconBack;
}

@end

@implementation ZGChangePasswordViewIphone

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
    
    self.oldPwdText = [[UITextField alloc]init];
    self.oldPwdText.backgroundColor = [UIColor clearColor];
    self.oldPwdText.layer.cornerRadius = 3;
    self.oldPwdText.layer.borderWidth = 1;
    self.oldPwdText.layer.borderColor = ChangePwdTextBorderColorNormal.CGColor;
    self.oldPwdText.placeholder = @"原密码";
    self.oldPwdText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];//[UIFont fontWithName:APP_FONT_NORMAL size:APP_FONT_SIZE_NORMAL];
    self.oldPwdText.leftViewMode = UITextFieldViewModeAlways;
    self.oldPwdText.tag = 101;
    self.oldPwdText.secureTextEntry = YES;
    [self addSubview:self.oldPwdText];
    
    self.pwdText = [[UITextField alloc]init];
    self.pwdText.backgroundColor = [UIColor clearColor];
    self.pwdText.layer.cornerRadius = 3;
    self.pwdText.layer.borderWidth = 1;
    self.pwdText.layer.borderColor = ChangePwdTextBorderColorNormal.CGColor;
    self.pwdText.placeholder = @"新密码";
    self.pwdText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.pwdText.leftViewMode = UITextFieldViewModeAlways;
    self.pwdText.tag = 102;
    self.pwdText.secureTextEntry = YES;
    [self addSubview:self.pwdText];
    
    self.pwdAgainText = [[UITextField alloc]init];
    self.pwdAgainText.backgroundColor = [UIColor clearColor];
    self.pwdAgainText.layer.cornerRadius = 3;
    self.pwdAgainText.layer.borderWidth = 1;
    self.pwdAgainText.layer.borderColor = ChangePwdTextBorderColorNormal.CGColor;
    self.pwdAgainText.placeholder = @"确认密码";
    self.pwdAgainText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.pwdAgainText.leftViewMode = UITextFieldViewModeAlways;
    self.pwdAgainText.tag = 103;
    self.pwdAgainText.secureTextEntry = YES;
    [self addSubview:self.pwdAgainText];
    
    self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeBtn.backgroundColor = [UIColor clearColor];
    [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
    self.changeBtn.layer.cornerRadius = 3;
    self.changeBtn.layer.masksToBounds = YES;
    [self.changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.changeBtn setBackgroundImage:[ZGUtility imageWithColor:ChangePwdBtnBackgroundNormal size:CGSizeMake(ChangePwdTextWidth, ChangePwdTextHeight)] forState:UIControlStateNormal];
    [self.changeBtn setBackgroundImage:[ZGUtility imageWithColor:ChangePwdBtnBackgroundPressed size:CGSizeMake(ChangePwdTextWidth, ChangePwdTextHeight)] forState:UIControlStateHighlighted];
    [self addSubview:self.changeBtn];

    self.oldPwdTextIcon = [[UIImageView alloc]init];
    self.oldPwdTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_normal"];
    oldPasswordIconBack = [[ZGBaseView alloc]init];
    oldPasswordIconBack.backgroundColor = [UIColor clearColor];
    [oldPasswordIconBack addSubview:self.oldPwdTextIcon];
    [self.oldPwdText setLeftView:oldPasswordIconBack];
    
    self.pwdTextIcon = [[UIImageView alloc]init];
    self.pwdTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_normal"];
    passwordIconBack = [[ZGBaseView alloc]init];
    passwordIconBack.backgroundColor = [UIColor clearColor];
    [passwordIconBack addSubview:self.pwdTextIcon];
    [self.pwdText setLeftView:passwordIconBack];
    
    self.pwdAgainTextIcon = [[UIImageView alloc]init];
    self.pwdAgainTextIcon.image = [UIImage imageNamed:@"login_user_pwd_text_left_icon_normal"];
    passwordAgainIconBack = [[ZGBaseView alloc]init];
    passwordAgainIconBack.backgroundColor = [UIColor clearColor];
    [passwordAgainIconBack addSubview:self.pwdAgainTextIcon];
    [self.pwdAgainText setLeftView:passwordAgainIconBack];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.oldPwdText.frame = CGRectMake((SCREEN_WIDTH - ChangePwdTextWidth) / 2, HeadViewHeight + 40, ChangePwdTextWidth, ChangePwdTextHeight);
    self.pwdText.frame = CGRectMake((SCREEN_WIDTH - ChangePwdTextWidth) / 2, CGRectGetMaxY(self.oldPwdText.frame) + 10, ChangePwdTextWidth, ChangePwdTextHeight);
    self.pwdAgainText.frame = CGRectMake((SCREEN_WIDTH - ChangePwdTextWidth) / 2, CGRectGetMaxY(self.pwdText.frame) + 10, ChangePwdTextWidth, ChangePwdTextHeight);
    self.changeBtn.frame = CGRectMake((SCREEN_WIDTH - ChangePwdTextWidth) / 2, CGRectGetMaxY(self.pwdAgainText.frame) + 10, ChangePwdTextWidth, ChangePwdTextHeight);
    
    oldPasswordIconBack.frame = CGRectMake(0, 0, 43.5, 21);
    self.oldPwdTextIcon.frame = CGRectMake(14.5, 0, 14.5, 21);
    passwordIconBack.frame = CGRectMake(0, 0, 43.5, 21);
    self.pwdTextIcon.frame = CGRectMake(14, 0, 15.5, 21);
    passwordAgainIconBack.frame = CGRectMake(0, 0, 43.5, 21);
    self.pwdAgainTextIcon.frame = CGRectMake(14, 0, 15.5, 21);
}

@end
