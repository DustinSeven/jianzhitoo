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
            self.money = [[dict objectForKey:@"amount"]doubleValue];
        if(![[dict objectForKey:@"address"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"address"] isEqualToString:@""])
            self.address = [dict objectForKey:@"address"];
        if(![[dict objectForKey:@"parttimejob_logo"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"parttimejob_logo"] isEqualToString:@""])
            self.jobImg = [dict objectForKey:@"parttimejob_logo"];
        if(![[dict objectForKey:@"recruitment_tittle"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"recruitment_tittle"] isEqualToString:@""])
            self.jobTitle = [dict objectForKey:@"recruitment_tittle"];
        if(![[dict objectForKey:@"linkmanmobile"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"linkmanmobile"] isEqualToString:@""])
            self.customMobile = [dict objectForKey:@"linkmanmobile"];
        if(![[dict objectForKey:@"jianzhitu"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"jianzhitu"] isEqualToString:@""])
            self.jianzhitooMobile = [dict objectForKey:@"jianzhitu"];
        if(![[dict objectForKey:@"check_in"] isKindOfClass:[NSNull class]])
            self.checkIn = [[dict objectForKey:@"check_in"]intValue];
        if(![[dict objectForKey:@"partjobid"] isKindOfClass:[NSNull class]])
            self.jobId = [[dict objectForKey:@"partjobid"]integerValue];
        if(![[dict objectForKey:@"worktimetype"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"worktimetype"] isEqualToString:@""])
            self.timeType = [dict objectForKey:@"worktimetype"];
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
