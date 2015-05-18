//
//  ZGLoginProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGLoginProcess : NSObject

+ (id)shareInstance;

- (void)loginWithParam:(NSDictionary *)param
            parentView:(UIView *)parentView
          progressText:(NSString *)text
          loginSuccess:(void (^)(AFHTTPRequestOperation *loginOperation, id loginResponseObject))loginSuccess
          loginFailure:(void (^)(AFHTTPRequestOperation *loginOperation, NSError *LoginError))loginFailure
        getInfoSuccess:(void (^)(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject))getInfoSuccess
        getInfoFailure:(void (^)(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError))getInfoFailure;

- (void)loginWithParam:(NSDictionary *)param
          loginSuccess:(void (^)(AFHTTPRequestOperation *loginOperation, id loginResponseObject))loginSuccess
          loginFailure:(void (^)(AFHTTPRequestOperation *loginOperation, NSError *LoginError))loginFailure
        getInfoSuccess:(void (^)(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject))getInfoSuccess
        getInfoFailure:(void (^)(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError))getInfoFailure;

- (void)updateAPPInfoWithParam:(NSDictionary *)param
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getUpdateInfoWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getUpdateInfoWithParentView:(UIView *)view
                               text:(NSString *)text
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
