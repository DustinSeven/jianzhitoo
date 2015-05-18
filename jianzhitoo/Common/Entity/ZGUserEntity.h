//
//  ZGUserEntity.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGUserEntity : ZGBaseEntity

@property (nonatomic , assign) long int identity;
@property (nonatomic , strong) NSString *account;
@property (nonatomic , assign) int sex;
@property (nonatomic , strong) NSString *remarks;
@property (nonatomic , assign) long int collegeId;
@property (nonatomic , strong) NSString *collegeName;
@property (nonatomic , strong) NSString *userImg;
@property (nonatomic , strong) NSString *password;


@end
