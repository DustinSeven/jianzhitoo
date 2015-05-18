//
//  ZGBrowseRecordViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBrowseRecordViewIphone.h"

@implementation ZGBrowseRecordViewIphone

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
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.baseTableView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
}

@end
