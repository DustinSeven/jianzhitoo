//
//  ZGSchoolmateParam.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/21/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGSchoolmateParam : ZGBaseEntity

@property (nonatomic , assign) long int userId;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *password;
@property (nonatomic , assign) long int jobId;
@property (nonatomic , assign) int page;
@property (nonatomic , assign) int pageSize;

@end
