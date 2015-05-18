//
//  ZGChangePwdProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/24/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGChangePwdProcess.h"

@implementation ZGChangePwdProcess

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
    static ZGChangePwdProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGChangePwdProcess alloc] init];
    });
    
    return process;
}

- (void)updatePwdWithParam:(NSDictionary *)param
                        parentView:(UIView *)parentView
                      progressText:(NSString *)text
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                              background:nil];
    
    [[ZGHttpClient shareClient] POST:UPDATE_PASSWORD_URL
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
