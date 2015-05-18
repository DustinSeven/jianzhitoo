//
//  ZGUserInfoChangeViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/13/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGCommonAlertViewIphone.h"
#import "InfiniteTreeView.h"

#define UsernameTextBackWidth 285.5
#define UsernameTextBackHeight 5


typedef enum
{
    UserInfoChangeType_Username = 0,
    UserInfoChangeType_Mobile,
    UserInfoChangeType_QQ,
    UserInfoChangeType_College,
    UserInfoChangeType_Department,
    UserInfoChangeType_Major,
    UserInfoChangeType_Province,
    UserInfoChangeType_Area,
    UserInfoChangeType_City,
    UserInfoChangeType_Specialty,
}UserInfoChangeType;

@interface ZGUserInfoChangeViewBase : ZGBaseView

@property (nonatomic , strong) UITextField *usernameText;

@property (nonatomic , strong) UIImageView *usernameBack;

@property (nonatomic , strong) InfiniteTreeView *baseTableView;

- (void)chooseViewWithType:(UserInfoChangeType) type;
@end
