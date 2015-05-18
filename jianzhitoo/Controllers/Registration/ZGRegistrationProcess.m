//
//  ZGRegistrationProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/26/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegistrationProcess.h"

@implementation ZGRegistrationProcess

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
    static ZGRegistrationProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGRegistrationProcess alloc] init];
    });
    
    return process;
}

- (void)getShortDateWithParam:(NSDictionary *)param
                   parentView:(UIView *)parentView
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    ZGActivityIndicator *progress =[ZGUtility showProgressWithParentView:parentView
                                                              background:nil];
    
    [[ZGHttpClient shareClient] POST:GET_SHORT_TERM_DATE_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 progress.hidden = YES;
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 progress.hidden = YES;
                             }];
}

- (void)getLongDateWithParam:(NSDictionary *)param
                   parentView:(UIView *)parentView
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    ZGActivityIndicator *progress =[ZGUtility showProgressWithParentView:parentView
                                                              background:nil];
    
    [[ZGHttpClient shareClient] POST:GET_LONG_TERM_DATE_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 progress.hidden = YES;
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 progress.hidden = YES;
                             }];
}

- (void)registrationShortWithParam:(NSDictionary *)param
                        parentView:(UIView *)parentView
                              text:(NSString *)text
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    
    [[ZGHttpClient shareClient] POST:REGISTRATION_SHORT_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 [ZGUtility hideProgress:progress];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 [ZGUtility hideProgress:progress];
                             }];
}

- (void)registrationLongWithParam:(NSDictionary *)param
                        parentView:(UIView *)parentView
                              text:(NSString *)text
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    
    [[ZGHttpClient shareClient] POST:REGISTRATION_LONG_URL
                          parameters:param
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
