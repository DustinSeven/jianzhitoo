//
//  ZGContactEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/9.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGContactEntity.h"

@implementation ZGContactEntity

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
        if(![[dict objectForKey:@"names"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"names"] isEqualToString:@""])
            self.name = [dict objectForKey:@"names"];
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
