//
//  ZGProvacyEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/29/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGProvacyEntity : ZGBaseEntity

@property (nonatomic , assign) int openToSchoolmate;
@property (nonatomic , assign) int openToContacts;
@property (nonatomic , assign) int openToFriends;
@property (nonatomic , assign) int pushable;
@property (nonatomic , strong) NSString *pushTime;
@property (nonatomic , strong) NSString *pushDate;


@end
