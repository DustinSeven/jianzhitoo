//
//  ZGMyRegistrationDetailEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMyRegistrationDetailEntity.h"

@implementation ZGMyRegistrationDetailEntity

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
        if(![[dict objectForKey:@"workdate"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"workdate"] isEqualToString:@""])
            self.workDate = [dict objectForKey:@"workdate"];
        if(![[dict objectForKey:@"message"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"message"] isEqualToString:@""])
            self.message = [dict objectForKey:@"message"];
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
