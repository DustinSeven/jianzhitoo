//
//  ZGRegisterParam.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGRegisterParam : ZGBaseEntity

@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *pwd;
@property (nonatomic , strong) NSString *veriCode;
@property (nonatomic , strong) NSString *veriCodeTime;

@end
