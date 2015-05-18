//
//  ZGSearchRecordEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGSearchRecordEntity : ZGBaseEntity

@property (nonatomic , assign) int identity;
@property (nonatomic , strong) NSString *keyWord;
@property (nonatomic , strong) NSString *condition;
@property (nonatomic , strong) NSDate *searchDate;
@property (nonatomic , assign) int sex;
@property (nonatomic , strong) NSString* typeId;
@property (nonatomic , assign) long int locationId;

@end
