//
//  ZGWithdrawToAlipayParam.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/26/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGWithdrawToAlipayParam.h"

@implementation ZGWithdrawToAlipayParam

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
        [dict setObject:[NSNumber numberWithLong:self.userId] forKey:@"userid"];
        [dict setObject:self.account forKey:@"account"];
        [dict setObject:[ZGUtility sha1Algorithm:self.pwd] forKey:@"pwd"];
        [dict setObject:self.alipayAccount forKey:@"bank_card_no"];
        [dict setObject:self.mobile forKey:@"mobile"];
        [dict setObject:[NSNumber numberWithDouble:self.money] forKey:@"withdraw_money"];
    }
    return dict;
}


@end
