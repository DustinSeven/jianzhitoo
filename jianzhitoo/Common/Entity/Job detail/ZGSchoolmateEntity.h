//
//  ZGScholmateEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/21/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGSchoolmateEntity : ZGBaseEntity

@property (nonatomic , assign) long int identity;
@property (nonatomic , strong) NSString *userImg;
@property (nonatomic , assign) int sex;
@property (nonatomic , strong) NSString *account;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *department;
@property (nonatomic , strong) NSDate *registrationTime;
@property (nonatomic , assign) int ota;

@end
