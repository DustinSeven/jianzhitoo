//
//  ZGJobDateLongEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/27/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGJobDateLongEntity.h"

@implementation ZGJobDateLongEntity

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
        if(![[dict objectForKey:@"code"] isKindOfClass:[NSNull class]])
            self.code = [[dict objectForKey:@"code"] intValue];
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
