//
//  ZGRegistrationViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMyRegistrationAlertViewIphone.h"

#define RegistrationDetailJobImgRadius 35

#define RegistrationDetailJobInfoBackHeight 95

#define RegistrationDetailJobImgBorderColor [UIColor colorWithRed:156.0f / 255.0f green:156.0f / 255.0f blue:156.0f / 255.0f alpha:1.0f]

#define RegistrationDetailJobTimeTitleBackHeight 45

#define RegistrationDetailJobTimeTableViewHeight 250

#define RegisterDetailBtnColor [UIColor colorWithRed:59.0f / 255.0f green:206.0f / 255.0f blue:176.0f / 255.0f alpha:1.0f]

#define RegisterDetailBtnWidth 119
#define RegisterDetailBtnHeight 35

#define RegisterDetailCellDateLabWidth 160
#define RegisterDetailCellDateLabHeight 30

#define RegisterDetailStatusCellHeight 40

#define RegistrationNotSignUpColor [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]

#define RegostrationMoneyColor [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]

@interface ZGRegistrationDetailViewBase : ZGBaseView

@property (nonatomic , strong) ZGBaseView *jobInfoBackView;
@property (nonatomic , strong) UIImageView *jobImg;
@property (nonatomic , strong) UILabel *jobNamelab;
@property (nonatomic , strong) UIImageView *rmbIconImg;
@property (nonatomic , strong) UIImageView *locIconImg;
@property (nonatomic , strong) UILabel *rmbLab;
@property (nonatomic , strong) UILabel *locLab;

@property (nonatomic , strong) ZGBaseView *jobStatusBackView;
@property (nonatomic , strong) UIImageView *jobTimeIcon;
@property (nonatomic , strong) UILabel *jobTimeTitleLab;

@property (nonatomic , strong) UITableView *jobTimeTableView;

@property (nonatomic , strong) UIButton *refuseBtn;
@property (nonatomic , strong) UIButton *connectBtn;

@property (nonatomic , strong)ZGMyRegistrationAlertViewIphone *alertView;

@end
