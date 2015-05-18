//
//  ZGJobTypeEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/18/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGJobTypeEntity.h"

@implementation ZGJobTypeEntity

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
        if(![[dict objectForKey:@"jobtypeid"] isKindOfClass:[NSNull class]])
            self.identity = [NSString stringWithFormat:@"%@",[dict objectForKey:@"jobtypeid"]];
        if(![[dict objectForKey:@"jobtypename"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"jobtypename"] isEqualToString:@""])
            self.name = [dict objectForKey:@"jobtypename"];
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
