//
//  ZGDropDownList.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/7/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGDropDownList.h"

@implementation ZGDropDownList

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
    self.baseView = [[ZGBaseView alloc]init];
    self.baseView.backgroundColor = [UIColor blackColor];
    self.baseView.alpha = 0.0f;
    [self addSubview:self.baseView];
    
    self.baseTableView = [[UITableView alloc]init];
    //    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.backgroundColor = [UIColor whiteColor];
    [self.baseTableView setSeparatorInset:UIEdgeInsetsZero];
    //    self.baseTableView.layoutMargins = UIEdgeInsetsZero;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.baseTableView];
    self.baseTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    
    self.activityView = [[UIActivityIndicatorView alloc]init];
    self.activityView.hidden = YES;
    self.activityView.hidesWhenStopped = YES;
    self.activityView.color = [UIColor blackColor];
    [self.baseTableView addSubview:self.activityView];
    
    self.backgroundColor = [UIColor clearColor];
}

@end
