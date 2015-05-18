//
//  ZGWithdrawalDetailProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/26/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGWithdrawalDetailProcess.h"

@implementation ZGWithdrawalDetailProcess

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
    static ZGWithdrawalDetailProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGWithdrawalDetailProcess alloc] init];
    });
    
    return process;
}

- (void)withdrawalToAlipayWithParam:(NSDictionary *)param
                         parentView:(UIView *)parentView
                       progressText:(NSString *)text
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[ZGHttpClient shareClient] POST:WITHDRAWAL_TO_ALIPAY_URL
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


- (void)withdrawalToBankWithParam:(NSDictionary *)param
                         parentView:(UIView *)parentView
                       progressText:(NSString *)text
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[ZGHttpClient shareClient] POST:WITHDRAWAL_TO_BANK_URL
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
