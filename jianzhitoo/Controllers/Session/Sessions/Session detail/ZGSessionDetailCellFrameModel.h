//
//  ZGSessionDetailCellFrameModel.h
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/12.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGSessionDetailCellFrameModel : NSObject

@property (nonatomic , assign) BOOL isShowTime;
@property (nonatomic , assign) BOOL isMe;
@property (nonatomic , strong) NSString *imgStr;

@property (nonatomic , strong) NSString *message;
@property (nonatomic , strong) NSString *timeStr;

@property (nonatomic , assign) CGRect timeFrame;
@property (nonatomic , assign) CGRect imgFrame;
@property (nonatomic , assign) CGRect contentFrame;

@property (nonatomic , assign) CGFloat cellHeght;

- (void)initValue;

@end
