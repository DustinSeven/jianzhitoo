//
//  ZGCommonAlertViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGCommonAlertViewIphone.h"

@interface ZGCommonAlertViewIphone()
{
    CGSize wordsSize;
}

@end

@implementation ZGCommonAlertViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backView = [[ZGBaseView alloc]init];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.layer.cornerRadius = 5;
        [self addSubview:self.backView];
        
        self.noticeLab = [[UILabel alloc]init];
        self.noticeLab.backgroundColor = [UIColor clearColor];
        self.noticeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.noticeLab.textColor = APP_FONT_COLOR_NORMAL;
        self.noticeLab.lineBreakMode = NSLineBreakByWordWrapping;
        self.noticeLab.numberOfLines = 0;
        self.noticeLab.textAlignment = NSTextAlignmentCenter;
        [self.backView addSubview:self.noticeLab];
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.backgroundColor = [UIColor clearColor];
        [self.btn setBackgroundImage:[ZGUtility imageWithColor:CommonAlertTalkBtnColorNormal size:CGSizeMake(CommonAlertBtnWith, CommonAlertBtnHeight)] forState:UIControlStateNormal];
        [self.btn setBackgroundImage:[ZGUtility imageWithColor:CommonAlertTalkBtnColorPressed size:CGSizeMake(CommonAlertBtnWith, CommonAlertBtnHeight)] forState:UIControlStateHighlighted];
        self.btn.layer.cornerRadius = 3;
        self.btn.layer.masksToBounds = YES;
        [self.btn setTitle:@"确认" forState:UIControlStateNormal];
        [self.backView addSubview:self.btn];
        
        [self.btn addTarget:self action:@selector(alertDismiss:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (id)initWithView:(UIView *)view
{
    self = [self init];
    if(self)
    {
        self.fatherView = view;
    }
    return self;
}

- (void)setFatherView:(UIView *)fatherView
{
    self.frame = CGRectMake(0, 0, fatherView.frame.size.width, fatherView.frame.size.height);
}

- (void)setText:(NSString *)text
{
    self.noticeLab.text = text;
    wordsSize = [self.noticeLab sizeThatFits:CGSizeMake(175, 0)];
    if(wordsSize.height < 50)
        wordsSize = CGSizeMake(175, 50);
}

- (void)showAlertWithText:(NSString *)text
{
    self.text = text;
    self.hidden = NO;
    [ZGUtility view:self.backView appearAt:CGPointMake(SCREEN_WIDTH / 2, (SCREEN_HEIGHT - HeadViewHeight) / 2) withDalay:0.6 duration:0.2];
}

- (void)alertDismiss:(UIButton *)button
{
    self.hidden = YES;
}

- (void)layoutSubviews
{
    self.backView.frame = CGRectMake((SCREEN_WIDTH - CommonAlertBackWith) / 2, (SCREEN_HEIGHT - HeadViewHeight - CommonAlertBackHeight) / 2, CommonAlertBackWith, CommonAlertBackHeight + wordsSize.height - 50);
    self.noticeLab.frame = CGRectMake((CommonAlertBackWith - 175) / 2, 10, 175, wordsSize.height);
    self.btn.frame = CGRectMake((CommonAlertBackWith - CommonAlertBtnWith) / 2, CGRectGetMaxY(self.noticeLab.frame) + 10 , CommonAlertBtnWith, CommonAlertBtnHeight);
}


@end
