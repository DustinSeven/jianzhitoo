//
//  ZGGuideInterfaceProcess.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "ZGHttpClient.h"

@interface ZGGuideInterfaceProcess : NSObject
+ (id)shareInstance;

- (void)listWithParameters:(NSDictionary *)parameters
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
