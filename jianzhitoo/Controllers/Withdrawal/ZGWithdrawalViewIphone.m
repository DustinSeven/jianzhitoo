//
//  ZGWithdrawalViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/11/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGWithdrawalViewIphone.h"

@implementation ZGWithdrawalViewIphone

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
    
    self.headView = [[ZGHeadView alloc]init];
    self.headView.headTitleText.text = @"提现";
    [self addSubview:self.headView];
    
    self.alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alipayBtn setImage:[UIImage imageNamed:@"withdrawal_alipay_btn_icon"] forState:UIControlStateNormal];
    self.alipayBtn.tag = 101;
    self.alipayBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.alipayBtn];
    
    self.bankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bankBtn setImage:[UIImage imageNamed:@"withdrawal_bank_btn_icon"] forState:UIControlStateNormal];
    self.bankBtn.tag = 102;
    self.bankBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bankBtn];
    
    self.alipayLab = [[UILabel alloc]init];
    self.alipayLab.text = @"提到支付宝账户";
    self.alipayLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.alipayLab.backgroundColor = [UIColor clearColor];
    self.alipayLab.textColor = APP_FONT_COLOR_NORMAL;
    self.alipayLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.alipayLab];
    
    self.bankLab = [[UILabel alloc]init];
    self.bankLab.text = @"提到银行卡";
    self.bankLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.bankLab.backgroundColor = [UIColor clearColor];
    self.bankLab.textColor = APP_FONT_COLOR_NORMAL;
    self.bankLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.bankLab];
    
    
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.alipayBtn.frame = CGRectMake(62.5, 30 + HeadViewHeight, 62, 66);
    
    self.alipayLab.frame = CGRectMake(self.alipayBtn.frame.origin.x + self.alipayBtn.frame.size.width / 2 - 120 / 2, self.alipayBtn.frame.origin.y + self.alipayBtn.frame.size.height + 5, 120, 20);
    
    self.bankBtn.frame = CGRectMake(SCREEN_WIDTH / 2 + SCREEN_WIDTH / 2 - self.alipayBtn.frame.origin.x - self.alipayBtn.frame.size.width ,self.alipayBtn.frame.origin.y, 62, 66);
    
    self.bankLab.frame = CGRectMake(self.bankBtn.frame.origin.x + self.bankBtn.frame.size.width / 2 - 100 / 2, self.bankBtn.frame.origin.y + self.bankBtn.frame.size.height + 5, 100, 20);
}

@end
