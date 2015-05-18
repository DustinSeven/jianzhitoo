//
//  ZGStatementOfLawViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGStatementOfLawViewIphone.h"

@implementation ZGStatementOfLawViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = VIEW_BACKGROUND;
        
        self.baseWebView = [[UIWebView alloc]init];
//        self.baseWebView.scalesPageToFit = YES;
        self.baseWebView.backgroundColor = VIEW_BACKGROUND;
        [self addSubview:self.baseWebView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.baseWebView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
}

@end
