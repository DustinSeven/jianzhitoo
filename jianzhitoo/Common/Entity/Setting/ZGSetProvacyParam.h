//
//  ZGSetProvacyParam.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/29/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGSetProvacyParam : ZGBaseEntity

@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *pwd;
@property (nonatomic , assign) long int userId;
@property (nonatomic , assign) int openToSchoolmateProvacy;

@end
