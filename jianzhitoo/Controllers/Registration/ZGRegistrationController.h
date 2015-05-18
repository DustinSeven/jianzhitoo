//
//  ZGRegistrationController.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/13/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseController.h"
#import "ZGRegistrationViewIphone.h"
#import "ZGJobDetailEntity.h"
#import "ZGJobDetailEntity.h"
#import "ZGJobDetailController.h"

@interface ZGRegistrationController : ZGBaseController

@property (nonatomic , assign) long int jobId;
@property (nonatomic , strong) NSString *jobName;
@property (nonatomic , strong) NSString *workTimeType;
@property (nonatomic , strong) NSString *shareUrl;
@property (nonatomic , strong) ZGJobDetailController *jobDetailController;

@end
