//
//  ZGGuideInterfaceView.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGGuideInterfaceViewIphone.h"

@interface ZGGuideInterfaceViewIphone()

@end

@implementation ZGGuideInterfaceViewIphone

- (id)init
{
    self = [super init];
    if (self)
    {
//        [self initWitgets];
    }
    return self;
}

- (void)initWitgets
{
    self.backgroundColor = VIEW_BACKGROUND;
    
    self.scrollView = [[UIScrollView alloc]init];
    [self addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delaysContentTouches = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.bounces = NO;
//    self.scrollView.bouncesZoom = NO;
    
    for(int i=0;i<self.images.count;++i)
    {
        UIImageView *tmpImgView = [self.images objectAtIndex:i];
        [self.scrollView addSubview:tmpImgView];
    }
    
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.userInteractionEnabled = NO;
    [self addSubview:self.pageControl];
    self.pageControl.numberOfPages = self.images.count;
    
    self.enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.enterBtn setTitle:@"立即进入" forState:UIControlStateNormal];
    self.enterBtn.backgroundColor = [UIColor clearColor];
    [self.enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.enterBtn.layer.cornerRadius = 3;
    self.enterBtn.layer.masksToBounds = YES;
    [self.enterBtn setBackgroundImage:[ZGUtility imageWithColor:GuidePageJoinBtnColorNormal size:CGSizeMake(GuideInterfaceEnterButtonWidth, GuideInterfaceEnterButtonHeight)] forState:UIControlStateNormal];
    [self.enterBtn setBackgroundImage:[ZGUtility imageWithColor:GuidePageJoinBtnColorPressed size:CGSizeMake(GuideInterfaceEnterButtonWidth, GuideInterfaceEnterButtonHeight)] forState:UIControlStateHighlighted];
    [self.scrollView addSubview:self.enterBtn];
}


- (void)layoutSubviews
{
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.images.count, SCREEN_HEIGHT);
    
    self.pageControl.frame = CGRectMake((SCREEN_WIDTH - GuideInterfacePageControlWidth) / 2, SCREEN_HEIGHT - 50, GuideInterfacePageControlWidth, GuideInterfacePageControlHeight);
    
    for(int i=0;i<self.images.count;++i)
    {
        UIImageView *tmpImgView = [self.images objectAtIndex:i];
        tmpImgView.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }

    if(IS_IPHONE4)
    {
        self.enterBtn.frame = CGRectMake((SCREEN_WIDTH - GuideInterfaceEnterButtonWidth) / 2 + (self.images.count - 1) * SCREEN_WIDTH, SCREEN_HEIGHT - 75, GuideInterfaceEnterButtonWidth, GuideInterfaceEnterButtonHeight);
    }
    else
    {
        self.enterBtn.frame = CGRectMake((SCREEN_WIDTH - GuideInterfaceEnterButtonWidth) / 2 + (self.images.count - 1) * SCREEN_WIDTH, SCREEN_HEIGHT - 90, GuideInterfaceEnterButtonWidth, GuideInterfaceEnterButtonHeight);
    }
    
}

@end
