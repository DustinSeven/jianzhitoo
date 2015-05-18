//
//  ZGMainPageViewBase.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGDropDownList.h"
#import "ZGCommonAlertViewIphone.h"

#define MainPageHeadViewBackground [UIColor colorWithRed:61.0f / 255.0f green:205.0f / 255.0f blue:176.0f / 255.0f alpha:1.0f]

#define MainPageSearchTextWidth (IS_IPHONE6?265:210)
#define MainPageSerchTextHeight 30
#define MainPageSerchTextBackground [UIColor colorWithRed:53.0f / 255.0f green:130.0f / 255.0f blue:201.0f / 255.0f alpha:1.0f]
#define MainPageSerchTextPlaceholderColor [UIColor colorWithRed:207.0f / 255.0f green:207.0f / 255.0f blue:207.0f / 255.0f alpha:1.0f]
#define MainPageSearchTextFrameNormal CGRectMake((SCREEN_WIDTH - MainPageSearchTextWidth) / 2 - 15, HeadViewHeight - MainPageSerchTextHeight - 10, MainPageSearchTextWidth, MainPageSerchTextHeight)
#define MainPageSearchTextFrameTrans CGRectMake(30, HeadViewHeight - MainPageSerchTextHeight - 10, MainPageSearchTextWidth, MainPageSerchTextHeight)

#define MainPageFilterButtonBackground [UIColor colorWithRed:42.0f / 255.0f green:187.0f / 255.0f blue:156.0f / 255.0f alpha:1.0f]

#define MainPageFilterBackHeight 36

#define MainPageVerticalLineHeight 28
#define MainPageVerticalLineWidth 1

#define MainPageListSeparatorColor [UIColor colorWithRed:196.0f / 255.0f green:196.0f / 255.0f blue:196.0f / 255.0f alpha:1.0f]

#define MainPageListRowHeight 96

#define MainPageJobImgRadius 35
#define MainPageJobImgBorderColor [UIColor colorWithRed:156.0f / 255.0f green:156.0f / 255.0f blue:156.0f / 255.0f alpha:1.0f]

#define MainPageMoneyColor [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]

#define MainPageJobStatusTextColor [UIColor colorWithRed:252.0f / 255.0f green:153.0f / 255.0f blue:46.0f / 255.0f alpha:1.0f]

#define MainPageUserImgRadius 20
#define MainPageUserImgBorderColor [UIColor colorWithRed:156.0f / 255.0f green:156.0f / 255.0f blue:156.0f / 255.0f alpha:1.0f]
#define MainPageUserImgFrame CGRectMake(12, 19, 2 * MainPageUserImgRadius, 2 * MainPageUserImgRadius)

#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))




//#define <#macro#>

@interface ZGMainPageViewBase : ZGBaseView

//@property (nonatomic , strong) UIImageView *userImg;
@property (nonatomic , strong) ZGBaseView *headBackView;
@property (nonatomic , strong) ZGBaseView *filterBtnBackView;
@property (nonatomic , strong) UITextField *searchText;
@property (nonatomic , strong) UIButton *cancelBtn;
@property (nonatomic , strong) UIButton *genderFilterBtn;
@property (nonatomic , strong) UIImageView *genterBtnTipImg;
@property (nonatomic , strong) UIButton *typeFilterBtn;
@property (nonatomic , strong) UIImageView *typeBtnTipImg;
@property (nonatomic , strong) UIButton *locationFilterBtn;
@property (nonatomic , strong) UIImageView *locationBtnTipImg;
@property (nonatomic , strong) ZGBaseView *verticalLine1;
@property (nonatomic , strong) ZGBaseView *verticalLine2;
@property (nonatomic , strong) UITableView *jobListTableView;

@property (nonatomic , strong) ZGDropDownList *genderList;
@property (nonatomic , strong) ZGDropDownList *typeList;
@property (nonatomic , strong) ZGDropDownList *locationList;

@end
