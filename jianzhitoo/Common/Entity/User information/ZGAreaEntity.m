//
//  ZGAreaEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/17/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAreaEntity.h"

@implementation ZGAreaEntity

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
        if(![[dict objectForKey:@"areaid"] isKindOfClass:[NSNull class]])
            self.identity = [[dict objectForKey:@"areaid"]longValue];
        if(![[dict objectForKey:@"areaname"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"areaname"] isEqualToString:@""])
            self.name = [dict objectForKey:@"areaname"];
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
