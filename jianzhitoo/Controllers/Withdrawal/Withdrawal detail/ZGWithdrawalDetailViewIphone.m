//
//  ZGWithdrawalDetailViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/11/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGWithdrawalDetailViewIphone.h"

@interface ZGWithdrawalDetailViewIphone()
{
    ZGBaseView *line;
}

@end
@implementation ZGWithdrawalDetailViewIphone

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
    self.backgroundColor = WithdrawalDetailBackground;
    
    self.headView = [[ZGHeadView alloc]init];
    self.headView.headTitleText.text = @"提到支付宝";
    [self addSubview:self.headView];
    
    self.balanceLab = [[UILabel alloc]init];
    self.balanceLab.backgroundColor = [UIColor clearColor];
    self.balanceLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.balanceLab.textColor = APP_FONT_COLOR_NORMAL;
    [self addSubview:self.balanceLab];
    
    self.baseTableView = [[UITableView alloc]init];
    self.baseTableView.backgroundColor = [UIColor clearColor];
    [self.baseTableView setSeparatorInset:UIEdgeInsetsZero];
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.bounces = NO;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.baseTableView];
    
    line = [[ZGBaseView alloc]init];
    line.backgroundColor = WithdrawalLineColor;
    [self addSubview:line];
    
    self.noticeLab = [[UILabel alloc]init];
    self.noticeLab.backgroundColor = [UIColor clearColor];
    self.noticeLab.lineBreakMode = NSLineBreakByWordWrapping;
    self.noticeLab.numberOfLines = 0;
    self.noticeLab.font = [UIFont systemFontOfSize:13];
    self.noticeLab.textColor = WithdrawalDetailNoticeColor;
    self.noticeLab.text = @"友情提示：提现一般在24小时内到账，请注意查看账户余额，如果有任何疑问请联系客服！";
    [self addSubview:self.noticeLab];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.backgroundColor = [UIColor clearColor];
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.submitBtn.layer.cornerRadius = 3;
    self.submitBtn.layer.masksToBounds = YES;
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[ZGUtility imageWithColor:WithdrawalDetailSubmitBtnBackgroundNormal size:CGSizeMake(WithdrawalDetailSubmitBtnWidth, WithdrawalDetailSubmitBtnHeight)] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[ZGUtility imageWithColor:WithdrawalDetailSubmitBtnBackgroundPressed size:CGSizeMake(WithdrawalDetailSubmitBtnWidth, WithdrawalDetailSubmitBtnHeight)] forState:UIControlStateHighlighted];
    [self addSubview:self.submitBtn];
    
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.balanceLab.frame = CGRectMake(17.5, HeadViewHeight, 287.5, 42.5);
    
    if(self.viewType == WithdrawalDetailViewType_Alipay)
        self.baseTableView.frame = CGRectMake(0, self.balanceLab.frame.origin.y + self.balanceLab.frame.size.height, SCREEN_WIDTH, 3 * WithdrawalDetailCellHeight);
    if(self.viewType == WithdrawalDetailViewType_Bank)
        self.baseTableView.frame = CGRectMake(0, self.balanceLab.frame.origin.y + self.balanceLab.frame.size.height, SCREEN_WIDTH, 5 * WithdrawalDetailCellHeight);
    
    
    line.frame = CGRectMake(0, self.balanceLab.frame.origin.y + self.balanceLab.frame.size.height , SCREEN_WIDTH, 0.5);
    
    self.noticeLab.frame = CGRectMake(20,self.baseTableView.frame.origin.y + self.baseTableView.frame.size.height + 5, SCREEN_WIDTH - 40, 32);
    
    self.submitBtn.frame = CGRectMake((SCREEN_WIDTH - 242.5) / 2, self.noticeLab.frame.origin.y + self.noticeLab.frame.size.height + 22.5, WithdrawalDetailSubmitBtnWidth, WithdrawalDetailSubmitBtnHeight);
}

@end
