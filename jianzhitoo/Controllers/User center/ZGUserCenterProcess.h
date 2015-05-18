//
//  ZGUserCenterProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/1/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"

@interface ZGUserCenterProcess : ZGBaseEntity

+ (id)shareInstance;

- (void)getTotalMoneyInfoWithParam:(NSDictionary *)param
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getEnableMoneyInfoWithParam:(NSDictionary *)param
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)signInWithParam:(NSDictionary *)param
             parentView:(UIView *)view
                   text:(NSString *)text
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
