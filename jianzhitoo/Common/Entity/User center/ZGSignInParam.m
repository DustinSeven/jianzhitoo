//
//  ZGSignInParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSignInParam.h"

@implementation ZGSignInParam

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary *)dict
{
    self= [super initWithAttributes:dict];
    if(self)
    {
    }
    return self;
}

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [super getDictionary];
    if(dict)
    {
        [dict setObject:self.mobile forKey:@"mobile"];
        [dict setObject:[ZGUtility sha1Algorithm:self.pwd]forKey:@"pwd"];
        [dict setObject:[NSNumber numberWithLong:self.jobId] forKey:@"parttimeid"];
        [dict setObject:self.checkCode forKey:@"checkkey"];
    }
    return dict;
}


@end
