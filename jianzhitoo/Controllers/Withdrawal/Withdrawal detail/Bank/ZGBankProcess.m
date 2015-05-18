//
//  ZGBankProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBankProcess.h"

@implementation ZGBankProcess

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
    static ZGBankProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGBankProcess alloc] init];
    });
    
    return process;
}

- (void)getAllBankWithParentView:(UIView *)parentView
                    progressText:(NSString *)text
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[ZGHttpClient shareClient] POST:GET_ALL_BANK_URL
                          parameters:nil
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
