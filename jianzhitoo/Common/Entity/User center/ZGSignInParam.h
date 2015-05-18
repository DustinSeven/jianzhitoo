//
//  ZGSignInParam.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGSignInParam : ZGBaseEntity

@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *pwd;
@property (nonatomic , assign) long int jobId;
@property (nonatomic , strong) NSString *checkCode;

@end
