//
//  ZGGuideInterfaceViewBase.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//


#define GuideInterfacePageControlWidth 100
#define GuideInterfacePageControlHeight 50

#define GuideInterfaceEnterButtonWidth 195
#define GuideInterfaceEnterButtonHeight 40

#define GuidePageJoinBtnColorNormal [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]
#define GuidePageJoinBtnColorPressed [UIColor colorWithRed:219.0f / 255.0f green:139.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f]

@interface ZGGuideInterfaceViewBase : ZGBaseView

@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) NSMutableArray *images;
@property (nonatomic , strong) UIPageControl *pageControl;
@property (nonatomic , strong) UIButton *enterBtn;

- (void)initWitgets;

@end
