//
//  ZGBankProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGBankProcess : NSObject

+ (id)shareInstance;

- (void)getAllBankWithParentView:(UIView *)parentView
                       progressText:(NSString *)text
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
