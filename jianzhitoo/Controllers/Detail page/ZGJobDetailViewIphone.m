//
//  ZGJobDetailViewIphone.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/6/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGJobDetailViewIphone.h"

@interface ZGJobDetailViewIphone()
{
    UIImageView *backIcon;
    ZGBaseView *jobNameBackView;
}

@end

@implementation ZGJobDetailViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        [self initWetgits];
    }
    return self;
}

- (void)initWetgits
{
    self.backgroundColor = VIEW_BACKGROUND;
    
    self.baseTableView = [[UITableView alloc]init];
    self.baseTableView.bounces = YES;
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.separatorColor = [UIColor clearColor];
    [self addSubview:self.baseTableView];
    
    jobNameBackView = [[ZGBaseView alloc]init];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
}

@end
