//
//  ZGJobParam.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/21/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGJobParam : ZGBaseEntity

@property (nonatomic , assign) int sex;
@property (nonatomic , assign) long int typeId;
@property (nonatomic , assign) long int areaId;
@property (nonatomic , assign) int pageNum;
@property (nonatomic , assign) int pageSize;
@property (nonatomic , strong) NSString *keyword;

@end
