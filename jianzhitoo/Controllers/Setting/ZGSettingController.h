//
//  ZGSettingController.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseController.h"
#import "ZGSettingViewIphone.h"
#import "ZGLoginProcess.h"
#import "ZGStatementOfLawController.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "ZGJobDetailController.h"

@interface ZGSettingController : ZGBaseController
{
    enum WXScene _scene;
}
@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;
@end
