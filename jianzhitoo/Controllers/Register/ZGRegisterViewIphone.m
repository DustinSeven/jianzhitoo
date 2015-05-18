//
//  ZGRegisterViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/8/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegisterViewIphone.h"
#import "ZGUtility.h"

@interface ZGRegisterViewIphone()
{
    ZGBaseView *photoNumIconBack;
    ZGBaseView *passwordIconBack;
    ZGBaseView *passwordAgainIconBack;
}

@end

@implementation ZGRegisterViewIphone

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
    
    self.headView = [[ZGHeadView alloc]init];
    self.headView.headTitleText.text = @"注册";
    [self.headView.backButton setBackgroundImage:[UIImage imageNamed:@"down_btn_icon_normal"] forState:UIControlStateNormal];
    [self.headView.backButton setBackgroundImage:[UIImage imageNamed:@"down_btn_icon_pressed"] forState:UIControlStateHighlighted];
    [self addSubview:self.headView];
    
    self.photoNumText = [[UITextField alloc]init];
    self.photoNumText.backgroundColor = [UIColor clearColor];
    self.photoNumText.layer.cornerRadius = 3;
    self.photoNumText.layer.borderWidth = 1;
    self.photoNumText.layer.borderColor = RegisterTextBorderColorNormal.CGColor;
    self.photoNumText.placeholder = @"手机号";
    self.photoNumText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.photoNumText.leftViewMode = UITextFieldViewModeAlways;
    self.photoNumText.tag = 201;
    self.photoNumText.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.photoNumText];
    
    self.pwdText = [[UITextField alloc]init];
    self.pwdText.backgroundColor = [UIColor clearColor];
    self.pwdText.layer.cornerRadius = 3;
    self.pwdText.layer.borderWidth = 1;
    self.pwdText.layer.borderColor = RegisterTextBorderColorNormal.CGColor;
    self.pwdText.placeholder = @"输入密码";
    self.pwdText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.pwdText.leftViewMode = UITextFieldViewModeAlways;
    self.pwdText.tag = 203;
    self.pwdText.secureTextEntry = YES;
    self.pwdText.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.pwdText];
    
    self.pwdAgainText = [[UITextField alloc]init];
    self.pwdAgainText.backgroundColor = [UIColor clearColor];
    self.pwdAgainText.layer.cornerRadius = 3;
    self.pwdAgainText.layer.borderWidth = 1;
    self.pwdAgainText.layer.borderColor = RegisterTextBorderColorNormal.CGColor;
    self.pwdAgainText.placeholder = @"确认密码";
    self.pwdAgainText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.pwdAgainText.leftViewMode = UITextFieldViewModeAlways;
    self.pwdAgainText.tag = 204;
    self.pwdAgainText.secureTextEntry = YES;
    self.pwdAgainText.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.pwdAgainText];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.backgroundColor = [UIColor clearColor];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registerBtn.layer.cornerRadius = 3;
    self.registerBtn.layer.masksToBounds = YES;
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn setBackgroundImage:[ZGUtility imageWithColor:RegisterRegisterButtonBackgroundNormal size:CGSizeMake(RegisterTextWidth, RegisterTextHeight)] forState:UIControlStateNormal];
    [self.registerBtn setBackgroundImage:[ZGUtility imageWithColor:RegisterRegisterButtonBackgroundPressed size:CGSizeMake(RegisterTextWidth, RegisterTextHeight)] forState:UIControlStateHighlighted];
    [self addSubview:self.registerBtn];
    
    self.photoNumIcon = [[UIImageView alloc]init];
    self.photoNumIcon.image = [UIImage imageNamed:@"login_user_name_text_left_icon_normal"];
    photoNumIconBack = [[ZGBaseView alloc]init];
    photoNumIconBack.backgroundColor = [UIColor clearColor];
    [photoNumIconBack addSubview:self.photoNumIcon];
    [self.photoNumText setLeftView:photoNumIconBack];
    
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
    if(IS_IPHONE4)
        self.photoNumText.frame = CGRectMake((SCREEN_WIDTH - RegisterTextWidth) / 2, HeadViewHeight + 10, RegisterTextWidth, RegisterTextHeight);
    else
        self.photoNumText.frame = CGRectMake((SCREEN_WIDTH - RegisterTextWidth) / 2, HeadViewHeight + 40, RegisterTextWidth, RegisterTextHeight);
    
    self.pwdText.frame = CGRectMake((SCREEN_WIDTH - RegisterTextWidth) / 2, CGRectGetMaxY(self.photoNumText.frame) + 10, RegisterTextWidth, RegisterTextHeight);
    self.pwdAgainText.frame = CGRectMake((SCREEN_WIDTH - RegisterTextWidth) / 2, CGRectGetMaxY(self.pwdText.frame) + 10, RegisterTextWidth, RegisterTextHeight);
    self.registerBtn.frame = CGRectMake((SCREEN_WIDTH - RegisterTextWidth) / 2, CGRectGetMaxY(self.pwdAgainText.frame) + 10, RegisterTextWidth, RegisterTextHeight);
    
    photoNumIconBack.frame = CGRectMake(0, 0, 43.5, 21);
    self.photoNumIcon.frame = CGRectMake(14.5, 0, 14.5, 21);
    passwordIconBack.frame = CGRectMake(0, 0, 43.5, 21);
    self.pwdTextIcon.frame = CGRectMake(14, 0, 15.5, 21);
    passwordAgainIconBack.frame = CGRectMake(0, 0, 43.5, 21);
    self.pwdAgainTextIcon.frame = CGRectMake(14, 0, 15.5, 21);

}

@end
