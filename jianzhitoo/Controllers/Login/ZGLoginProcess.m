//
//  ZGLoginProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGLoginProcess.h"
#import "ZGUpdateInfoParam.h"

@implementation ZGLoginProcess

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    static ZGLoginProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGLoginProcess alloc] init];
    });
    
    return process;
}

- (void)loginWithParam:(NSDictionary *)param
            parentView:(UIView *)parentView
          progressText:(NSString *)text
          loginSuccess:(void (^)(AFHTTPRequestOperation *loginOperation, id loginResponseObject))loginSuccess
          loginFailure:(void (^)(AFHTTPRequestOperation *loginOperation, NSError *LoginError))loginFailure
        getInfoSuccess:(void (^)(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject))getInfoSuccess
        getInfoFailure:(void (^)(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError))getInfoFailure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    
    [[ZGHttpClient shareClient] POST:LOGIN_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *loginOperation, id loginResponseObject) {
                                 
                                 if([[loginResponseObject objectForKey:@"code"]intValue] == 200)
                                 {
                                     NSArray *dic = [loginResponseObject objectForKey:@"data"];
                                     [param setValue:[[dic objectAtIndex:0]objectForKey:@"id"] forKey:@"userid"];
                                 }
                                 
                                 [[ZGHttpClient shareClient] POST:GET_USER_INFO_URL
                                                       parameters:param
                                                          success:^(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject) {
                                                              
                                                              loginSuccess(loginOperation,loginResponseObject);
                                                              getInfoSuccess(getInfoOperation,getInfoResponseObject);
                                                              [ZGUtility hideProgress:progress];
                                                              
                                                          }
                                                          failure:^(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError) {
                                                              
                                                              getInfoFailure(getInfoOperation,getInfoError);
                                                              [ZGUtility hideProgress:progress];
                                                              
                                                          }];
                                 
                             }
                             failure:^(AFHTTPRequestOperation *loginOperation, NSError *LoginError) {
                                 loginFailure(loginOperation,LoginError);
                                 
                                 [ZGUtility hideProgress:progress];
                             }];
}

- (void)loginWithParam:(NSDictionary *)param
          loginSuccess:(void (^)(AFHTTPRequestOperation *loginOperation, id loginResponseObject))loginSuccess
          loginFailure:(void (^)(AFHTTPRequestOperation *loginOperation, NSError *LoginError))loginFailure
        getInfoSuccess:(void (^)(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject))getInfoSuccess
        getInfoFailure:(void (^)(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError))getInfoFailure
{
    [[ZGHttpClient shareClient] POST:LOGIN_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *loginOperation, id loginResponseObject) {
                                 
                                 if([[loginResponseObject objectForKey:@"code"]intValue] == 200)
                                 {
                                     NSArray *dic = [loginResponseObject objectForKey:@"data"];
                                     [param setValue:[[dic objectAtIndex:0]objectForKey:@"id"] forKey:@"userid"];
                                 }
                                 
                                 [[ZGHttpClient shareClient] POST:GET_USER_INFO_URL
                                                       parameters:param
                                                          success:^(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject) {
                                                              
                                                              loginSuccess(loginOperation,loginResponseObject);
                                                              getInfoSuccess(getInfoOperation,getInfoResponseObject);
                                                              
                                                          }
                                                          failure:^(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError) {
                                                              
                                                              getInfoFailure(getInfoOperation,getInfoError);
                                                              
                                                          }];
                                 
                             }
                             failure:^(AFHTTPRequestOperation *loginOperation, NSError *LoginError) {
                                 loginFailure(loginOperation,LoginError);
                                 
                             }];
}

- (void)updateAPPInfoWithParam:(NSDictionary *)param
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    [[ZGHttpClient shareClient] POST:UPDATE_APP_INFO_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                             }];
}

- (void)getUpdateInfoWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    ZGUpdateInfoParam *param = [[ZGUpdateInfoParam alloc]init];
    [[ZGHttpClient shareClient] POST:GET_UPDATE_INFO_URL
                          parameters:[param getDictionary]
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                             }];
}


- (void)getUpdateInfoWithParentView:(UIView *)view
                               text:(NSString *)text
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:view
                                                              text:text
                                                        background:nil];
    ZGUpdateInfoParam *param = [[ZGUpdateInfoParam alloc]init];
    NSDictionary *dic = [param getDictionary];
    [[ZGHttpClient shareClient] POST:GET_UPDATE_INFO_URL
                          parameters:dic
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 [ZGUtility hideProgress:progress];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 [ZGUtility hideProgress:progress];
                             }];
}


@end
