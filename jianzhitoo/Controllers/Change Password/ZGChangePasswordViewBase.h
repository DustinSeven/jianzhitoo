//
//  ZGChangePasswordViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#define ChangePwdTextBorderColorNormal [UIColor colorWithRed:161.0f / 255.0f green:168.0f / 255.0f blue:176.0f / 255.0f alpha:1.0f]
#define ChangePwdTextBorderColorClicked [UIColor colorWithRed:54.0f / 255.0f green:200.0f / 255.0f blue:168.0f / 255.0f alpha:1.0f]

#define ChangePwdBtnBackgroundNormal [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]
#define ChangePwdBtnBackgroundPressed [UIColor colorWithRed:219.0f / 255.0f green:139.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f]

#define ChangePwdTextWidth 242
#define ChangePwdTextHeight 40

@interface ZGChangePasswordViewBase : ZGBaseView

@property (nonatomic , strong) UITextField *oldPwdText;
@property (nonatomic , strong) UIImageView *oldPwdTextIcon;
@property (nonatomic , strong) UITextField *pwdText;
@property (nonatomic , strong) UIImageView *pwdTextIcon;
@property (nonatomic , strong) UITextField *pwdAgainText;
@property (nonatomic , strong) UIImageView *pwdAgainTextIcon;
@property (nonatomic , strong) UIButton *changeBtn;


@end
