//
//  ZGMoneyDetailViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMoneyDetailViewIphone.h"

@implementation ZGMoneyDetailViewIphone

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
    self.headView.headTitleText.text = @"资金明细";
    [self addSubview:self.headView];
    
    self.baseTableView = [[UITableView alloc]init];
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.baseTableView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight,SCREEN_WIDTH,SCREEN_HEIGHT - HeadViewHeight);
}
@end
