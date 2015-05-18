//
//  ZGJobsListCell.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/4/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGBaseTableViewCell.h"

@interface ZGJobsListCell : ZGBaseTableViewCell

@property (nonatomic , strong) UIImageView *jobImg;
@property (nonatomic , strong) UIImageView *isJobNewImg;
@property (nonatomic , strong) UILabel *jobNamelab;
@property (nonatomic , strong) UIImageView *rmbIconImg;
@property (nonatomic , strong) UIImageView *locIconImg;
@property (nonatomic , strong) UILabel *rmbLab;
@property (nonatomic , strong) UILabel *locLab;
@property (nonatomic , strong) UIImageView *typeImg;
@property (nonatomic , strong) UIImageView *statusImg;

@end
