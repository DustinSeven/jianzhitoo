//
//  ZGMyRegistrationDetailParam.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGMyRegistrationDetailParam : ZGBaseEntity

@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *password;
@property (nonatomic , assign) long int jobId;
@property (nonatomic , assign) long userId;
@end
