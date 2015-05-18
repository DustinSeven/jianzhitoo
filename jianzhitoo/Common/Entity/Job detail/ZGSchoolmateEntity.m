//
//  ZGScholmateEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/21/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSchoolmateEntity.h"

@implementation ZGSchoolmateEntity

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
        if(![[dict objectForKey:@"userid"] isKindOfClass:[NSNull class]])
            self.identity = [[dict objectForKey:@"userid"]longValue];
        if(![[dict objectForKey:@"userimage"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"address"] isEqualToString:@""])
            self.userImg = [dict objectForKey:@"userimage"];
        if(![[dict objectForKey:@"sex"] isKindOfClass:[NSNull class]])
            self.sex = [[dict objectForKey:@"sex"]intValue];
        if(![[dict objectForKey:@"account"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"account"] isEqualToString:@""])
            self.account = [dict objectForKey:@"account"];
        if(![[dict objectForKey:@"mobile"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"mobile"] isEqualToString:@""])
            self.mobile = [dict objectForKey:@"mobile"];
        if(![[dict objectForKey:@"department"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"department"] isEqualToString:@""])
            self.department = [dict objectForKey:@"department"];
        if(![[dict objectForKey:@"enrolltime"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"enrolltime"] isEqualToString:@""])
            self.registrationTime = [dict objectForKey:@"enrolltime"];
        if(![[dict objectForKey:@"ota"] isKindOfClass:[NSNull class]])
            self.ota = [[dict objectForKey:@"ota"]intValue];
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
