//
//  ZGMainPageViewIphone.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMainPageViewIphone.h"

@interface ZGMainPageViewIphone()
{
    ZGBaseView *searchTextLeftView;
    UIView *headLine;
}

@end

@implementation ZGMainPageViewIphone

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
    
    self.headBackView = [[ZGBaseView alloc]init];
    self.headBackView.backgroundColor = HeadViewBackground;
    [self addSubview:self.headBackView];
    
    headLine = [[UIView alloc]init];
    headLine.backgroundColor = [UIColor colorWithRed:10.0f / 255.0f green:10.0f / 255.0f blue:10.0f / 255.0f alpha:1.0f];
    [self.headBackView addSubview:headLine];
    
//    self.userImg = [[UIImageView alloc]init];
//    self.userImg.backgroundColor = [UIColor clearColor];
//    self.userImg.layer.cornerRadius = MainPageUserImgRadius;
//    self.userImg.layer.masksToBounds = YES;
//    self.userImg.userInteractionEnabled = YES;
//    [self.headBackView addSubview:self.userImg];
    
    self.searchText = [[UITextField alloc]init];
    self.searchText.backgroundColor = MainPageSerchTextBackground;
//    self.searchText.layer.borderWidth = 1;
    self.searchText.layer.borderColor = [UIColor whiteColor].CGColor;
    self.searchText.layer.cornerRadius = MainPageSerchTextHeight / 2;
    self.searchText.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:@"请输入搜索内容"];
    [att addAttribute:NSForegroundColorAttributeName value:MainPageSerchTextPlaceholderColor range:NSMakeRange(0, att.string.length)];
    self.searchText.attributedPlaceholder = att;
    self.searchText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.searchText.textColor = [UIColor whiteColor];
    self.searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchText.returnKeyType = UIReturnKeySearch;
    [self.headBackView addSubview:self.searchText];
    
    searchTextLeftView = [[ZGBaseView alloc]init];
    searchTextLeftView.backgroundColor = [UIColor clearColor];
    [self.searchText setLeftView:searchTextLeftView];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:APP_FONT_COLOR_THIN forState:UIControlStateHighlighted];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL + 3];
    self.cancelBtn.backgroundColor = [UIColor clearColor];
    [self.headBackView addSubview:self.cancelBtn];
    
    self.filterBtnBackView = [[ZGBaseView alloc]init];
    self.filterBtnBackView.backgroundColor = HeadViewBackground;
    [self addSubview:self.filterBtnBackView];
    
    self.verticalLine1 = [[ZGBaseView alloc]init];
    self.verticalLine1.backgroundColor = [UIColor whiteColor];
    self.verticalLine1.alpha = 0.5;
    [self.filterBtnBackView addSubview:self.verticalLine1];
    
    self.verticalLine2 = [[ZGBaseView alloc]init];
    self.verticalLine2.backgroundColor = [UIColor whiteColor];
    self.verticalLine2.alpha = 0.5;
    [self.filterBtnBackView addSubview:self.verticalLine2];
    
    self.jobListTableView = [[UITableView alloc]init];
    self.jobListTableView.backgroundColor = [UIColor clearColor];
    [self.jobListTableView setSeparatorInset:UIEdgeInsetsZero];
    //    self.jobListTableView.layoutMargins = UIEdgeInsetsZero;
    self.jobListTableView.showsVerticalScrollIndicator = NO;
    self.jobListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jobListTableView.delaysContentTouches = NO;
    [self addSubview:self.jobListTableView];
    
    self.genderFilterBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.genderFilterBtn setTitle:@"性别不限" forState:UIControlStateNormal];
    [self.genderFilterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.genderFilterBtn.backgroundColor = [UIColor clearColor];
    self.genderFilterBtn.tag = 201;
    [self.filterBtnBackView addSubview:self.genderFilterBtn];
    
    self.typeFilterBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.typeFilterBtn setTitle:@"类型不限" forState:UIControlStateNormal];
    [self.typeFilterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.typeFilterBtn.backgroundColor = [UIColor clearColor];
    self.typeFilterBtn.tag = 202;
    [self.filterBtnBackView addSubview:self.typeFilterBtn];
    
    self.locationFilterBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.locationFilterBtn setTitle:@"地区不限" forState:UIControlStateNormal];
    [self.locationFilterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.locationFilterBtn.backgroundColor = [UIColor clearColor];
    self.locationFilterBtn.tag = 203;
    [self.filterBtnBackView addSubview:self.locationFilterBtn];

    self.genterBtnTipImg = [[UIImageView alloc]init];
    [self.genderFilterBtn addSubview:self.genterBtnTipImg];
    
    self.typeBtnTipImg = [[UIImageView alloc]init];
    [self.typeFilterBtn addSubview:self.typeBtnTipImg];
    
    self.locationBtnTipImg = [[UIImageView alloc]init];
    [self.locationFilterBtn addSubview:self.locationBtnTipImg];
    
    self.genderList = [[ZGDropDownList alloc]init];
    self.genderList.baseTableView.tag = 204;
    self.genderList.baseView.tag = 304;
    self.genderList.hidden = YES;
    [self addSubview:self.genderList];
    
    self.typeList = [[ZGDropDownList alloc]init];
    self.typeList.baseTableView.tag = 205;
    self.typeList.baseView.tag = 305;
    self.typeList.hidden = YES;
    [self addSubview:self.typeList];
    
    self.locationList = [[ZGDropDownList alloc]init];
    self.locationList.baseTableView.tag = 206;
    self.locationList.baseView.tag = 306;
    self.locationList.hidden = YES;
    [self addSubview:self.locationList];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.headBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HeadViewHeight);
    headLine.frame = CGRectMake(0, HeadViewHeight - 0.3, SCREEN_WIDTH, 0.3);
    
    searchTextLeftView.frame = CGRectMake(0, 0, 10, 5);
    
//    self.userImg.frame = MainPageUserImgFrame;
    
    self.cancelBtn.frame = CGRectMake(250, 25, 50, 30);
    if(IS_IPHONE6)
        self.cancelBtn.frame = CGRectMake(305, 25, 50, 30);
    
    self.filterBtnBackView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, MainPageFilterBackHeight);
    
    float x = (SCREEN_WIDTH - 2 * MainPageVerticalLineWidth) / 3;
    
    self.verticalLine1.frame = CGRectMake(x, (MainPageFilterBackHeight - MainPageVerticalLineHeight) / 2, MainPageVerticalLineWidth, MainPageVerticalLineHeight);
    self.verticalLine2.frame = CGRectMake(2 * x + MainPageVerticalLineWidth, (MainPageFilterBackHeight - MainPageVerticalLineHeight) / 2, MainPageVerticalLineWidth, MainPageVerticalLineHeight);
    
    self.genderFilterBtn.frame = CGRectMake(0, 0, x, MainPageFilterBackHeight);
    self.typeFilterBtn.frame = CGRectMake(x + MainPageVerticalLineWidth, 0, x, MainPageFilterBackHeight);
    self.locationFilterBtn.frame = CGRectMake(2 * (x + MainPageVerticalLineWidth), 0, x, MainPageFilterBackHeight);
    
    self.jobListTableView.frame = CGRectMake(0, self.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight, SCREEN_WIDTH, SCREEN_HEIGHT - (self.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight));
    
    self.genterBtnTipImg.frame = CGRectMake(87, 16, 8.5, 4.5);
    self.typeBtnTipImg.frame = CGRectMake(87, 16, 8.5, 4.5);
    self.locationBtnTipImg.frame = CGRectMake(87, 16, 8.5, 4.5);
    if(IS_IPHONE6)
    {
        self.genterBtnTipImg.frame = CGRectMake(93, 16, 8.5, 4.5);
        self.typeBtnTipImg.frame = CGRectMake(93, 16, 8.5, 4.5);
        self.locationBtnTipImg.frame = CGRectMake(93, 16, 8.5, 4.5);
    }
    
    
    self.genderList.frame = CGRectMake(0, self.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight, SCREEN_WIDTH, SCREEN_HEIGHT - (self.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight));
    self.genderList.baseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (self.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight));
    
    self.typeList.frame = CGRectMake(0, self.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight, SCREEN_WIDTH, SCREEN_HEIGHT - (self.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight));
    self.typeList.baseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (self.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight));
    
    self.locationList.frame = CGRectMake(0, self.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight, SCREEN_WIDTH, SCREEN_HEIGHT - (self.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight));
    self.locationList.baseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (self.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight));
}

@end
