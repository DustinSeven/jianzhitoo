//
//  ZGMyRegistrationDetailParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMyRegistrationDetailParam.h"

@implementation ZGMyRegistrationDetailParam

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
        [dict setObject:[NSNumber numberWithLong: self.jobId ] forKey:@"parttimeid"];
        [dict setObject:[NSNumber numberWithLong:self.userId] forKey:@"userid"];
        [dict setObject:self.mobile forKey:@"mobile"];
        [dict setObject:self.password forKey:@"pwd"];
    }
    return dict;
}


@end
