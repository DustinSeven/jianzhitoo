//
//  ZGWithdrawToAlipayParam.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/26/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGWithdrawToAlipayParam : ZGBaseEntity

@property (nonatomic , assign) long int userId;
@property (nonatomic , strong) NSString *account;
@property (nonatomic , strong) NSString *pwd;
@property (nonatomic , strong) NSString *alipayAccount;
@property (nonatomic , assign) double money;
@property (nonatomic , strong) NSString *mobile;

@end
