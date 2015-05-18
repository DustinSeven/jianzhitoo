//
//  ZGUpdateInfoEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/11/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGUpdateInfoEntity : ZGBaseEntity

@property (nonatomic , strong) NSString *fileSize;
@property (nonatomic , strong) NSString *nessaryForm;
@property (nonatomic , strong) NSString *os;
@property (nonatomic , strong) NSString *updateInfo;
@property (nonatomic , strong) NSString *updateTime;
@property (nonatomic , strong) NSString *url;
@property (nonatomic , strong) NSString *versionName;
@property (nonatomic , assign) int versionNo;

@end
