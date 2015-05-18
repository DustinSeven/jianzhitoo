//
//  ZGSettingViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSettingViewIphone.h"

@interface ZGSettingViewIphone()
{
    ZGBaseView *line1;
    ZGBaseView *line2;
}

@end

@implementation ZGSettingViewIphone

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
    [self.baseTableView setSeparatorColor:SettingListSeparatorColor];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.baseTableView];
    
    line1 = [[ZGBaseView alloc]init];
    line1.backgroundColor = SettingListSeparatorColor;
    [self addSubview:line1];
    
    line2 = [[ZGBaseView alloc]init];
    line2.backgroundColor = SettingListSeparatorColor;
    [self addSubview:line2];
    
    self.logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.logoutBtn.layer.cornerRadius = 3;
    self.logoutBtn.layer.masksToBounds = YES;
    self.logoutBtn.backgroundColor = [UIColor clearColor];
    [self.logoutBtn setBackgroundImage:[ZGUtility imageWithColor:SettingLogoutBtnBackgroundNormal size:CGSizeMake(SettingLogoutBtnWidth, SettingLogoutBtnHeight)] forState:UIControlStateNormal];
    [self.logoutBtn setBackgroundImage:[ZGUtility imageWithColor:SettingLogoutBtnBackgroundPressed size:CGSizeMake(SettingLogoutBtnWidth, SettingLogoutBtnHeight)] forState:UIControlStateHighlighted];
    [self addSubview:self.logoutBtn];

}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight + 10, SCREEN_WIDTH, 7 * SettingListCellHeight);
    
    line1.frame = CGRectMake(0, self.baseTableView.frame.origin.y - 0.5, SCREEN_WIDTH, 0.5);
    line2.frame = CGRectMake(0, self.baseTableView.frame.origin.y + self.baseTableView.frame.size.height - 0.5, SCREEN_WIDTH, 0.5);
    
    self.logoutBtn.frame = CGRectMake((SCREEN_WIDTH - SettingLogoutBtnWidth) / 2, self.baseTableView.frame.origin.y + self.baseTableView.frame.size.height + 20, SettingLogoutBtnWidth, SettingLogoutBtnHeight);
    
    
}

@end
