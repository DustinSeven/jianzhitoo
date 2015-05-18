//
//  ZGMyRegistrationDetailProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMyRegistrationDetailProcess.h"

@implementation ZGMyRegistrationDetailProcess

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
    static ZGMyRegistrationDetailProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGMyRegistrationDetailProcess alloc] init];
    });
    
    return process;
}

- (void)getMyRegistrationDetailWithParam:(NSDictionary *)param
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [[ZGHttpClient shareClient] POST:MY_REGISTRATION_DETAIL_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                             }];
}


@end
