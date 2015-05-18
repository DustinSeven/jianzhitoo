//
//  ZGRegistrationProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/26/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGRegistrationProcess : NSObject

+ (id)shareInstance;

- (void)getShortDateWithParam:(NSDictionary *)param
                   parentView:(UIView *)parentView
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getLongDateWithParam:(NSDictionary *)param
                   parentView:(UIView *)parentView
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)registrationShortWithParam:(NSDictionary *)param
                        parentView:(UIView *)parentView
                              text:(NSString *)text
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)registrationLongWithParam:(NSDictionary *)param
                        parentView:(UIView *)parentView
                              text:(NSString *)text
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
