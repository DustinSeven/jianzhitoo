//
//  ZGPrivacySettingCell.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGBaseTableViewCell.h"

#define PrivacyCellHeight 45
#define PrivacySettingListSeparatorColor [UIColor colorWithRed:196.0f / 255.0f green:196.0f / 255.0f blue:196.0f / 255.0f alpha:1.0f]

@interface ZGPrivacySettingCell : ZGBaseTableViewCell

@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UISwitch *priSwitch;

@end
