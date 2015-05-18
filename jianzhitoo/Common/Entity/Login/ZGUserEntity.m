//
//  ZGUserEntity.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUserEntity.h"

@implementation ZGUserEntity

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
        if(![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]])
            self.identity = [[dict objectForKey:@"id"] longValue];
    }
    return self;
}

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [super getDictionary];
    if(dict)
    {
//        [dict setObject:[NSNumber numberWithLong:self.identity] forKey:@"id"];
//        [dict setObject:self.account forKey:@"account"];
//        [dict setObject:[NSNumber numberWithInt:self.sex] forKey:@"sex"];
//        [dict setObject:self.remarks forKey:@"remarks"];
//        [dict setObject:[NSNumber numberWithLong:self.collegeId] forKey:@"collegeid"];
//        [dict setObject:self.collegeName forKey:@"collegename"];
//        [dict setObject:self.userImg forKey:@"user_images"];
        
    }
    return dict;
}

- (id) initWithCoder: (NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(self)
    {
        self.identity = [coder decodeIntegerForKey:@"identity"];
    }
    return self;
}
- (void) encodeWithCoder: (NSCoder *)coder
{
    [super encodeWithCoder:coder];
    
    [coder encodeInteger:self.identity forKey:@"identity"];
}

@end
