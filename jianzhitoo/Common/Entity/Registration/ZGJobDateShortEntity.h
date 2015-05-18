//
//  ZGJobDateShortEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/26/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGJobDateShortEntity : ZGBaseEntity

@property (nonatomic , assign)int full;
@property (nonatomic , assign)int userEnRoll;
@property (nonatomic , strong)NSString *workDate;

@end
