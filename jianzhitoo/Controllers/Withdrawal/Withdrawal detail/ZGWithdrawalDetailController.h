//
//  ZGWithdrawalDetailController.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/11/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseController.h"
#import "ZGWithdrawalDetailViewIphone.h"

typedef enum
{
    WithdrawalDetailType_Alipay = 0,
    WithdrawalDetailType_Bank,
}WithdrawalDetailType;

@interface ZGWithdrawalDetailController : ZGBaseController

@property (nonatomic , assign)WithdrawalDetailType controllerType;
@property (nonatomic , assign) double enableMoney;

@end
