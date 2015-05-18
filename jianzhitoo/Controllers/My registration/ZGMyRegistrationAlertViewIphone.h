//
//  ZGMyRegistrationAlertViewIphone.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAlertViewBase.h"

#define MyRegistrationAlertBackWith 225
#define MyRegistrationAlertBackHeight 180

#define MyRegistrationAlertBtnWith 156
#define MyRegistrationAlertBtnHeight 40

#define MyRegistrationAlertTalkBtnColorNormal [UIColor colorWithRed:54.0f / 255.0f green:200.0f / 255.0f blue:168.0f / 255.0f alpha:1.0f]
#define MyRegistrationAlertTalkBtnColorPressed [UIColor colorWithRed:31.0f / 255.0f green:179.0f / 255.0f blue:147.0f / 255.0f alpha:1.0f]

#define MyRegistrationAlertNoTalkBtnColorNormal [UIColor colorWithRed:192.0f / 255.0f green:192.0f / 255.0f blue:192.0f / 255.0f alpha:1.0f]
#define MyRegistrationAlertNoTalkBtnColorPressed [UIColor colorWithRed:156.0f / 255.0f green:156.0f / 255.0f blue:156.0f / 255.0f alpha:1.0f]

@interface ZGMyRegistrationAlertViewIphone : ZGAlertViewBase

@property (nonatomic , strong)ZGBaseView *backView;
@property (nonatomic , strong)UILabel *noticeLab;
@property (nonatomic , strong)UIButton *talkBtn;
@property (nonatomic , strong)UIButton *noTalkBtn;

@end
