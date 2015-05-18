//
//  ZGProvacyEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/29/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGProvacyEntity.h"

@implementation ZGProvacyEntity

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
        if(![[dict objectForKey:@"opentoalumnus"] isKindOfClass:[NSNull class]])
            self.openToSchoolmate = [[dict objectForKey:@"opentoalumnus"]intValue];
        if(![[dict objectForKey:@"opentocontacts"] isKindOfClass:[NSNull class]])
            self.openToFriends = [[dict objectForKey:@"opentocontacts"]intValue];
        if(![[dict objectForKey:@"opentofriends"] isKindOfClass:[NSNull class]])
            self.openToContacts = [[dict objectForKey:@"opentofriends"]intValue];
        if(![[dict objectForKey:@"pushable"] isKindOfClass:[NSNull class]])
            self.pushable = [[dict objectForKey:@"pushable"]intValue];
        if(![[dict objectForKey:@"pushdate"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"pushdate"] isEqualToString:@""])
            self.pushDate = [dict objectForKey:@"pushdate"];
        if(![[dict objectForKey:@"pushtime"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"pushtime"] isEqualToString:@""])
            self.pushTime = [dict objectForKey:@"pushtime"];
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
