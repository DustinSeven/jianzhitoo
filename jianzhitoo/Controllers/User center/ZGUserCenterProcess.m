//
//  ZGUserCenterProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/1/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUserCenterProcess.h"

@implementation ZGUserCenterProcess

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
    static ZGUserCenterProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGUserCenterProcess alloc] init];
        
    });
    
    return process;
}

- (void)getTotalMoneyInfoWithParam:(NSDictionary *)param
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [[ZGHttpClient shareClient] POST:GET_TOTAL_MONEY_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                             }];
}


- (void)getEnableMoneyInfoWithParam:(NSDictionary *)param
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [[ZGHttpClient shareClient] POST:GET_ENABLE_MONEY_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                             }];
}

- (void)signInWithParam:(NSDictionary *)param
             parentView:(UIView *)view
                   text:(NSString *)text
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *process = [ZGUtility showProgressWithParentView:view text:text background:nil];
    
    [[ZGHttpClient shareClient] POST:SIGN_IN_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 [ZGUtility hideProgress:process];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 [ZGUtility hideProgress:process];
                             }];
}


@end
