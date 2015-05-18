//
//  ZGCommonAlertViewIphone.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAlertViewBase.h"

#define CommonAlertBackWith 225
#define CommonAlertBackHeight 130

#define CommonAlertBtnWith 156
#define CommonAlertBtnHeight 40

#define CommonAlertTalkBtnColorNormal [UIColor colorWithRed:54.0f / 255.0f green:200.0f / 255.0f blue:168.0f / 255.0f alpha:1.0f]
#define CommonAlertTalkBtnColorPressed [UIColor colorWithRed:31.0f / 255.0f green:179.0f / 255.0f blue:147.0f / 255.0f alpha:1.0f]

@interface ZGCommonAlertViewIphone : ZGAlertViewBase

@property (nonatomic , strong)ZGBaseView *backView;
@property (nonatomic , strong)UILabel *noticeLab;
@property (nonatomic , strong)UIButton *btn;
@property (nonatomic , strong)UIView *fatherView;
@property (nonatomic , strong)NSString *text;

- (void)showAlertWithText:(NSString *)text;
- (id)initWithView:(UIView *)view;

@end
