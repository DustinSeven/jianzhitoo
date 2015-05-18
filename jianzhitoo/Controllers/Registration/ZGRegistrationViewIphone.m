//
//  ZGRegistrationViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/13/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegistrationViewIphone.h"

@interface ZGRegistrationViewIphone()
{
    ZGBaseView *titleBack;
    ZGBaseView *btnBack;
}

@end

@implementation ZGRegistrationViewIphone

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
    
    self.baseGridView = [[GMGridView alloc]init];
    self.baseGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.baseGridView.backgroundColor = [UIColor clearColor];
    self.baseGridView.style = GMGridViewStyleSwap;
    self.baseGridView.minEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    self.baseGridView.centerGrid = NO;
    self.baseGridView.showsVerticalScrollIndicator = NO;
    self.baseGridView.itemSpacing = (SCREEN_WIDTH - RegistrationCellWithHeight * 4) / 5;
    self.baseGridView.minimumPressDuration = 9999;
    
    self.titleIcon = [[UIImageView alloc]init];
    self.titleIcon.image = [UIImage imageNamed:@"registration_title_icon"];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"选择工作日期";
    self.titleLab.font = [UIFont systemFontOfSize:18];
    self.titleLab.backgroundColor = [UIColor clearColor];
    self.titleLab.textColor = APP_FONT_COLOR_NORMAL;
    
    titleBack = [[ZGBaseView alloc]init];
    titleBack.backgroundColor = VIEW_BACKGROUND;
    
    self.noticeLab = [[UILabel alloc]init];
    self.noticeLab.text = @"日期不限的兼职一天只能报一次哦~";
    self.noticeLab.textColor = APP_FONT_COLOR_THIN;
    self.noticeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL - 2];
    self.noticeLab.textAlignment = NSTextAlignmentCenter;
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.layer.cornerRadius = 3;
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.backgroundColor = [UIColor clearColor];
    [self.submitBtn setBackgroundImage:[ZGUtility imageWithColor:RegistrationSubmitBtnBackgroundNormal size:CGSizeMake(RegistrationSubmitBtnWidth, RegistrationSubmitBtnHeight)] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[ZGUtility imageWithColor:RegistrationSubmitBtnBackgroundPressed size:CGSizeMake(RegistrationSubmitBtnWidth, RegistrationSubmitBtnHeight)] forState:UIControlStateHighlighted];
    [self.submitBtn setTitle:@"确认报名" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    
    btnBack = [[ZGBaseView alloc]init];
    btnBack.backgroundColor = VIEW_BACKGROUND;

    [self addSubview:self.baseGridView];
    [self addSubview:titleBack];
    [titleBack addSubview:self.titleIcon];
    [titleBack addSubview:self.titleLab];
    [self addSubview:btnBack];
    [btnBack addSubview:self.submitBtn];
    [btnBack addSubview:self.noticeLab];
    
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.titleIcon.frame = CGRectMake(30, 15, 25, 25);
    
    self.titleLab.frame = CGRectMake(self.titleIcon.frame.origin.x + self.titleIcon.frame.size.width + 15, self.titleIcon.frame.origin.y, 150, self.titleIcon.frame.size.height);
    
    titleBack.frame = CGRectMake(0, HeadViewHeight, SCREEN_HEIGHT, 50);
    
    self.baseGridView.frame = CGRectMake(0, titleBack.frame.origin.y + titleBack.frame.size.height + 10 , SCREEN_WIDTH, SCREEN_HEIGHT - (titleBack.frame.origin.y + titleBack.frame.size.height) - 75);
    
    btnBack.frame = CGRectMake(0, SCREEN_HEIGHT - 75, SCREEN_WIDTH, 75);
    
    self.submitBtn.frame = CGRectMake((SCREEN_WIDTH - RegistrationSubmitBtnWidth) / 2, 20, RegistrationSubmitBtnWidth, RegistrationSubmitBtnHeight);
    self.noticeLab.frame = CGRectMake(0, 0, SCREEN_WIDTH, 15);
}

@end
