//
//  ZGCollegeEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/17/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGCollegeEntity.h"

@implementation ZGCollegeEntity

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
        if(![[dict objectForKey:@"coid"] isKindOfClass:[NSNull class]])
            self.identity = [[dict objectForKey:@"coid"]longValue];
        if(![[dict objectForKey:@"name"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"name"] isEqualToString:@""])
            self.name = [dict objectForKey:@"name"];
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
