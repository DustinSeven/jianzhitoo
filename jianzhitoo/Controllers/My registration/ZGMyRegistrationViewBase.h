//
//  ZGMyRegistrationViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/8/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//
#import "ZGMyRegistrationAlertViewIphone.h"
#import "ZGCommonAlertViewIphone.h"


#define RegisterListCellHeight 120
#define RegisterJobImgRadius 35

#define RegisterJobImgBorderColor [UIColor colorWithRed:156.0f / 255.0f green:156.0f / 255.0f blue:156.0f / 255.0f alpha:1.0f]

#define RegisterStatusLabColorFinished [UIColor colorWithRed:59.0f / 255.0f green:204.0f / 255.0f blue:172.0f / 255.0f alpha:1.0f]
#define RegisterStatusLabColorNotSignUp [UIColor colorWithRed:253.0f / 255.0f green:154.0f / 255.0f blue:62.0f / 255.0f alpha:1.0f]

#define RegisterBtnColor [UIColor colorWithRed:59.0f / 255.0f green:206.0f / 255.0f blue:176.0f / 255.0f alpha:1.0f]

#define RegisterBtnWidth 92
#define RegisterBtnHeight 23

#define MyRegostrationMoneyColor [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]


@interface ZGMyRegistrationViewBase : ZGBaseView

@property (nonatomic , strong)UITableView *baseTableView;

@property (nonatomic , strong)ZGMyRegistrationAlertViewIphone *alertView;

@property (nonatomic , strong)ZGCommonAlertViewIphone *noticeView;

@end
