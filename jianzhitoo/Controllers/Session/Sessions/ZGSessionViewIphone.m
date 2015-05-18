//
//  ZGSessionViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/6.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGSessionViewIphone.h"

@implementation ZGSessionViewIphone

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
    self.backgroundColor = [UIColor whiteColor];
    
    self.baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.baseTableView.backgroundColor = [UIColor clearColor];
//    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.showsVerticalScrollIndicator = NO;
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.baseTableView setTableFooterView:view];
    [self addSubview:self.baseTableView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SocialContactSegHeight - HeadViewHeight);
    self.baseTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SocialContactSegHeight - HeadViewHeight);
}

@end
