//
//  ZGContactCell.h
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/9.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGBaseTableViewCell.h"
#import "SWTableViewCell.h"

#define ContactCellRowHeight 50

@interface ZGContactCell : SWTableViewCell

@property (nonatomic , strong) UIImageView *userImg;
@property (nonatomic , strong) UILabel *userNameLab;

@end
