//
//  ZGDepartmentEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/17/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGDepartmentEntity.h"

@implementation ZGDepartmentEntity

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
        if(![[dict objectForKey:@"departmentid"] isKindOfClass:[NSNull class]])
            self.identity = [[dict objectForKey:@"departmentid"]longValue];
        if(![[dict objectForKey:@"departmentname"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"departmentname"] isEqualToString:@""])
            self.name = [dict objectForKey:@"departmentname"];
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
