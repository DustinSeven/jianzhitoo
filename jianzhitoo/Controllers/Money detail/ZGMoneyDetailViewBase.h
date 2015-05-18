//
//  ZGMoneyDetailViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//
#define MoneyDetailListSeparatorColor [UIColor colorWithRed:196.0f / 255.0f green:196.0f / 255.0f blue:196.0f / 255.0f alpha:1.0f]

#define MoneyDetailMoneyTimeColor [UIColor colorWithRed:167.0f / 255.0f green:167.0f / 255.0f blue:167.0f / 255.0f alpha:1.0f]
#define MoneyDetailMoneyNumColor [UIColor colorWithRed:32.0f / 255.0f green:193.0f / 255.0f blue:155.0f / 255.0f alpha:1.0f]

#define MoneyDetailListCellHeight 70

@interface ZGMoneyDetailViewBase : ZGBaseView

@property (nonatomic , strong)ZGHeadView *headView;
@property (nonatomic , strong)UITableView *baseTableView;

@end
