//
//  ZGSetProvacyParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/29/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSetProvacyParam.h"

@implementation ZGSetProvacyParam

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
        self.mobile = [dict objectForKey:@"mobile"];
        self.pwd = [dict objectForKey:@"pwd"];
    }
    return self;
}

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [super getDictionary];
    if(dict)
    {
        [dict setObject:self.mobile forKey:@"mobile"];
        [dict setObject:self.pwd forKey:@"pwd"];
        [dict setObject:[NSNumber numberWithLong:self.userId] forKey:@"userid"];
        [dict setObject:[NSNumber numberWithInt:self.openToSchoolmateProvacy] forKey:@"opentoalumnus"];
    }
    return dict;
}


@end
