//
//  ZGProvinceEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/16/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGProvinceEntity.h"

@implementation ZGProvinceEntity

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
        if(![[dict objectForKey:@"pid"] isKindOfClass:[NSNull class]])
            self.pid = [[dict objectForKey:@"pid"] longValue];
        if(![[dict objectForKey:@"provinceid"] isKindOfClass:[NSNull class]])
            self.identity = [[dict objectForKey:@"provinceid"]longValue];
        if(![[dict objectForKey:@"pname"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"pname"] isEqualToString:@""])
            self.name = [dict objectForKey:@"pname"];
    }
    return self;
}

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [super getDictionary];
    if(dict)
    {
        
    }
    return dict;
}


@end
