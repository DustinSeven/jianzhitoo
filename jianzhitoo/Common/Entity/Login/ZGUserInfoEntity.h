//
//  ZGUserInfoEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/15/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGUserInfoEntity : ZGBaseEntity

@property (nonatomic , assign) long int identity;
@property (nonatomic , strong) NSString *account;
@property (nonatomic , assign) int sex;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *password;
@property (nonatomic , strong) NSString *qq;
@property (nonatomic , assign) long int provinceId;
@property (nonatomic , strong) NSString *province;
@property (nonatomic , assign) long int cityId;
@property (nonatomic , strong) NSString *city;
@property (nonatomic , assign) long int areaId;
@property (nonatomic , strong) NSString *area;
@property (nonatomic , assign) long int schoolYear;
@property (nonatomic , assign) long int collegeId;
@property (nonatomic , strong) NSString *college;
@property (nonatomic , assign) long int depatmentId;
@property (nonatomic , strong) NSString *depatment;
@property (nonatomic , strong) NSString *specialty;
@property (nonatomic , strong) NSString *userImg;

@end
