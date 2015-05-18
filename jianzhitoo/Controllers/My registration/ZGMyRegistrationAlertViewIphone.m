//
//  ZGMyRegistrationAlertViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMyRegistrationAlertViewIphone.h"

@implementation ZGMyRegistrationAlertViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        self.isBackViewEntable = YES;
        
        self.backView = [[ZGBaseView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - MyRegistrationAlertBackWith) / 2, (SCREEN_HEIGHT - HeadViewHeight - MyRegistrationAlertBackHeight) / 2, MyRegistrationAlertBackWith, MyRegistrationAlertBackHeight)];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.layer.cornerRadius = 5;
        [self addSubview:self.backView];
        
        self.noticeLab = [[UILabel alloc]initWithFrame:CGRectMake((MyRegistrationAlertBackWith - 175) / 2, 10, 175, 50)];
        self.noticeLab.backgroundColor = [UIColor clearColor];
        self.noticeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.noticeLab.textColor = APP_FONT_COLOR_NORMAL;
        self.noticeLab.lineBreakMode = NSLineBreakByWordWrapping;
        self.noticeLab.numberOfLines = 0;
        [self.backView addSubview:self.noticeLab];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"亲，为什么不想去了呀？和兔兔说一下吧~"];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str.string length])];
        self.noticeLab.attributedText = str;
        
        self.talkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.talkBtn.frame = CGRectMake((MyRegistrationAlertBackWith - MyRegistrationAlertBtnWith) / 2, CGRectGetMaxY(self.noticeLab.frame) + 10 , MyRegistrationAlertBtnWith, MyRegistrationAlertBtnHeight);
        self.talkBtn.backgroundColor = [UIColor clearColor];
        [self.talkBtn setBackgroundImage:[ZGUtility imageWithColor:MyRegistrationAlertTalkBtnColorNormal size:CGSizeMake(MyRegistrationAlertBtnWith, MyRegistrationAlertBtnHeight)] forState:UIControlStateNormal];
        [self.talkBtn setBackgroundImage:[ZGUtility imageWithColor:MyRegistrationAlertTalkBtnColorPressed size:CGSizeMake(MyRegistrationAlertBtnWith, MyRegistrationAlertBtnHeight)] forState:UIControlStateHighlighted];
        self.talkBtn.layer.cornerRadius = 3;
        self.talkBtn.layer.masksToBounds = YES;
        [self.talkBtn setTitle:@"说一下吧" forState:UIControlStateNormal];
        [self.backView addSubview:self.talkBtn];
        
        self.noTalkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.noTalkBtn.frame = CGRectMake((MyRegistrationAlertBackWith - MyRegistrationAlertBtnWith) / 2, CGRectGetMaxY(self.talkBtn.frame) + 10 , MyRegistrationAlertBtnWith, MyRegistrationAlertBtnHeight);
        self.noTalkBtn.backgroundColor = [UIColor clearColor];
        [self.noTalkBtn setBackgroundImage:[ZGUtility imageWithColor:MyRegistrationAlertNoTalkBtnColorNormal size:CGSizeMake(MyRegistrationAlertBtnWith, MyRegistrationAlertBtnHeight)] forState:UIControlStateNormal];
        [self.noTalkBtn setBackgroundImage:[ZGUtility imageWithColor:MyRegistrationAlertNoTalkBtnColorPressed size:CGSizeMake(MyRegistrationAlertBtnWith, MyRegistrationAlertBtnHeight)] forState:UIControlStateHighlighted];
        self.noTalkBtn.layer.cornerRadius = 3;
        self.noTalkBtn.layer.masksToBounds = YES;
        [self.noTalkBtn setTitle:@"残忍地放鸽子了" forState:UIControlStateNormal];
        [self.backView addSubview:self.noTalkBtn];
        
        
    }
    return self;
}

@end
