//
//  ZGCityEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/17/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGCityEntity.h"

@implementation ZGCityEntity

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
        if(![[dict objectForKey:@"cityid"] isKindOfClass:[NSNull class]])
            self.identity = [[dict objectForKey:@"cityid"]longValue];
        if(![[dict objectForKey:@"city"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"city"] isEqualToString:@""])
            self.name = [dict objectForKey:@"city"];
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
