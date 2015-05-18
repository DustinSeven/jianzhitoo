//
//  ZGJobDetailController.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/6/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseController.h"
#import "ZGJobDetailParam.h"
#import "ZGJobDetailEntity.h"
#import "WXApiObject.h"
#import "WXApi.h"

@protocol sendMsgToWeChatViewDelegate <NSObject>
- (void) sendLinkContentWithScrean:(int)screanType;
- (void) changeScene:(int)scene;
@end


@interface ZGJobDetailController : ZGBaseController<UIActionSheetDelegate,WXApiDelegate,sendMsgToWeChatViewDelegate>
{
    enum WXScene _scene;
}

@property (nonatomic , strong) ZGJobDetailParam *param;


@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;

@end
