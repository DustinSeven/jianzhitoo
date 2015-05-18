//
//  ZGChangeUserInfoProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/16/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGChangeUserInfoProcess : NSObject

+ (id)shareInstance;

- (void)getAllProvinceWithParentView:(UIView *)parentView
                        progressText:(NSString *)text
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getCityWithParam:(NSDictionary *)param
              ParentView:(UIView *)parentView
            progressText:(NSString *)text
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getAreaWithParam:(NSDictionary *)param
              ParentView:(UIView *)parentView
            progressText:(NSString *)text
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)updateUserInfoWithParam:(NSDictionary *)param
              ParentView:(UIView *)parentView
            progressText:(NSString *)text
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getCollegeWithParam:(NSDictionary *)param
                 ParentView:(UIView *)parentView
               progressText:(NSString *)text
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getDepartmentWithParam:(NSDictionary *)param
                 ParentView:(UIView *)parentView
               progressText:(NSString *)text
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)uploadUserImgWithParam:(NSDictionary *)param
                    ParentView:(UIView *)parentView
                  progressText:(NSString *)text
                           img:(UIImage *)img
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
