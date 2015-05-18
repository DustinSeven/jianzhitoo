//
//  ZGMoneyDetailProcess.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/4/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGMoneyDetailProcess : NSObject

+ (id)shareInstance;

- (void)getMoneyDetailListWithParam:(NSDictionary *)param
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
