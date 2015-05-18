//
//  ZGDepartmentParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/17/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGDepartmentParam.h"

@implementation ZGDepartmentParam

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
        [dict setObject:[NSNumber numberWithLong: self.collegeId ] forKey:@"collegeid"];
    }
    return dict;
}

@end
