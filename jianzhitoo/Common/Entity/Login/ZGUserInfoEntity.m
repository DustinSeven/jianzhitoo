//
//  ZGUserInfoEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/15/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUserInfoEntity.h"

@implementation ZGUserInfoEntity

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
        if(![[dict objectForKey:@"account"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"account"] isEqualToString:@""] )
            self.account = [dict objectForKey:@"account"];
        if(![[dict objectForKey:@"password"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"password"] isEqualToString:@""] )
            self.password = [dict objectForKey:@"password"];
        if(![[dict objectForKey:@"sex"] isKindOfClass:[NSNull class]])
            self.sex = [[dict objectForKey:@"sex"]intValue];
        if(![[dict objectForKey:@"mobile"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"mobile"] isEqualToString:@""] )
            self.mobile = [dict objectForKey:@"mobile"];
        
        if(![[dict objectForKey:@"qq"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"qq"] isEqualToString:@""] )
            self.qq = [dict objectForKey:@"qq"];
        
        if(![[dict objectForKey:@"provinceid"] isKindOfClass:[NSNull class]])
            self.provinceId = [[dict objectForKey:@"provinceid"] longValue];
        
        if(![[dict objectForKey:@"province"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"province"] isEqualToString:@""])
            self.province = [dict objectForKey:@"province"];
        
        if(![[dict objectForKey:@"cityid"] isKindOfClass:[NSNull class]] )
            self.cityId = [[dict objectForKey:@"cityid"]longValue];
        
        if(![[dict objectForKey:@"cityname"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"cityname"] isEqualToString:@""])
            self.city =  [dict objectForKey:@"cityname"];
        
        if(![[dict objectForKey:@"areaid"] isKindOfClass:[NSNull class]])
            self.areaId = [[dict objectForKey:@"areaid"]longValue];
        
        if(![[dict objectForKey:@"areaname"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"areaname"] isEqualToString:@""])
            self.area = [dict objectForKey:@"areaname"];
        
        if(![[dict objectForKey:@"schoolyear"] isKindOfClass:[NSNull class]] )
            self.schoolYear = [[dict objectForKey:@"schoolyear"]intValue];
        
        if(![[dict objectForKey:@"collegeid"] isKindOfClass:[NSNull class]] )
            self.collegeId = [[dict objectForKey:@"collegeid"]longValue];
        
        if(![[dict objectForKey:@"collegename"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"collegename"] isEqualToString:@""])
            self.college = [dict objectForKey:@"collegename"];
        
        if(![[dict objectForKey:@"departmentid"] isKindOfClass:[NSNull class]])
            self.depatmentId = [[dict objectForKey:@"departmentid"]longValue];
        
        if(![[dict objectForKey:@"department"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"department"] isEqualToString:@""])
            self.depatment = [dict objectForKey: @"department"];
        
        if(![[dict objectForKey:@"specialty"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"specialty"] isEqualToString:@""])
            self.specialty = [dict objectForKey:@"specialty"];
        
        if(![[dict objectForKey:@"userimage"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"userimage"] isEqualToString:@""])
            self.userImg = [dict objectForKey:@"userimage"];
        
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
        self.password = [coder decodeObjectForKey:@"password"];
        self.sex = [coder decodeIntForKey:@"sex"];
        self.mobile = [coder decodeObjectForKey:@"mobile"];
        self.qq = [coder decodeObjectForKey:@"qq"];
        self.provinceId = [coder decodeIntegerForKey:@"provinceid"];
        self.province = [coder decodeObjectForKey:@"province"];
        self.cityId = [coder decodeIntegerForKey:@"cityid"];
        self.city = [coder decodeObjectForKey:@"city"];
        self.areaId = [coder decodeIntegerForKey:@"areaid"];
        self.area = [coder decodeObjectForKey:@"area"];
        self.schoolYear = [coder decodeIntForKey:@"schoolyear"];
        self.collegeId = [coder decodeIntegerForKey:@"collegeid"];
        self.college = [coder decodeObjectForKey:@"college"];
        self.depatmentId = [coder decodeIntegerForKey:@"depatmentid"];
        self.depatment = [coder decodeObjectForKey:@"depatment"];
        self.specialty = [coder decodeObjectForKey:@"specialty"];
        self.userImg = [coder decodeObjectForKey:@"userImg"];
    }
    return self;
}
- (void) encodeWithCoder: (NSCoder *)coder
{
    [super encodeWithCoder:coder];
    
    [coder encodeInteger:self.identity forKey:@"identity"];
    [coder encodeObject:self.account forKey:@"account"];
    [coder encodeObject:self.password forKey:@"password"];
    [coder encodeInt:self.sex forKey:@"sex"];
    [coder encodeObject:self.mobile forKey:@"mobile"];
    [coder encodeObject:self.qq forKey:@"qq"];
    [coder encodeInteger:self.provinceId forKey:@"provinceid"];
    [coder encodeObject:self.province forKey:@"province"];
    [coder encodeInteger:self.cityId forKey:@"cityid"];
    [coder encodeObject:self.city forKey:@"city"];
    [coder encodeInteger:self.areaId forKey:@"areaid"];
    [coder encodeObject:self.area forKey:@"area"];
    [coder encodeInteger:self.schoolYear forKey:@"schoolyear"];
    [coder encodeInteger:self.collegeId forKey:@"collegeid"];
    [coder encodeObject:self.college forKey:@"college"];
    [coder encodeInteger:self.depatmentId forKey:@"depatmentid"];
    [coder encodeObject:self.depatment forKey:@"depatment"];
    [coder encodeObject:self.specialty forKey:@"specialty"];
    [coder encodeObject:self.userImg forKey:@"userImg"];
}

@end
