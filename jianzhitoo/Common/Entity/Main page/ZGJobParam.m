//
//  ZGJobParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/21/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGJobParam.h"

@implementation ZGJobParam

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
        if(self.sex)
            [dict setObject:[NSNumber numberWithInt:self.sex] forKey:@"psex"];
        if(self.typeId)
            [dict setObject:self.typeId forKey:@"ptype"];
        if(self.areaId)
            [dict setObject:[NSNumber numberWithLong:self.areaId] forKey:@"areaid"];
        if(self.pageNum)
            [dict setObject:[NSNumber numberWithInt:self.pageNum] forKey:@"page"];
        if(self.pageSize)
            [dict setObject:[NSNumber numberWithInt:self.pageSize] forKey:@"pagesize"];
        if(self.keyword)
            [dict setObject:self.keyword forKey:@"keyword"];
    }
    return dict;
}


@end
