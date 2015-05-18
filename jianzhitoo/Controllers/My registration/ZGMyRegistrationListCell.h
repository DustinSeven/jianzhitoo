//
//  ZGMyRegistrationListCellTableViewCell.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/8/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGBaseTableViewCell.h"


@interface ZGMyRegistrationListCell : ZGBaseTableViewCell

@property (nonatomic , strong) UIImageView *jobImg;
@property (nonatomic , strong) UILabel *jobNamelab;
@property (nonatomic , strong) UIImageView *rmbIconImg;
@property (nonatomic , strong) UIImageView *locIconImg;
@property (nonatomic , strong) UILabel *rmbLab;
@property (nonatomic , strong) UILabel *locLab;
@property (nonatomic , strong) UIButton *refuseBtn;
@property (nonatomic , strong) UIButton *connectBtn;
@property (nonatomic , strong) UILabel *statusLab;
@property (nonatomic , strong) UILabel *workTimeType;

- (void)setJobStatus:(int)status;

@end
