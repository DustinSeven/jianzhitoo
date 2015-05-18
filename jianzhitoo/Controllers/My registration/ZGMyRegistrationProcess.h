//
//  ZGMyRegistrationProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/19/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGMyRegistrationProcess : NSObject

+ (id)shareInstance;

- (void)getMyRegistrationWithParam:(NSDictionary *)param
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
