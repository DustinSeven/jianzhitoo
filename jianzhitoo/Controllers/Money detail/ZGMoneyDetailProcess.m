
//
//  ZGMoneyDetailProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/4/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMoneyDetailProcess.h"

@implementation ZGMoneyDetailProcess

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
    static ZGMoneyDetailProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGMoneyDetailProcess alloc] init];
    });
    
    return process;
}

- (void)getMoneyDetailListWithParam:(NSDictionary *)param
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    
    [[ZGHttpClient shareClient] POST:GET_MONEY_DETAIL_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                             }];
}

@end
