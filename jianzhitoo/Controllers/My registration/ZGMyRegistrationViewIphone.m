//
//  ZGMyRegistrationViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/8/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMyRegistrationViewIphone.h"

@implementation ZGMyRegistrationViewIphone

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
    self.baseTableView.backgroundColor = [UIColor clearColor];
    [self.baseTableView setSeparatorInset:UIEdgeInsetsZero];
//    self.baseTableView.layoutMargins = UIEdgeInsetsZero;
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.delaysContentTouches = NO;
    [self addSubview:self.baseTableView];
    
    self.alertView = [[ZGMyRegistrationAlertViewIphone alloc]init];
    self.alertView.hidden = YES;
    [self addSubview:self.alertView];
    
    self.noticeView = [[ZGCommonAlertViewIphone alloc]init];
    self.noticeView.hidden = YES;
    [self addSubview:self.noticeView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight,SCREEN_WIDTH,SCREEN_HEIGHT - HeadViewHeight);
    
    
}

@end
