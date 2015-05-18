//
//  ZGMainPageProcess.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMainPageProcess.h"

@implementation ZGMainPageProcess

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
    static ZGMainPageProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGMainPageProcess alloc] init];
        
    });
    
    return process;
}

- (void)getAllJobTypeWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [[ZGHttpClient shareClient] POST:GET_ALL_JOB_TYPE_URL
                          parameters:nil
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                             }];
}


- (void)getAreaWithParam:(NSDictionary *)param
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    [[ZGHttpClient shareClient] POST:GET_AREA_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                             }];
    
}

- (void)getJobWithParam:(NSDictionary *)param
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    [[ZGHttpClient shareClient] POST:GET_JOB_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                             }];
    
}

- (void)getAllJobTypeWithParam:(NSDictionary *)param
                     areaParam:(NSDictionary *)aareaParam
                   typeSuccess:(void (^)(AFHTTPRequestOperation *operation1, id responseObject1))typeSuccess
                   typeFailure:(void (^)(AFHTTPRequestOperation *operation1, NSError *error1))typeFailure
                   areaSuccess:(void (^)(AFHTTPRequestOperation *operation2, id responseObject2))areaSuccess
                   areaFailure:(void (^)(AFHTTPRequestOperation *operation2, NSError *error2))areaFailure
                    jobSuccess:(void (^)(AFHTTPRequestOperation *operation3, id responseObject3))jobSuccess
                    jobFailure:(void (^)(AFHTTPRequestOperation *operation3, NSError *error3))jobFailure
{
    [[ZGHttpClient shareClient] POST:GET_ALL_JOB_TYPE_URL
                          parameters:[[[ZGBaseEntity alloc] init] getDictionary]
                             success:^(AFHTTPRequestOperation *operation1, id responseObject1) {
                                 
                                 [[ZGHttpClient shareClient] POST:GET_AREA_URL
                                                       parameters:aareaParam
                                                          success:^(AFHTTPRequestOperation *operation2, id responseObject2) {
                                                              
                                                              [[ZGHttpClient shareClient] POST:GET_JOB_URL
                                                                                    parameters:param
                                                                                       success:^(AFHTTPRequestOperation *operation3, id responseObject3) {
                                                                                           
                                                                                           typeSuccess(operation1,responseObject1);
                                                                                           areaSuccess(operation2,responseObject2);
                                                                                           jobSuccess(operation3,responseObject3);
                                                                                           
                                                                                       }
                                                                                       failure:^(AFHTTPRequestOperation *operation3, NSError *error3) {
                                                                                           jobFailure(operation3,error3);
                                                                                       }];
                                                          }
                                                          failure:^(AFHTTPRequestOperation *operation2, NSError *error2) {
                                                              areaFailure(operation2,error2);
                                                          }];
                                 
                             }
                             failure:^(AFHTTPRequestOperation *operation1, NSError *error1) {
                                 typeFailure(operation1,error1);
                             }];
}


@end
