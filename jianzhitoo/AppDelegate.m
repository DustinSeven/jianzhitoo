//
//  AppDelegate.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/4/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "AppDelegate.h"
#import "ZGGuideInterfaceController.h"
#import "ZGMainPageController.h"
#import "ZGLoginProcess.h"
#import "ZGUserParam.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGDrawerController.h"
#import "ZGUserCenterController.h"
#import "ZGLeftMenuController.h"
#import "BPush.h"


@interface AppDelegate ()
{
    ZGUpdateAlertView *alertView;
    ZGUpdateInfoEntity *entity;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:1];
    
    
    
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarStyle:UIStatusBarStyleLightContent];
    
    ZGGuideInterfaceController *guideController = [[ZGGuideInterfaceController alloc]init];
    NSString *guideValue = [ZGUtility readUserDefaults:USERDEFAULTS_GUIDE_KEY];

    if([guideValue isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]])
    {
        ZGMainPageController *mainPageController = [[ZGMainPageController alloc]init];
        ZGLeftMenuController *userCenterController = [[ZGLeftMenuController alloc]init];
        
        ZGBaseNavigationController * centerSideNavController = [[ZGBaseNavigationController alloc] initWithRootViewController:mainPageController];
        [centerSideNavController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
        
        ZGBaseNavigationController * leftSideNavController = [[ZGBaseNavigationController alloc] initWithRootViewController:userCenterController];
        [leftSideNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
        
        ZGDrawerController *mainNavigation = [[ZGDrawerController alloc]
                                              initWithCenterViewController:centerSideNavController
                                              leftDrawerViewController:leftSideNavController];
        mainNavigation.showsStatusBarBackgroundView = NO;
        self.window.rootViewController = mainNavigation;
    }
    else
    {
        [ZGUtility saveUserDefaults:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] key:USERDEFAULTS_GUIDE_KEY];
        ZGBaseNavigationController *mainNavigation = [[ZGBaseNavigationController alloc]initWithRootViewController:guideController];
        mainNavigation.navigationBarHidden = YES;
        self.window.rootViewController = mainNavigation;
    }
    
    NSString *deviceValue = [ZGUtility readUserDefaults:USER_DEVICE_INFO_KEY];
    if(!deviceValue)
    {
        [ZGUtility saveUserDefaults:@"yes" key:USER_DEVICE_INFO_KEY];
        [[ZGLoginProcess shareInstance]updateAPPInfoWithParam:[[[ZGBaseEntity alloc] init] getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
    
    ZGUserInfoEntity *userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    
    [[ZGLoginProcess shareInstance]getUpdateInfoWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [responseObject objectForKey:@"data"];
            entity = [[ZGUpdateInfoEntity alloc]initWithAttributes:[data objectAtIndex:0]];
            ZGBaseEntity *baseEntity = [[ZGBaseEntity alloc]init];
            
            if(entity.versionNo > baseEntity.cversion)
            {
                alertView = [ZGUtility showUpdateAlertWithEntity:entity parentView:self.window];
                [alertView.cancelBtn addTarget:self action:@selector(updatePaneCancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [alertView.updateBtn addTarget:self action:@selector(updatePaneUpdateBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
        if(userInfoEntity)
        {
            ZGUserParam *loginParam = [[ZGUserParam alloc]init];
            loginParam.mobile = userInfoEntity.mobile;
            loginParam.pwd = userInfoEntity.password;
            
            
            [[ZGLoginProcess shareInstance] loginWithParam:[loginParam getDictionary] loginSuccess:^(AFHTTPRequestOperation *loginOperation, id loginResponseObject) {
                
//                if([[loginResponseObject objectForKey:@"code"]intValue] == 200)
//                {
//                    NSArray *data = [loginResponseObject objectForKey:@"data"];
//                    ZGUserEntity *userEntity = [[ZGUserEntity alloc]initWithAttributes:[data objectAtIndex:0]];
//                    userEntity.password = loginParam.pwd;
//                    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_KEY];
//                    [ZGUtility saveUserDefaults:userEntity key:USERDEFAULTS_USER_KEY];
//                }
                
            } loginFailure:^(AFHTTPRequestOperation *loginOperation, NSError *LoginError) {
                
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
                
            } getInfoSuccess:^(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject) {
                
                if([[getInfoResponseObject objectForKey:@"code"]intValue] == 200)
                {
                    NSArray *data = [getInfoResponseObject objectForKey:@"data"];
                    ZGUserInfoEntity *userEntity = [[ZGUserInfoEntity alloc]initWithAttributes:[data objectAtIndex:0]];
                    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
                    [ZGUtility saveUserDefaults:userEntity key:USERDEFAULTS_USER_INFO_KEY];
                }
                else
                {
                    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
                    [ZGUtility showAlertWithText:[getInfoResponseObject objectForKey:@"message"] parentView:nil];
                }
                
                
            } getInfoFailure:^(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError) {
                
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
                
            }];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    [self.window makeKeyAndVisible];
    
    
    [WXApi registerApp:@"wx0fa13deb7fc51d43"];
    
    [BPush setupChannel:launchOptions]; // 必须
    [BPush setDelegate:self];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }

//    [[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%@",launchOptions] delegate:nil cancelButtonTitle:@"quxiao" otherButtonTitles:@"queding", nil] show ];
    return YES;
}

#pragma  mark - updatePaneCancelBtnClicked
- (void)updatePaneCancelBtnClicked:(UIButton *)button
{
    alertView.hidden = YES;
}

#pragma  mark - updateBtnClicked
- (void)updatePaneUpdateBtnClicked:(UIButton *)button
{
    alertView.hidden = YES;
    
    if(entity)
    {
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:entity.url]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:entity.url]];
        }
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    NSString * key = [identifierComponents lastObject];
    if([key isEqualToString:@"MMDrawer"]){
        return self.window.rootViewController;
    }
    else if ([key isEqualToString:@"CenterNavigationController"]) {
        return ((MMDrawerController *)self.window.rootViewController).centerViewController;
    }
    else if ([key isEqualToString:@"RightSideNavigationController"]) {
        return ((MMDrawerController *)self.window.rootViewController).rightDrawerViewController;
    }
    else if ([key isEqualToString:@"LeftSideNavigationController"]) {
        return ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
    }
    return nil;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [BPush registerDeviceToken:deviceToken]; // 必须
    [BPush bindChannel]; // 必须。可以在其它时机调用，只有在该方法返回（通过onMethod:response:回调）绑定成功时，app才能接收到Push消息。一个app绑定成功至少一次即可（如果access token变更请重新绑定）。
}

- (void) application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [BPush handleNotification:userInfo]; // 可选
    [ZGUtility showAlertWithText:[[userInfo objectForKey:@"aps"] objectForKey:@"alert" ] parentView:nil];
//    [ZGUtility showAlertWithText:[[data objectForKey:@"aps"] objectForKey:@"alert" ] parentView:nil];
}

- (void) onMethod:(NSString*)method response:(NSDictionary*)data
{
    NSLog(@"On method:%@", method);
    NSLog(@"data:%@", [data description]);

    
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    if ([BPushRequestMethod_Bind isEqualToString:method]) {
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        //NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        
        if (returnCode == BPushErrorCode_Success) {
            NSLog(@"BPushErrorCode_Success");
        }
    } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        NSLog(@"%d",returnCode);
    }

}

#pragma  mark - WXApiDelegate

-(void) onReq:(BaseReq*)req
{
}

-(void) onResp:(BaseResp*)resp
{
}


@end
