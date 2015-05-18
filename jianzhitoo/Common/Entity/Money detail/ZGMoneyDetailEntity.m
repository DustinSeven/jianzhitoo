//
//  ZGMoneyDetailEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/4/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMoneyDetailEntity.h"

@implementation ZGMoneyDetailEntity

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
        if(![[dict objectForKey:@"amount"] isKindOfClass:[NSNull class]])
            self.money = [[dict objectForKey:@"amount"]doubleValue];
        if(![[dict objectForKey:@"time"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"time"] isEqualToString:@""])
            self.time = [dict objectForKey:@"time"];
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
