//
//  ZGUpdateLocationParam.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/17/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGUpdateLocationParam : ZGBaseEntity

@property (nonatomic , assign) long int provinceId;
@property (nonatomic , assign) long int cityId;
@property (nonatomic , assign) long int areaId;
@property (nonatomic , assign) long int userId;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *password;

@end
