//
//  ZGJobManagerViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/4.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGJobManagerViewIphone.h"

@interface ZGJobManagerViewIphone()
{
    ZGBaseView *line1;
}

@end

@implementation ZGJobManagerViewIphone

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
    
    self.baseTableView = [[UITableView alloc]init];
    self.baseTableView.bounces = NO;
    self.baseTableView.backgroundColor = [UIColor clearColor];
    [self.baseTableView setSeparatorInset:UIEdgeInsetsZero];
    self.baseTableView.showsVerticalScrollIndicator = NO;
    [self.baseTableView setSeparatorColor:JobManagerListSeparatorColor];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.baseTableView];
    
    line1 = [[ZGBaseView alloc]init];
    line1.backgroundColor = JobManagerListSeparatorColor;
    [self addSubview:line1];
    
    self.signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.signInBtn setTitle:@"签到/签退" forState:UIControlStateNormal];
    [self.signInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.signInBtn.layer.cornerRadius = 3;
    self.signInBtn.layer.masksToBounds = YES;
    self.signInBtn.backgroundColor = [UIColor clearColor];
    [self.signInBtn setBackgroundImage:[ZGUtility imageWithColor:JobManagerSignInBtnBackgroundNormal size:CGSizeMake(JobManagerSignInBtnWidth, JobManagerSignInBtnHeight)] forState:UIControlStateNormal];
    [self.signInBtn setBackgroundImage:[ZGUtility imageWithColor:JobManagerSignInBtnBackgroundPressed size:CGSizeMake(JobManagerSignInBtnWidth, JobManagerSignInBtnHeight)] forState:UIControlStateHighlighted];
    [self addSubview:self.signInBtn];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight + 10, SCREEN_WIDTH, 3 * JobManagerListCellHeight);
    
    line1.frame = CGRectMake(0, self.baseTableView.frame.origin.y - 0.5, SCREEN_WIDTH, 0.5);
    
    self.signInBtn.frame = CGRectMake((SCREEN_WIDTH - JobManagerSignInBtnWidth) / 2, CGRectGetMaxY(self.baseTableView.frame) + 20, JobManagerSignInBtnWidth, JobManagerSignInBtnHeight);
}

@end
