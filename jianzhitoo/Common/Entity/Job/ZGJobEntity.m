//
//  ZGJobEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/19/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGJobEntity.h"

@implementation ZGJobEntity

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
        if(![[dict objectForKey:@"parttimeid"] isKindOfClass:[NSNull class]])
            self.identity = [[dict objectForKey:@"parttimeid"] integerValue];
        if(![[dict objectForKey:@"parttimeid"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"parttimeid"] isEqualToString:@""])
            self.title = [dict objectForKey:@"recruitment_tittle"];
        if(![[dict objectForKey:@"amount"] isKindOfClass:[NSNull class]])
            self.money = [[dict objectForKey:@"amount"]doubleValue];
        if(![[dict objectForKey:@"address"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"address"] isEqualToString:@""])
            self.address = [dict objectForKey:@"address"];
        if(![[dict objectForKey:@"count_type"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"count_type"] isEqualToString:@""])
            self.countType = [dict objectForKey:@"count_type"];
        if(![[dict objectForKey:@"ariunit"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"ariunit"] isEqualToString:@""])
            self.moneyType = [dict objectForKey:@"ariunit"];
        if(![[dict objectForKey:@"parttimejob_logo"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"parttimejob_logo"] isEqualToString:@""])
            self.jobImg = [dict objectForKey:@"parttimejob_logo"];
        if(![[dict objectForKey:@"timetype"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"timetype"] isEqualToString:@""])
            self.timeType = [dict objectForKey:@"timetype"];
        if(![[dict objectForKey:@"type"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"type"] isEqualToString:@""])
            self.jobType = [dict objectForKey:@"type"];
        if(![[dict objectForKey:@"typecode"] isKindOfClass:[NSNull class]])
            self.jobTypeCode = [[dict objectForKey:@"typecode"]integerValue];
        if(![[dict objectForKey:@"new"] isKindOfClass:[NSNull class]])
            self.isJobNew = [[dict objectForKey:@"new"]intValue];
        if(![[dict objectForKey:@"remaining"] isKindOfClass:[NSNull class]])
            self.remaining = [[dict objectForKey:@"remaining"]intValue];
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
