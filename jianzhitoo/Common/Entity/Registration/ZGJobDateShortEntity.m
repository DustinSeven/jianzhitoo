//
//  ZGJobDateShortEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/26/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGJobDateShortEntity.h"

@implementation ZGJobDateShortEntity

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
        if(![[dict objectForKey:@"full"] isKindOfClass:[NSNull class]])
            self.full = [[dict objectForKey:@"full"] intValue];
        if(![[dict objectForKey:@"userenroll"] isKindOfClass:[NSNull class]])
            self.userEnRoll = [[dict objectForKey:@"userenroll"]intValue];
        if(![[dict objectForKey:@"workdate"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"workdate"] isEqualToString:@""])
            self.workDate = [dict objectForKey:@"workdate"];
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
