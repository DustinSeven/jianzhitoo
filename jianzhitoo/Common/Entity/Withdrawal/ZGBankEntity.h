//
//  ZGBankEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGBankEntity : ZGBaseEntity

@property (nonatomic , strong) NSString *bankCode;
@property (nonatomic , strong) NSString *bankName;
@property (nonatomic , strong) NSString *bankIcon;

@end
