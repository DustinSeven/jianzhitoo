//
//  ZGSessionCell.h
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/6.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "SWTableViewCell.h"
#import "ZGBaseTableViewCell.h"
#import "ZGSessionViewBase.h"

#define SessionCellTimeLabWidth 80

@interface ZGSessionCell : SWTableViewCell

@property (nonatomic , strong) UIImageView *userImg;
@property (nonatomic , strong) UILabel *userNameLab;
@property (nonatomic , strong) UILabel *descriptionLab;
@property (nonatomic , strong) UILabel *timeLab;

@end
