//
//  ZGSchoolmateAlertViewIphone.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/25/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAlertViewBase.h"
#import "ZGSchoolmateEntity.h"

#define SchoolmateAlertViewBackImgUpWidth 243
#define SchoolmateAlertViewBackImgUpHeight 131.5

#define SchoolmateAlertViewUserImgRadius 30

#define SchoolmateAlertViewUsernameLabWidth 100
#define SchoolmateAlertViewUsernameLabHeight 20

#define SchoolmateAlertViewDepartmentLabWidth 100
#define SchoolmateAlertViewDepartmentLabHeight 20

#define SchoolmateAlertViewPhoneIconWidth 13.5
#define SchoolmateAlertViewPhoneIconHeight 20

#define SchoolmateAlertViewPhoneNumLabWidth 100
#define SchoolmateAlertViewPhoneNumLabHeight 20

#define SchoolmateAlertViewCallBtnWidth 243
#define SchoolmateAlertViewCallBtnHeight 39.5

@interface ZGSchoolmateAlertViewIphone : ZGAlertViewBase

@property (nonatomic , strong)UIImageView *backImgUp;
@property (nonatomic , strong)ZGBaseView *baseView;
@property (nonatomic , strong)UIImageView *userImg;
@property (nonatomic , strong)UIImageView *genderImg;
@property (nonatomic , strong)UILabel *usernameLab;
@property (nonatomic , strong)UILabel *departmentLab;
@property (nonatomic , strong)UIImageView *phoneIcon;
@property (nonatomic , strong)UILabel *phoneNumLab;
@property (nonatomic , strong)UIButton *callBtn;

@property (nonatomic , strong)UIView *fatherView;
@property (nonatomic , strong)ZGSchoolmateEntity *schoolmateEntity;

- (void)showAlertWithEntity:(ZGSchoolmateEntity *)entity;
- (id)initWithView:(UIView *)view;

@end
