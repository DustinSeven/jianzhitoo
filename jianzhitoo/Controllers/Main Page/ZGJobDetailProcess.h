//
//  ZGMainPageProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/16/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGJobDetailProcess : NSObject

+ (id)shareInstance;

- (void)getJobDetailWithJobParam:(NSDictionary *)param
                 schoolmateParam:(NSDictionary *)schoolmateParam
                      parentView:(UIView *)parentView
                      jobSuccess:(void (^)(AFHTTPRequestOperation *jobOperation, id jobResponseObject))jobSuccess
                      jobFailure:(void (^)(AFHTTPRequestOperation *jobOperation, NSError *jobError))jobFailure
               schoolmateSuccess:(void (^)(AFHTTPRequestOperation *schoolmateOperation, id schoolmateResponseObject))schoolmateSuccess
               schoolmateFailure:(void (^)(AFHTTPRequestOperation *schoolmateOperation, NSError *schoolmateError))schoolmateFailure;

@end
