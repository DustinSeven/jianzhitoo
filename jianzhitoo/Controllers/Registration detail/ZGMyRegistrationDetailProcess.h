//
//  ZGMyRegistrationDetailProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGMyRegistrationDetailProcess : NSObject

+ (id)shareInstance;

- (void)getMyRegistrationDetailWithParam:(NSDictionary *)param
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
