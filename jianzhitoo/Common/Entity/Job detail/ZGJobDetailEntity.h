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
@property (nonatomic , strong) NSString *payUnit;
@property (nonatomic , strong) NSString *countType;
@property (nonatomic , strong) NSString *time;
@property (nonatomic , strong) NSString *deadline;
@property (nonatomic , strong) NSString *address;
@property (nonatomic , assign) int jobNum;
@property (nonatomic , assign) int sex;
@property (nonatomic , assign) float height;
@property (nonatomic , assign) int health;
@property (nonatomic , assign) int interview;
@property (nonatomic , strong) NSString *interviewAddr;
@property (nonatomic , strong) NSString *interviewTime;
@property (nonatomic , strong) NSString *jobContent;
@property (nonatomic , strong) NSString *remark;
@property (nonatomic , strong) NSString *workTimeType;
@property (nonatomic , assign) long jobTypeCode;
@property (nonatomic , strong) NSString *latitude;
@property (nonatomic , strong) NSString *longitude;
@property (nonatomic , assign) int enroll;
@property (nonatomic , assign) int remaining;
@property (nonatomic , strong) NSString *shareUrl;


@end
