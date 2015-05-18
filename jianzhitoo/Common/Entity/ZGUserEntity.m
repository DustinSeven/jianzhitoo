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
        self.identity = [[dict objectForKey:@"id"] longValue];
        self.account = [dict objectForKey:@"account"];
        self.sex = [[dict objectForKey:@"sex"]intValue];
        if(![[dict objectForKey:@"remarks"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"remarks"] isEqualToString:@""] )
            self.remarks = [dict objectForKey:@"remarks"];
        if(![[dict objectForKey:@"collegeid"] isKindOfClass:[NSNull class]] )
            self.collegeId = [[dict objectForKey:@"collegeid"]longValue];
        if(![[dict objectForKey:@"collegename"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"collegename"] isEqualToString:@""])
            self.collegeName = [dict objectForKey:@"collegename"];
        if(![[dict objectForKey:@"user_images"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"user_images"] isEqualToString:@""])
            self.userImg = [dict objectForKey:@"user_images"];
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
        self.account = [coder decodeObjectForKey:@"account"];
        self.sex = [coder decodeIntForKey:@"sex"];
        self.remarks = [coder decodeObjectForKey:@"remarks"];
        self.collegeId = [coder decodeIntegerForKey:@"collegeId"];
        self.collegeName = [coder decodeObjectForKey:@"collegeName"];
        self.userImg = [coder decodeObjectForKey:@"userImg"];
        self.password = [coder decodeObjectForKey:@"password"];
    }
    return self;
}
- (void) encodeWithCoder: (NSCoder *)coder
{
    [super encodeWithCoder:coder];
    
    [coder encodeInteger:self.identity forKey:@"identity"];
    [coder encodeObject:self.account forKey:@"account"];
    [coder encodeInt:self.sex forKey:@"sex"];
    [coder encodeObject:self.remarks forKey:@"remarks"];
    [coder encodeInteger:self.collegeId forKey:@"collegeId"];
    [coder encodeObject:self.collegeName forKey:@"collegeName"];
    [coder encodeObject:self.userImg forKey:@"userImg"];
    [coder encodeObject:self.password forKey:@"password"];
}

@end
