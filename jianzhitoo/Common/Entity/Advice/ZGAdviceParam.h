//
//  ZGAdviceParam.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGAdviceParam : ZGBaseEntity

@property (nonatomic , assign) long int userId;
@property (nonatomic , strong) NSString *account;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *content;
@property (nonatomic , strong) NSString *email;
@property (nonatomic , strong) NSString *qq;

@end
