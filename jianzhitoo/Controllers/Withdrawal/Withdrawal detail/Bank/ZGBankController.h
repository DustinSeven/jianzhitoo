//
//  ZGBankController.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseController.h"
#import "ZGBankCell.h"
#import "ZGBankViewIphone.h"
#import "ZGBankEntity.h"

@protocol ZGBankDelegate <NSObject>

-(void)gainTheBank:(ZGBankEntity *)entity;

@end

@interface ZGBankController : ZGBaseController

@property (nonatomic , strong) id<ZGBankDelegate> delegate;

@end
