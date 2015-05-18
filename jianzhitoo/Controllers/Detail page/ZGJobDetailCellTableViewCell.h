//
//  ZGJobDetailCellTableViewCell.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/6/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGBaseView.h"
#import "RTLabel.h"

typedef enum
{
    JobDetailCellType_JobImg = 0,
    JobDetailCellType_JobName,
    JobDetailCellType_Company,
    JobDetailCellType_Money,
    JobDetailCellType_Time,
    JobDetailCellType_Deadline,
    JobDetailCellType_Location,
    JobDetailCellType_NumAndGender,
    JobDetailCellType_HeightAndHealth,
    JobDetailCellType_Detail,
    JobDetailCellType_Remark,
    JobDetailCellType_Schoolmate
}JobDetailCellType;

#define JobDetailMainSpacing 18

#define JobDetailUpDownSpacing 15

#define JobDetailWordToLeftSpacing 60

#define JobDetailJobNameSize 15

#define JobDetailMapBtnWidth 77

#define JobDetailSchoolMateWidth 45

#define JobDetailLineSpacing 10

#define JobDetailSchoolJoinBtnWidth 255
#define JobDetailSchoolJoinBtnHeight 40
#define JobDetailSchoolJoinBtnColor [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]

#define JobDetailSingularCellBackground [UIColor colorWithRed:255.0f / 255.0f green:255.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f]
#define JobDetailEvenCellBackground [UIColor colorWithRed:240.0f / 255.0f green:240.0f / 255.0f blue:240.0f / 255.0f alpha:1.0f]

@interface ZGJobDetailCellTableViewCell : UITableViewCell

@property (nonatomic , strong) UIImageView *jobImg;
@property (nonatomic , strong) UIImageView *jobTypeImg;

@property (nonatomic , strong) UILabel *jobNameLab;

@property (nonatomic , strong) UIImageView *leftIcon;
@property (nonatomic , strong) UILabel *contentLab;

@property (nonatomic , strong) UIImageView *moneyIcon;

@property (nonatomic , strong) UIButton *mapBtn;

@property (nonatomic , strong) UILabel *schoolmateTitleLab;
@property (nonatomic , strong) UIImageView *schoolmateImg1;
@property (nonatomic , strong) UIImageView *schoolmateImg2;
@property (nonatomic , strong) UIImageView *schoolmateImg3;
@property (nonatomic , strong) UIImageView *schoolmateImg4;
@property (nonatomic , strong) UIImageView *schoolmateImg5;

@property (nonatomic , strong) UIButton *joinBtn;


-(void)updateUI:(JobDetailCellType)type;
@end
