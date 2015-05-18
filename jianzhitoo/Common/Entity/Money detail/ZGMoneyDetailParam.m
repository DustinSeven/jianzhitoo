//
//  ZGMoneyDetailParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/4/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMoneyDetailParam.h"

@implementation ZGMoneyDetailParam

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
        [dict setObject:[NSNumber numberWithInt:self.page] forKey:@"page"];
        [dict setObject:[NSNumber numberWithInt:self.pageSize] forKey:@"pagesize"];
        [dict setObject:self.mobile forKey:@"mobile"];
        [dict setObject:[ZGUtility sha1Algorithm:self.pwd] forKey:@"pwd"];
    }
    return dict;
}


@end
