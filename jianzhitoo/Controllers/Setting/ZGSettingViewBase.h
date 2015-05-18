//
//  ZGSettingViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//
#define SettingListSeparatorColor [UIColor colorWithRed:196.0f / 255.0f green:196.0f / 255.0f blue:196.0f / 255.0f alpha:1.0f]

#define SettingLogoutBtnBackgroundNormal [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]
#define SettingLogoutBtnBackgroundPressed [UIColor colorWithRed:219.0f / 255.0f green:139.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f]

#define SettingListCellHeight 40

#define SettingLogoutBtnWidth 245
#define SettingLogoutBtnHeight 40

@interface ZGSettingViewBase : ZGBaseView

@property (nonatomic , strong) UITableView *baseTableView;

@property (nonatomic , strong) UIButton *logoutBtn;

@end
