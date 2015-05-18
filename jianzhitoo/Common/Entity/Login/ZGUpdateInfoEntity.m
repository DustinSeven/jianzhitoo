//
//  ZGUpdateInfoEntity.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/11/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUpdateInfoEntity.h"

@implementation ZGUpdateInfoEntity

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
        if(![[dict objectForKey:@"filesize"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"filesize"] isEqualToString:@""])
            self.fileSize = [dict objectForKey:@"filesize"];
        if(![[dict objectForKey:@"necessaryfrom"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"necessaryfrom"] isEqualToString:@""])
            self.nessaryForm = [dict objectForKey:@"necessaryfrom"];
        if(![[dict objectForKey:@"os"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"os"] isEqualToString:@""])
            self.os = [dict objectForKey:@"os"];
        if(![[dict objectForKey:@"updateinfo"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"updateinfo"] isEqualToString:@""])
            self.updateInfo = [dict objectForKey:@"updateinfo"];
        if(![[dict objectForKey:@"updatetime"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"updatetime"] isEqualToString:@""])
            self.updateTime = [dict objectForKey:@"updatetime"];
        if(![[dict objectForKey:@"url"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"url"] isEqualToString:@""])
            self.url = [dict objectForKey:@"url"];
        if(![[dict objectForKey:@"vername"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"vername"] isEqualToString:@""])
            self.versionName = [dict objectForKey:@"vername"];
        if(![[dict objectForKey:@"verno"] isKindOfClass:[NSNull class]])
            self.versionNo = [[dict objectForKey:@"verno"]intValue];
        
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
