//
//  ZGRegisterControllerViewController.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/8/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseController.h"
#import "ZGRegisterViewIphone.h"
#import "ZGUtility.h"
#import "ZGRegisterProcess.h"
#import "ZGRegisterParam.h"
#import "ZGVeriCodeParam.h"
#import "ZGUserCenterController.h"
#import "ZGJobDetailController.h"

@interface ZGRegisterController : ZGBaseController

@property (nonatomic , strong) ZGUserCenterController *userCenterController;
@property (nonatomic , strong) ZGJobDetailController *jobDetailController;
@end
