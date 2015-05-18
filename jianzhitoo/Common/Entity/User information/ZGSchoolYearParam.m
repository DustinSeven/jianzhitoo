//
//  ZGSchoolYearParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/20/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSchoolYearParam.h"

@implementation ZGSchoolYearParam

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
        
    }
    return self;
}

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [super getDictionary];
    if(dict)
    {
        [dict setObject:[NSNumber numberWithLong: self.userId ] forKey:@"userid"];
        [dict setObject:self.mobile forKey:@"mobile"];
        [dict setObject:self.password forKey:@"pwd"];
        [dict setObject:[NSNumber numberWithInt:self.schoolYear] forKey:@"schoolyears"];
    }
    return dict;
}


@end
