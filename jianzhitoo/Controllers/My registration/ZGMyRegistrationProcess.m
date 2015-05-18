//
//  ZGMyRegistrationProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/19/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMyRegistrationProcess.h"

@implementation ZGMyRegistrationProcess

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
    static ZGMyRegistrationProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGMyRegistrationProcess alloc] init];
    });
    
    return process;
}

- (void)getMyRegistrationWithParam:(NSDictionary *)param
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [[ZGHttpClient shareClient] POST:GET_MY_REGISTRATION_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                             }];
}


@end
