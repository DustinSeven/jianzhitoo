//
//  ZGUserInfoCell.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseTableViewCell.h"

#define UserInfoCellHeight (IS_IPHONE6?42:37.5)
#define UserInfoCellUserImgHeight 76

@interface ZGUserInfoCell : ZGBaseTableViewCell

@property (nonatomic , strong)UILabel *leftLab;
@property (nonatomic , strong)UILabel *rightLab;
@property (nonatomic , strong)UIImageView *rightImg;

- (void)setImgCell;

@end
