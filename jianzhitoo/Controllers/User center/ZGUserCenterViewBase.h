//
//  ZGUserSenterViewBase.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//
#import "ZGUserCenterBtnArea.h"

#define UserCenterUserInfoBackHeight 147

#define UserCenterUserImgRadius 30

#define UserCenterUserNameBackImgHeight 35
#define UserCenterUserNameBackImgWidth 163

#define UserCenterSchoolNameLabWidth 250
#define UserCenterSchoolNameLabHeight 15

#define UserCenterKeepedMoneyNumColor [UIColor colorWithRed:253.0f / 255.0f green:129.0f / 255.0f blue:36.0f / 255.0f alpha:1.0f]
#define UserCenterDealingMoneyNumColor [UIColor colorWithRed:35.0f / 255.0f green:196.0f / 255.0f blue:160.0f / 255.0f alpha:1.0f]


#define UserCenterBtnsFirstSpacing 18
#define UserCenterBtnsHSpacing 10


@interface ZGUserCenterViewBase : ZGBaseView

@property (nonatomic , strong) UIScrollView *baseScrollView;
@property (nonatomic , strong) ZGHeadView *headView;
@property (nonatomic , strong) UIImageView *userInfoBackImg;
@property (nonatomic , strong) UIImageView *userImg;
@property (nonatomic , strong) UIImageView *userGenderImg;
@property (nonatomic , strong) UIImageView *userNameBackImg;
@property (nonatomic , strong) UILabel *usernameLab;
@property (nonatomic , strong) UILabel *schoolNameLab;
@property (nonatomic , strong) UILabel *keepedMoneyTitleLab;
@property (nonatomic , strong) UILabel *keepedMoneyNumLab;
@property (nonatomic , strong) UIButton *takeNowBtn;
@property (nonatomic , strong) UILabel *dealingMoneyTitleLab;
@property (nonatomic , strong) UILabel *dealingMoneyNumLab;
@property (nonatomic , strong) NSMutableArray *userBtns;
@property (nonatomic , strong) ZGUserCenterBtnArea *mySignUpBtn;
@property (nonatomic , strong) ZGUserCenterBtnArea *myReadRecordBtn;
@property (nonatomic , strong) ZGUserCenterBtnArea *myChangePwdBtn;
@property (nonatomic , strong) ZGUserCenterBtnArea *mySettingBtn;
@property (nonatomic , strong) ZGUserCenterBtnArea *myMoneyDetailBtn;
@property (nonatomic , strong) ZGUserCenterBtnArea *myAdviceBtn;

@property (nonatomic , strong) UIActivityIndicatorView *activityIndicatorView;

@end
