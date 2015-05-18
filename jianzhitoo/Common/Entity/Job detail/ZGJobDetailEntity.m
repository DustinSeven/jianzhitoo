//
//  ZGJobDetailEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/16/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGJobDetailEntity.h"

@implementation ZGJobDetailEntity

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
        if(![[dict objectForKey:@"parttimlogo"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"parttimlogo"] isEqualToString:@""])
            self.jobImg = [dict objectForKey:@"parttimlogo"];
        if(![[dict objectForKey:@"recruitment_title"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"recruitment_title"] isEqualToString:@""])
            self.jobName = [dict objectForKey:@"recruitment_title"];
        if(![[dict objectForKey:@"unit"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"unit"] isEqualToString:@""])
            self.company = [dict objectForKey:@"unit"];
        if(![[dict objectForKey:@"amount"] isKindOfClass:[NSNull class]])
            self.money = [[dict objectForKey:@"amount"]doubleValue];
        if(![[dict objectForKey:@"count_type"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"count_type"] isEqualToString:@""])
            self.countType = [dict objectForKey:@"count_type"];
        if(![[dict objectForKey:@"workhours"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"workhours"] isEqualToString:@""])
            self.time = [dict objectForKey:@"workhours"];
        if(![[dict objectForKey:@"stopdate"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"stopdate"] isEqualToString:@""])
            self.deadline = [dict objectForKey:@"stopdate"];
        if(![[dict objectForKey:@"address"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"address"] isEqualToString:@""])
            self.address = [dict objectForKey:@"address"];
        if(![[dict objectForKey:@"parttimejob_num"] isKindOfClass:[NSNull class]])
            self.jobNum = [[dict objectForKey:@"parttimejob_num"]intValue];
        if(![[dict objectForKey:@"sex"] isKindOfClass:[NSNull class]])
            self.sex = [[dict objectForKey:@"sex"]intValue];
        if(![[dict objectForKey:@"height"] isKindOfClass:[NSNull class]])
            self.height = [[dict objectForKey:@"height"]floatValue];
        if(![[dict objectForKey:@"health_certificate"] isKindOfClass:[NSNull class]])
            self.health = [[dict objectForKey:@"health_certificate"]intValue];
        if(![[dict objectForKey:@"interview"] isKindOfClass:[NSNull class]])
            self.interview = [[dict objectForKey:@"interview"]intValue];
        if(![[dict objectForKey:@"interview_address"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"interview_address"] isEqualToString:@""])
            self.interviewAddr = [dict objectForKey:@"interview_address"];
        if(![[dict objectForKey:@"interviewdate"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"interviewdate"] isEqualToString:@""])
            self.interviewTime = [dict objectForKey:@"interviewdate"];
        if(![[dict objectForKey:@"work_content"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"work_content"] isEqualToString:@""])
            self.jobContent = [dict objectForKey:@"work_content"];
        if(![[dict objectForKey:@"remark"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"remark"] isEqualToString:@""])
            self.remark = [dict objectForKey:@"remark"];
        if(![[dict objectForKey:@"worktimetype"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"worktimetype"] isEqualToString:@""])
            self.workTimeType = [dict objectForKey:@"worktimetype"];
        if(![[dict objectForKey:@"typecode"] isKindOfClass:[NSNull class]])
            self.jobTypeCode = [[dict objectForKey:@"typecode"]longValue];
        if(![[dict objectForKey:@"latitude"] isKindOfClass:[NSNull class]])
            self.latitude = [dict objectForKey:@"latitude"];
        if(![[dict objectForKey:@"longitude"] isKindOfClass:[NSNull class]])
            self.longitude = [dict objectForKey:@"longitude"];
        if(![[dict objectForKey:@"enroll"] isKindOfClass:[NSNull class]])
            self.enroll = [[dict objectForKey:@"enroll"]intValue];
        if(![[dict objectForKey:@"remaining"]isKindOfClass:[NSNull class]])
            self.remaining = [[dict objectForKey:@"remaining"]intValue];
        if(![[dict objectForKey:@"url"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"url"] isEqualToString:@""])
            self.shareUrl = [dict objectForKey:@"url"];
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
