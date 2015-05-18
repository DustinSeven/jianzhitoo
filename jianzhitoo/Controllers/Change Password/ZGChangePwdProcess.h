//
//  ZGChangePwdProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/24/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGChangePwdProcess : NSObject

+ (id)shareInstance;

- (void)updatePwdWithParam:(NSDictionary *)param
                        parentView:(UIView *)parentView
                      progressText:(NSString *)text
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
