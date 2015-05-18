//
//  ZGSchoolmateViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSchoolmateViewIphone.h"

@implementation ZGSchoolmateViewIphone

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
    
    self.baseGridView = [[GMGridView alloc]init];
    self.baseGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.baseGridView.backgroundColor = [UIColor clearColor];
    self.baseGridView.style = GMGridViewStyleSwap;
    self.baseGridView.minEdgeInsets = UIEdgeInsetsMake(20, 20, 0, 0);
//    self.baseGridView.centerGrid = NO;
    self.baseGridView.showsVerticalScrollIndicator = NO;
    self.baseGridView.itemSpacing = (SCREEN_WIDTH - SchoolmateCellWithHeight * 4) / 5;
    self.baseGridView.minimumPressDuration = 9999;
    self.baseGridView.bounces = YES;
    [self addSubview:self.baseGridView];
    
    self.headView = [[ZGHeadView alloc]init];
    self.headView.headTitleText.text = @"已报校友";
    [self addSubview:self.headView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.baseGridView.frame = CGRectMake(0, HeadViewHeight - 10 , SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight + 10);
}

@end
