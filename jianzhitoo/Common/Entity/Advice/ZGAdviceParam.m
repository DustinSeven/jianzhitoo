//
//  ZGAdviceParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAdviceParam.h"

@implementation ZGAdviceParam
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
        if(self.userId)
            [dict setObject:[NSNumber numberWithLong: self.userId ] forKey:@"userid"];
        if(self.mobile)
            [dict setObject:self.mobile forKey:@"mobile"];
        if(self.account)
            [dict setObject:self.account forKey:@"username"];
        if(self.title)
            [dict setObject:self.title forKey:@"title"];
        if(self.content)
            [dict setObject:self.content forKey:@"content"];
        if(self.email)
            [dict setObject:self.email forKey:@"email"];
        if(self.qq)
            [dict setObject:self.qq forKey:@"qq"];
    }
    return dict;
}

@end
