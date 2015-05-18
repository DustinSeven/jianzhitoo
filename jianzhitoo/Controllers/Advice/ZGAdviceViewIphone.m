//
//  ZGAdviceViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAdviceViewIphone.h"

@implementation ZGAdviceViewIphone

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
    
    self.placeHolder = @"您的支持是我们最大的动力，给兔兔一点意见吧~ 我们会不定期地送出小礼品哦~";
    
    self.headView = [[ZGHeadView alloc]init];
    self.headView.headTitleText.text = @"意见反馈";
    [self addSubview:self.headView];
    
    self.adviceText = [[UITextView alloc]init];
    self.adviceText.backgroundColor = [UIColor clearColor];
    self.adviceText.layer.borderWidth = 1;
    self.adviceText.layer.borderColor = AdviceTextBorderColorNormal.CGColor;
    self.adviceText.layer.cornerRadius = 5;
//    self.adviceText.font = [UIFont fontWithName:APP_FONT_NORMAL size:APP_FONT_SIZE_NORMAL];
    self.adviceText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    [self addSubview:self.adviceText];
    
    self.adviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.adviceBtn setTitle:@"吐槽一下" forState:UIControlStateNormal];
    [self.adviceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    self.logoutBtn.titleLabel.font = [UIFont fontWithName:APP_FONT_NORMAL size:APP_FONT_SIZE_NORMAL];
    self.adviceBtn.layer.cornerRadius = 3;
    self.adviceBtn.layer.masksToBounds = YES;
    self.adviceBtn.backgroundColor = [UIColor clearColor];
    [self.adviceBtn setBackgroundImage:[ZGUtility imageWithColor:AdviceBtnBackgroundNormal size:CGSizeMake(AdviceBtnWidth, AdviceBtnHeight)] forState:UIControlStateNormal];
    [self.adviceBtn setBackgroundImage:[ZGUtility imageWithColor:AdviceBtnBackgroundPressed size:CGSizeMake(AdviceBtnWidth, AdviceBtnHeight)] forState:UIControlStateHighlighted];
    [self addSubview:self.adviceBtn];
    
    self.adviceTextPlaceHolderLab = [[UILabel alloc]init];
    self.adviceTextPlaceHolderLab.backgroundColor = [UIColor clearColor];
    self.adviceTextPlaceHolderLab.lineBreakMode = NSLineBreakByWordWrapping;
    self.adviceTextPlaceHolderLab.numberOfLines = 0;
    self.adviceTextPlaceHolderLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.adviceTextPlaceHolderLab.textColor = AdviceTextPlaceHolderColor;
    self.adviceTextPlaceHolderLab.enabled = NO;
    self.adviceTextPlaceHolderLab.text = self.placeHolder;
    [self.adviceText addSubview:self.adviceTextPlaceHolderLab];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.adviceText.frame = CGRectMake((SCREEN_WIDTH - AdviceTextWidth) / 2, HeadViewHeight + 20, AdviceTextWidth, AdviceTextHeight);
    
    self.adviceBtn.frame = CGRectMake((SCREEN_WIDTH - AdviceBtnWidth) / 2, CGRectGetMaxY(self.adviceText.frame) + 20, AdviceBtnWidth, AdviceBtnHeight);
    
    self.adviceTextPlaceHolderLab.frame = CGRectMake(5, 0, AdviceTextWidth - 10, 40);
}

@end
