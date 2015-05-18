//
//  ZGBrowseRecordViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseView.h"
#import "ZGHeadView.h"


#define BrowseRecordPageMoneyColor [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]

#define BrowseRecordPageListRowHeight 96

@interface ZGBrowseRecordViewBase : ZGBaseView

@property (nonatomic , strong)UITableView *baseTableView;

@end
