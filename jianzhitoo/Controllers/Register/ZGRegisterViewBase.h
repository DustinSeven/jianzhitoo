//
//  ZGRegisterViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/8/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseView.h"
#import "ZGHeadView.h"
#import "ZGCommonAlertViewIphone.h"

#define RegisterTextBorderColorNormal [UIColor colorWithRed:161.0f / 255.0f green:168.0f / 255.0f blue:176.0f / 255.0f alpha:1.0f]
#define RegisterTextBorderColorClicked [UIColor colorWithRed:54.0f / 255.0f green:200.0f / 255.0f blue:168.0f / 255.0f alpha:1.0f]

#define RegisterRegisterButtonBackgroundNormal [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]
#define RegisterRegisterButtonBackgroundPressed [UIColor colorWithRed:219.0f / 255.0f green:139.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f]

#define RegisterVeriButtonBackgroundNormal [UIColor colorWithRed:54.0f / 255.0f green:200.0f / 255.0f blue:168.0f / 255.0f alpha:1.0f]
#define RegisterVeriButtonBackgroundPressed [UIColor colorWithRed:31.0f / 255.0f green:179.0f / 255.0f blue:147.0f / 255.0f alpha:1.0f]

#define RegisterTextWidth 242
#define RegisterTextHeight 40

#define RegisterGetVeriCodeTextWidth 140

@interface ZGRegisterViewBase : ZGBaseView

@property (nonatomic , strong) ZGHeadView *headView;
@property (nonatomic , strong) UITextField *photoNumText;
@property (nonatomic , strong) UIImageView *photoNumIcon;
@property (nonatomic , strong) UITextField *pwdText;
@property (nonatomic , strong) UIImageView *pwdTextIcon;
@property (nonatomic , strong) UITextField *pwdAgainText;
@property (nonatomic , strong) UIImageView *pwdAgainTextIcon;
@property (nonatomic , strong) UIButton *registerBtn;

@end
