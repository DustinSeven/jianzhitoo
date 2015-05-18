//
//  ZGMainPageProcess.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGMainPageProcess : NSObject




+ (id)shareInstance;

- (void)getAllJobTypeWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getAreaWithParam:(NSDictionary *)param
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getJobWithParam:(NSDictionary *)param
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getAllJobTypeWithParam:(NSDictionary *)param
                     areaParam:(NSDictionary *)aareaParam
                   typeSuccess:(void (^)(AFHTTPRequestOperation *operation1, id responseObject1))typeSuccess
                   typeFailure:(void (^)(AFHTTPRequestOperation *operation1, NSError *error1))typeFailure
                   areaSuccess:(void (^)(AFHTTPRequestOperation *operation2, id responseObject2))areaSuccess
                   areaFailure:(void (^)(AFHTTPRequestOperation *operation2, NSError *error2))areaFailure
                    jobSuccess:(void (^)(AFHTTPRequestOperation *operation3, id responseObject3))jobSuccess
                    jobFailure:(void (^)(AFHTTPRequestOperation *operation3, NSError *error3))jobFailure;

@end
