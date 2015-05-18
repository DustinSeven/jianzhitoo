//
//  ZGRegistrationShortParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/27/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegistrationShortParam.h"

@implementation ZGRegistrationShortParam

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
        [dict setObject:[NSNumber numberWithLong:self.userId] forKey:@"userid"];
        [dict setObject:[NSNumber numberWithLong:self.jobId] forKey:@"parttimeid"];
        [dict setObject:self.mobile forKey:@"mobile"];
        [dict setObject:self.password forKey:@"pwd"];
        [dict setObject:self.workDate forKey:@"workdate"];
    }
    return dict;
}


@end
