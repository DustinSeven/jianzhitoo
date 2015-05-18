//
//  ZGEnableEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/1/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGEnableMoneyEntity.h"

@implementation ZGEnableMoneyEntity

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
        if(![[dict objectForKey:@"enablemoney"] isKindOfClass:[NSNull class]])
            self.money = [[dict objectForKey:@"enablemoney"]intValue];
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
