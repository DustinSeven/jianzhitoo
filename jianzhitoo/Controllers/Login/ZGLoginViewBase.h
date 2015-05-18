//
//  ZGLoginViewBase.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGCommonAlertViewIphone.h"

#define LoginTextWidth 242
#define LoginTextHeight 40

#define LoginLoginButtonBackgroundNormal [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]
#define LoginLoginButtonBackgroundPressed [UIColor colorWithRed:219.0f / 255.0f green:139.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f]

#define LoginForgetPasswordBackgroundNormal [UIColor colorWithRed:54.0f / 255.0f green:200.0f / 255.0f blue:168.0f / 255.0f alpha:1.0f]
#define LoginForgetPasswordBackgroundPressed [UIColor colorWithRed:31.0f / 255.0f green:179.0f / 255.0f blue:147.0f / 255.0f alpha:1.0f]

#define LoginTextBorderColorNormal [UIColor colorWithRed:161.0f / 255.0f green:168.0f / 255.0f blue:176.0f / 255.0f alpha:1.0f]



@interface ZGLoginViewBase : ZGBaseView

@property (nonatomic , strong) UIImageView *photoNumTextIcon;
@property (nonatomic , strong) UIImageView *passwordTextIcon;
@property (nonatomic , strong) UITextField *photoNumText;
@property (nonatomic , strong) UITextField *passwordText;
@property (nonatomic , strong) UIButton *loginBtn;
@property (nonatomic , strong) UIButton *forgetPasswordBtn;
@property (nonatomic , strong) UIButton *registerBtn;



@end
