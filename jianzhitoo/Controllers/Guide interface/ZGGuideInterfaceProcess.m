//
//  ZGGuideInterfaceProcess.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGGuideInterfaceProcess.h"

@implementation ZGGuideInterfaceProcess

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
    static ZGGuideInterfaceProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGGuideInterfaceProcess alloc] init];
        
    });
    
    return process;
}

- (void)listWithParameters:(NSDictionary *)parameters
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    [[ZGHttpClient shareClient] POST:@"api/jztv1/test"
                         parameters:parameters
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                success(operation,responseObject);
                            }
                            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(operation,error);
                            }];
    
}


@end
