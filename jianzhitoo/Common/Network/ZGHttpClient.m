//
//  ZGHttpClient.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGHttpClient.h"

@implementation ZGHttpClient

+ (ZGHttpClient *)shareClient
{
    static ZGHttpClient *_client = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _client = [[ZGHttpClient alloc] initWithBaseURL:[NSURL URLWithString:APP_BASE_URL]];
    });
    
    return _client;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        [self.requestSerializer setValue:@"application/json"
                      forHTTPHeaderField:@"Content-Type"];
        
        [self.requestSerializer setValue:@"no-cache"
                      forHTTPHeaderField:@"Cache-Control"];
        
       
    }
    
    return self;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *post = @"";
    NSDictionary *dic = (NSDictionary *)parameters;
    for(int i = 0; i < dic.allKeys.count ; ++i)
    {
        post = [post stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",[dic.allKeys objectAtIndex:i],[dic.allValues objectAtIndex:i]]];
    }
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.baseURL,URLString]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    
    
    return operation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
//    self.responseSerializer = [AFCompoundResponseSerializer serializer];
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}


- (void)cancleLastOperation
{
    if(self.operationQueue.operationCount)
    {
        long int  index = [ZGHttpClient shareClient].operationQueue.operations.count;
        AFHTTPRequestOperation *operation = [[ZGHttpClient shareClient].operationQueue.operations objectAtIndex:index - 1];
        [operation cancel];
    }
}

@end
