//
//  ZGSchoolmateProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGSchoolmateProcess : NSObject

+ (id)shareInstance;
- (void)getSchoolmateWithParam:(NSDictionary *)param
                    parentView:(UIView *)parentView
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getSchoolmateWithParam:(NSDictionary *)param
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
