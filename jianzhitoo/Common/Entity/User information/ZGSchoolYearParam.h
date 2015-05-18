//
//  ZGSchoolYearParam.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/20/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGSchoolYearParam : ZGBaseEntity

@property (nonatomic , assign) long int userId;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *password;
@property (nonatomic , assign) int schoolYear;
@end
