//
//  ZGLoginController.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseController.h"
#import "ZGJobDetailController.h"
#import "ZGUserCenterController.h"


typedef enum
{
    LoginReturnType_LeftMenu = 1,
    LoginReturnType_Nav,
    LoginReturnType_Diss
}LoginReturnType;

@protocol ZGLoginDelegate <NSObject>

- (NSString *)stringForLoginAccount;

@end

@interface ZGLoginController : ZGBaseController

@property (nonatomic ,strong) id<ZGLoginDelegate> delegate;

@property (nonatomic , strong) ZGJobDetailController *jobDetailController;
@property (nonatomic , strong) ZGUserCenterController *userCenterController;

@property (nonatomic , assign) LoginReturnType loginReturnType;

@end
