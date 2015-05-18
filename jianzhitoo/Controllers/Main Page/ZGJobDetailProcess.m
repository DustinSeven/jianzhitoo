//
//  ZGMainPageProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/16/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGJobDetailProcess.h"

@implementation ZGJobDetailProcess

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
    static ZGJobDetailProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGJobDetailProcess alloc] init];
    });
    
    return process;
}

- (void)getJobDetailWithJobParam:(NSDictionary *)param
                 schoolmateParam:(NSDictionary *)schoolmateParam
                   parentView:(UIView *)parentView
                         jobSuccess:(void (^)(AFHTTPRequestOperation *jobOperation, id jobResponseObject))jobSuccess
                         jobFailure:(void (^)(AFHTTPRequestOperation *jobOperation, NSError *jobError))jobFailure
                         schoolmateSuccess:(void (^)(AFHTTPRequestOperation *schoolmateOperation, id schoolmateResponseObject))schoolmateSuccess
                         schoolmateFailure:(void (^)(AFHTTPRequestOperation *schoolmateOperation, NSError *schoolmateError))schoolmateFailure
{
    ZGActivityIndicator *progress =[ZGUtility showProgressWithParentView:parentView
                                                              background:nil];
    [[ZGHttpClient shareClient] POST:GET_JOB_DETAIL_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *jobOperation, id jobResponseObject) {
                                 
                                 if(schoolmateParam)
                                 {
                                     [[ZGHttpClient shareClient] POST:GET_SCHOOLMATE_URL
                                                           parameters:schoolmateParam
                                                              success:^(AFHTTPRequestOperation *schoolmateOperation, id schoolmateResponseObject) {
                                                                  
                                                                  jobSuccess(jobOperation,jobResponseObject);
                                                                  schoolmateSuccess(schoolmateOperation,schoolmateResponseObject);
                                                                  [progress stopAnimation];
                                                              }
                                                              failure:^(AFHTTPRequestOperation *schoolmateOperation, NSError *schoolmateError) {
                                                                  schoolmateFailure(schoolmateOperation,schoolmateError);
                                                                  [progress stopAnimation];
                                                              }];
                                 }
                                 else
                                 {
                                     jobSuccess(jobOperation,jobResponseObject);
                                     schoolmateSuccess(nil,nil);
                                     [progress stopAnimation];

                                 }
                                 
                             }
                             failure:^(AFHTTPRequestOperation *jobOperation, NSError *jobError) {
                                 jobFailure(jobOperation,jobError);
                                 
                                 [progress stopAnimation];
                             }];
}





@end
