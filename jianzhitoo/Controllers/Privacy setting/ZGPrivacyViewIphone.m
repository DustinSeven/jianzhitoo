//
//  ZGPrivacyViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGPrivacyViewIphone.h"

@interface ZGPrivacyViewIphone()
{
    ZGBaseView *line;
}

@end

@implementation ZGPrivacyViewIphone

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
    
    line = [[ZGBaseView alloc]init];
    line.backgroundColor = PrivacySettingListSeparatorColor;
    [self addSubview:line];
    
    self.baseTableView = [[UITableView alloc]init];
    self.baseTableView.bounces = NO;
    self.baseTableView.backgroundColor = [UIColor clearColor];
    [self.baseTableView setSeparatorInset:UIEdgeInsetsZero];
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.baseTableView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight + 10, SCREEN_WIDTH, PrivacyCellHeight);
    
    line.frame = CGRectMake(0, HeadViewHeight + 9.5, SCREEN_WIDTH, 0.5);
}

@end
