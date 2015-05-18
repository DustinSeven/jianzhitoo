//
//  ZGWithdrawalToBankParam.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGWithdrawalToBankParam : ZGBaseEntity

@property (nonatomic , assign) long int userId;
@property (nonatomic , strong) NSString *account;
@property (nonatomic , strong) NSString *pwd;
@property (nonatomic , strong) NSString *bankCardNum;
@property (nonatomic , strong) NSString *accountBankPath;
@property (nonatomic , strong) NSString *bankCode;
@property (nonatomic , assign) double money;
@property (nonatomic , strong) NSString *mobile;

@end
