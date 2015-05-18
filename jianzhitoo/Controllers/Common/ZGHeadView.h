//
//  ZGHeadView.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/6/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseView.h"


#define HeadTitleWidth 100

@interface ZGHeadView : ZGBaseView

@property (nonatomic , strong) UIButton *backButton;
@property (nonatomic , strong) UILabel *headTitleText;
@property (nonatomic , strong) UIButton *rightBtn;
@property (nonatomic , strong) UIImageView *rightBtnIcon;

@end
