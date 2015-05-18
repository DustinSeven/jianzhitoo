//
//  ZGBaseEntity.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseEntity.h"
#import <UIKit/UIDevice.h>

@implementation ZGBaseEntity

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initParam];
    }
    return self;
}

- (void)initParam
{
    self.deviceId = [[[[UIDevice currentDevice] identifierForVendor]UUIDString]lowercaseString];
    self.cversion = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] intValue];
    self.ctype = 2;
}

- (id)initWithAttributes:(NSDictionary *)dict
{
    self = [self init];
    if (self)
    {
        [self initParam];
    }
    
    return self;
}

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:self.deviceId forKey:@"deviceid"];
    [dict setObject:[NSNumber numberWithInt:self.cversion] forKey:@"cversion"];
    [dict setObject:[NSNumber numberWithInt:self.ctype] forKey:@"ctype"];
    
    return dict;
}

- (id) initWithCoder: (NSCoder *)coder
{
    self.ctype = [coder decodeIntForKey:@"ctype"];
    self.cversion = [coder decodeIntForKey:@"cversion"];
    self.deviceId = [coder decodeObjectForKey:@"deviceId"];
    
    return self;
}
- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeInt:self.ctype forKey:@"ctype"];
    [coder encodeInt:self.cversion forKey:@"cversion"];
    [coder encodeObject:self.deviceId forKey:@"deviceId"];
    
}

@end
