//
//  ZGRegisterParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegisterParam.h"

@implementation ZGRegisterParam

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
        self.mobile = [dict objectForKey:@"mobile"];
        self.pwd = [dict objectForKey:@"pwd"];
        self.veriCode = [dict objectForKey:@"regcode"];
        self.veriCodeTime = [[dict objectForKey:@"regcodetime"]longValue];
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
        [dict setObject:self.veriCode forKey:@"regcode"];
        [dict setObject:[NSNumber numberWithLong: self.veriCodeTime ] forKey:@"regcodetime"];
    }
    return dict;
}


@end
