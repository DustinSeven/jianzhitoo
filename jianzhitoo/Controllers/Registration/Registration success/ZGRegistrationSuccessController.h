//
//  ZGRegistrationSuccessController.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseController.h"
#import "ZGRegistrationSuccessViewIphone.h"
#import "ZGJobDetailController.h"
#import "WXApiObject.h"
#import "WXApi.h"

@interface ZGRegistrationSuccessController : ZGBaseController<WXApiDelegate,sendMsgToWeChatViewDelegate>
{
    enum WXScene _scene;
}

@property (nonatomic , strong) ZGJobDetailController *jobDetailController;
@property (nonatomic , strong) NSString *jobName;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *shareUrl;

@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;

@end
