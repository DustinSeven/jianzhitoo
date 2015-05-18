//
//  ZGSchoolmateProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSchoolmateProcess.h"

@implementation ZGSchoolmateProcess

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
    static ZGSchoolmateProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGSchoolmateProcess alloc] init];
    });
    
    return process;
}

- (void)getSchoolmateWithParam:(NSDictionary *)param
                    parentView:(UIView *)parentView
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    ZGActivityIndicator *progress =[ZGUtility showProgressWithParentView:parentView
                                                              background:nil];
    [[ZGHttpClient shareClient] POST:GET_SCHOOLMATE_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 [progress stopAnimation];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 [progress stopAnimation];
                             }];
    
}


- (void)getSchoolmateWithParam:(NSDictionary *)param
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [[ZGHttpClient shareClient] POST:GET_SCHOOLMATE_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                             }];
    
}
@end
