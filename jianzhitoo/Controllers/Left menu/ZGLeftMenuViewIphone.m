//
//  ZGLeftMenuViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 14/12/30.
//  Copyright (c) 2014年 Lee Mingwei. All rights reserved.
//

#import "ZGLeftMenuViewIphone.h"

@implementation ZGLeftMenuViewIphone

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
    self.backgroundColor = [UIColor clearColor];
    
    self.baseTableView = [[UITableView alloc]init];
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.baseTableView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight, LEFT_DRAWER_WIDTH, LeftMenuTableViewRowHeight * 6);
}


@end
