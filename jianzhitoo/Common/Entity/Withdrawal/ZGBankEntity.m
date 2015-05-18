//
//  ZGBankEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBankEntity.h"

@implementation ZGBankEntity

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
        if(![[dict objectForKey:@"bankcode"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"bankcode"] isEqualToString:@""])
            self.bankCode = [dict objectForKey:@"bankcode"];
        if(![[dict objectForKey:@"bankname"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"bankname"] isEqualToString:@""])
            self.bankName = [dict objectForKey:@"bankname"];
        if(![[dict objectForKey:@"icon"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"icon"] isEqualToString:@""])
            self.bankIcon = [dict objectForKey:@"icon"];
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
