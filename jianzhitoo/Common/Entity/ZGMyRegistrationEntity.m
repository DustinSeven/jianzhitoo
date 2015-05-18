//
//  ZGMyRegistrationEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/19/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMyRegistrationEntity.h"

@implementation ZGMyRegistrationEntity

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
        if(![[dict objectForKey:@"amount"] isKindOfClass:[NSNull class]])
            self.money = [[dict objectForKey:@"amount"]longValue];
        if(![[dict objectForKey:@"address"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"address"] isEqualToString:@""])
            self.address = [dict objectForKey:@"address"];
        if(![[dict objectForKey:@"parttimejob_logo"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"parttimejob_logo"] isEqualToString:@""])
            self.jobImg = [dict objectForKey:@"parttimejob_logo"];
        if(![[dict objectForKey:@"recruitment_tittle"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"recruitment_tittle"] isEqualToString:@""])
            self.jobTitle = [dict objectForKey:@"recruitment_tittle"];
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
