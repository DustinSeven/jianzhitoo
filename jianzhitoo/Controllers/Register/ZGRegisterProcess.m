//
//  ZGRegisterProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegisterProcess.h"

@implementation ZGRegisterProcess

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
    static ZGRegisterProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGRegisterProcess alloc] init];
    });
    
    return process;
}

- (void)registerWithParam:(NSDictionary *)param
            parentView:(UIView *)parentView
          progressText:(NSString *)text
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    
    [[ZGHttpClient shareClient] POST:REGISTER_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 [ZGUtility hideProgress:progress];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 [ZGUtility hideProgress:progress];
                             }];
}

- (void)getVeriCodeWithParam:(NSDictionary *)param
                  parentView:(UIView *)parentView
                progressText:(NSString *)text
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    
    [[ZGHttpClient shareClient] POST:VERI_CODE_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 [ZGUtility hideProgress:progress];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 [ZGUtility hideProgress:progress];
                             }];
}



@end
