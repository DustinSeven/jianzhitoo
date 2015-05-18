//
//  ZGRegistrationCell.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "GMGridView.h"
#import "ZGRegistrationViewBase.h"

#define GridViewCellBackgroundNormal [UIColor colorWithRed:61.0f / 255.0f green:205.0f / 255.0f blue:176.0f / 255.0f alpha:1.0f]
#define GridViewCellBackgroundCancel [UIColor colorWithRed:183.0f / 255.0f green:183.0f / 255.0f blue:183.0f / 255.0f alpha:1.0f]

typedef enum
{
    RegistrationCellType_add,
    RegistrationCellType_added,
    RegistrationCellType_cancel,
}RegistrationCellType;

@interface ZGRegistrationCell : GMGridViewCell

@property (nonatomic , strong) UILabel *textLab;
@property (nonatomic , strong) UIImageView *statusImg;

@property (nonatomic , assign) RegistrationCellType cellType;

- (void)chooseStatus:(RegistrationCellType ) type;

@end
