//
//  ZGJobDetailEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/16/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGJobDetailEntity : ZGBaseEntity

@property (nonatomic , strong) NSString *jobImg;
@property (nonatomic , strong) NSString *jobName;
@property (nonatomic , strong) NSString *company;
@property (nonatomic , assign) double money;
@property (nonatomic , strong) NSString *countType;
@property (nonatomic , strong) NSString *time;
@property (nonatomic , strong) NSDate *deadline;
@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSString *jobNum;
@property (nonatomic , strong) NSString *sex;
@property (nonatomic , strong) NSString *height;
@property (nonatomic , strong) NSString *health;
@property (nonatomic , strong) NSString *interview;
@property (nonatomic , strong) NSString *interviewAddr;
@property (nonatomic , strong) NSString *interviewTime;
@property (nonatomic , strong) NSString *jobContent;
@property (nonatomic , strong) NSString *remark;


@end
