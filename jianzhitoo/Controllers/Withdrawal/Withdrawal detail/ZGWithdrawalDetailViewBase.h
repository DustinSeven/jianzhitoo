//
//  ZGWithdrawalDetailViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/11/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#define WithdrawalDetailBackground [UIColor colorWithRed:240.0f / 255.0f green:240.0f / 255.0f blue:240.0f / 255.0f alpha:1.0f]

#define WithdrawalDetailMoneyColor [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]

#define WithdrawalDetailNoticeColor [UIColor colorWithRed:45.0f / 255.0f green:206.0f / 255.0f blue:174.0f / 255.0f alpha:1.0f]

#define WithdrawalDetailSubmitBtnBackgroundNormal [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]
#define WithdrawalDetailSubmitBtnBackgroundPressed [UIColor colorWithRed:219.0f / 255.0f green:139.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f]

#define WithdrawalLineColor [UIColor colorWithRed:196.0f / 255.0f green:196.0f / 255.0f blue:196.0f / 255.0f alpha:1.0f]

#define WithdrawalDetailCellHeight 45

#define WithdrawalDetailSubmitBtnHeight 40
#define WithdrawalDetailSubmitBtnWidth 242.5

typedef enum
{
    WithdrawalDetailViewType_Alipay = 0,
    WithdrawalDetailViewType_Bank,
}WithdrawalDetailViewType;

@interface ZGWithdrawalDetailViewBase : ZGBaseView

@property (nonatomic , strong) ZGHeadView *headView;
@property (nonatomic , strong) UILabel *balanceLab;
@property (nonatomic , strong) UITableView *baseTableView;
@property (nonatomic , strong) UILabel *noticeLab;
@property (nonatomic , strong) UIButton *submitBtn;

@property (nonatomic , assign)WithdrawalDetailViewType viewType;

@end
