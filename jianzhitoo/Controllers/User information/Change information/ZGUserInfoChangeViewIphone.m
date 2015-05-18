//
//  ZGUserInfoChangeViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/13/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUserInfoChangeViewIphone.h"

@interface ZGUserInfoChangeViewIphone()
{
    
}
@end

@implementation ZGUserInfoChangeViewIphone

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
    
    self.usernameText = [[UITextField alloc]init];
    self.usernameText.backgroundColor = [UIColor clearColor];
    self.usernameText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.usernameText.textColor = APP_FONT_COLOR_NORMAL;
    
    self.usernameBack = [[UIImageView alloc]init];
    self.usernameBack.backgroundColor = [UIColor clearColor];
    self.usernameBack.image = [UIImage imageNamed:@"user_info_change_name_back"];
    
    [self addSubview:self.usernameBack];
    [self addSubview:self.usernameText];
    
    self.baseTableView = [InfiniteTreeView loadFromXib];
    self.baseTableView.backgroundColor = [UIColor clearColor];
//    self.baseTableView.showsVerticalScrollIndicator = NO;
//    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.baseTableView];

}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.usernameText.frame = CGRectMake((SCREEN_WIDTH - UsernameTextBackWidth) / 2 + 15, HeadViewHeight + 15, UsernameTextBackWidth - 30, 30);
    self.usernameBack.frame = CGRectMake((SCREEN_WIDTH - UsernameTextBackWidth) / 2, self.usernameText.frame.origin.y + self.usernameText.frame.size.height - 5, UsernameTextBackWidth, UsernameTextBackHeight);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
}

- (void)chooseViewWithType:(UserInfoChangeType) type
{
    if(type == UserInfoChangeType_Username)
    {
        self.usernameText.placeholder = @"请输入用户名";
        self.baseTableView.hidden = YES;
        self.usernameText.hidden = NO;
        self.usernameBack.hidden = NO;
    }
    if(type == UserInfoChangeType_Mobile)
    {
        self.usernameText.placeholder = @"请输入手机号";
        self.baseTableView.hidden = YES;
        self.usernameText.hidden = NO;
        self.usernameBack.hidden = NO;
    }
    if(type == UserInfoChangeType_QQ)
    {
        self.usernameText.placeholder = @"请输入QQ号";
        self.baseTableView.hidden = YES;
        self.usernameText.hidden = NO;
        self.usernameBack.hidden = NO;
    }
    if(type == UserInfoChangeType_Specialty)
    {
        self.usernameText.placeholder = @"请输入专业名";
        self.baseTableView.hidden = YES;
        self.usernameText.hidden = NO;
        self.usernameBack.hidden = NO;
    }
    if(type == UserInfoChangeType_Province)
    {
        self.baseTableView.hidden = NO;
        self.usernameText.hidden = YES;
        self.usernameBack.hidden = YES;
    }
    if(type == UserInfoChangeType_Area)
    {
        self.baseTableView.hidden = NO;
        self.usernameText.hidden = YES;
        self.usernameBack.hidden = YES;
    }
    if(type == UserInfoChangeType_City)
    {
        self.baseTableView.hidden = NO;
        self.usernameText.hidden = YES;
        self.usernameBack.hidden = YES;
    }
    if(type == UserInfoChangeType_College)
    {
        self.baseTableView.hidden = NO;
        self.usernameText.hidden = YES;
        self.usernameBack.hidden = YES;
    }
    if(type == UserInfoChangeType_Department)
    {
        self.baseTableView.hidden = NO;
        self.usernameText.hidden = YES;
        self.usernameBack.hidden = YES;
    }
    if(type == UserInfoChangeType_Major)
    {
        self.baseTableView.hidden = NO;
        self.usernameText.hidden = YES;
        self.usernameBack.hidden = YES;
    }
}

@end
