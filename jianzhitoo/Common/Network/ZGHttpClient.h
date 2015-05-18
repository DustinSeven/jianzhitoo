//
//  ZGHttpClient.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"



@interface ZGHttpClient : AFHTTPRequestOperationManager

+ (ZGHttpClient *)shareClient;

- (void)cancleLastOperation;

@end
