//
//  ZGMyRegistrationEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/19/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGMyRegistrationEntity : ZGBaseEntity

@property (nonatomic , strong) NSString *address;
@property (nonatomic , assign) double money;
@property (nonatomic , strong) NSString *jobImg;
@property (nonatomic , strong) NSString *jobTitle;

@end
