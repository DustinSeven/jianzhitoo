//
//  ZGJobEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/19/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGJobEntity : ZGBaseEntity

@property (nonatomic , assign) long int identity;
@property (nonatomic , strong) NSString *title;
@property (nonatomic , assign) double money;
@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSString *countType;
@property (nonatomic , strong) NSString *moneyType;
@property (nonatomic , strong) NSString *jobImg;
@property (nonatomic , assign) int timeType;
@property (nonatomic , strong) NSString *jobType;
@property (nonatomic , assign) int remaining;
@property (nonatomic , assign) long jobTypeCode;
@property (nonatomic , assign) int isJobNew;

@end
