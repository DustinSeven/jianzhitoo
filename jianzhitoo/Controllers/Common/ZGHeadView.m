//
//  ZGHeadView.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/6/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGHeadView.h"

@implementation ZGHeadView

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
    self.backgroundColor = HeadViewBackground;
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.backgroundColor = [UIColor clearColor];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"back_btn_icon_normal"] forState:UIControlStateNormal];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"back_btn_icon_pressed"] forState:UIControlStateHighlighted];
    [self addSubview:self.backButton];
    
    self.headTitleText = [[UILabel alloc]init];
    self.headTitleText.textAlignment = NSTextAlignmentCenter;
    self.headTitleText.textColor = [UIColor whiteColor];
    self.headTitleText.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.headTitleText];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn.backgroundColor = [UIColor clearColor];
    self.rightBtnIcon = [[UIImageView alloc]init];
    [self.rightBtn addSubview:self.rightBtnIcon];
    [self addSubview:self.rightBtn];
    self.rightBtn.hidden = YES;
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, HeadViewHeight);
    
    self.backButton.frame = CGRectMake(0, 20, 50, HeadViewHeight - 20);
    
//    self.rightBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 20, 50, HeadViewHeight - 20);
//    self.rightBtnIcon.frame = CGRectMake(10, 13, 13.5, 22);
    
    self.headTitleText.frame = CGRectMake((SCREEN_WIDTH - HeadTitleWidth) / 2, 30, HeadTitleWidth, 30);
}
@end
