//
//  ZGMoneyDetailEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/4/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGMoneyDetailEntity : ZGBaseEntity

@property (nonatomic , strong) NSString *name;
@property (nonatomic , assign) double money;
@property (nonatomic , strong) NSString *time;

@end
