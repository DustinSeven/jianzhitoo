//
//  ZGBrowseRecordEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"
#import "ZGJobEntity.h"

@interface ZGBrowseRecordEntity : ZGBaseEntity

@property (nonatomic , strong) ZGJobEntity *jobEntity;
@property (nonatomic , strong) NSDate *date;

@end
