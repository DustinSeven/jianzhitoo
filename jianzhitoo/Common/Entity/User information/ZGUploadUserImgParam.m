//
//  ZGUploadUserImgParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUploadUserImgParam.h"

@implementation ZGUploadUserImgParam

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
        [dict setObject:self.mobile forKey:@"mobile"];
        [dict setObject:self.password forKey:@"pwd"];
    }
    return dict;
}


@end
