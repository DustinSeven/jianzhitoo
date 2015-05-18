//
//  ZGBaseEntity.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZGBaseEntity : NSObject <NSCoding>

@property (nonatomic , assign) int ctype;
@property (nonatomic , assign) int cversion;
@property (nonatomic , strong) NSString *deviceId;




- (id)initWithAttributes:(NSDictionary *)dict;
- (NSMutableDictionary *)getDictionary;

@end
