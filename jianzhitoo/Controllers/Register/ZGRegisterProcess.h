//
//  ZGRegisterProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "ZGHttpClient.h"
#import "ZGUtility.h"

@interface ZGRegisterProcess : NSObject

+ (id)shareInstance;

- (void)registerWithParam:(NSDictionary *)param
               parentView:(UIView *)parentView
             progressText:(NSString *)text
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getVeriCodeWithParam:(NSDictionary *)param
               parentView:(UIView *)parentView
             progressText:(NSString *)text
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
