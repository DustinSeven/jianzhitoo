//
//  ZGMyRegistrationListCellTableViewCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/8/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMyRegistrationListCell.h"
#import "ZGMyRegistrationViewBase.h"

@implementation ZGMyRegistrationListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
//        self.layoutMargins = UIEdgeInsetsZero;
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.jobImg = [[UIImageView alloc]initWithFrame:CGRectMake(20 , RegisterListCellHeight / 2- RegisterJobImgRadius -13 , 2 * RegisterJobImgRadius, 2 * RegisterJobImgRadius)];
        self.jobImg.layer.borderWidth = 2;
        self.jobImg.layer.borderColor = RegisterJobImgBorderColor.CGColor;
        self.jobImg.layer.cornerRadius = RegisterJobImgRadius;
        self.jobImg.layer.masksToBounds = YES;
        [self.contentView addSubview:self.jobImg];
        
        self.jobNamelab = [[UILabel alloc]initWithFrame:CGRectMake(self.jobImg.frame.origin.x + 2 * RegisterJobImgRadius + 15, 5, 190, 40)];
        self.jobNamelab.textColor = APP_FONT_COLOR_NORMAL;
        self.jobNamelab.lineBreakMode = NSLineBreakByWordWrapping;
        self.jobNamelab.numberOfLines = 0;
        self.jobNamelab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.jobNamelab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.jobNamelab];
        
        self.rmbIconImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.jobImg.frame.origin.x + 2 * RegisterJobImgRadius + 15, CGRectGetMaxY(self.jobNamelab.frame) + 10, 9, 10)];
        self.rmbIconImg.backgroundColor = [UIColor clearColor];
        self.rmbIconImg.image = [UIImage imageNamed:@"main_page_rmb_icon"];
        [self.contentView addSubview:self.rmbIconImg];
        
        self.rmbLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.rmbIconImg.frame) + 5, self.rmbIconImg.frame.origin.y - 5, 120, 20)];
        //        self.rmbLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        self.rmbLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.rmbLab];
        
        self.locIconImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.jobImg.frame.origin.x + 2 * RegisterJobImgRadius + 16, CGRectGetMaxY(self.rmbIconImg.frame) + 10, 7.5, 9.5)];
        self.locIconImg.backgroundColor = [UIColor clearColor];
        self.locIconImg.image = [UIImage imageNamed:@"main_page_loc_icon"];
        [self.contentView addSubview:self.locIconImg];
        
        self.locLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.locIconImg.frame) + 6, self.locIconImg.frame.origin.y - 5, 180, 20)];
        self.locLab.font = [UIFont systemFontOfSize:11];
        self.locLab.backgroundColor = [UIColor clearColor];
        self.locLab.textColor = APP_FONT_COLOR_THIN;
        [self.contentView addSubview:self.locLab];
        
        self.statusLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, RegisterListCellHeight - 30, 50, 20)];
        self.statusLab.backgroundColor = [UIColor clearColor];
        self.statusLab.hidden = YES;
        self.statusLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.contentView addSubview:self.statusLab];
        
        self.refuseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.refuseBtn setTitle:@"不想去了" forState:UIControlStateNormal];
        [self.refuseBtn setBackgroundImage:[UIImage imageNamed:@"my_registration_btn_normal"] forState:UIControlStateNormal];
        [self.refuseBtn setBackgroundImage:[UIImage imageNamed:@"my_registration_btn_pressed"] forState:UIControlStateHighlighted];
        self.refuseBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.refuseBtn setTitleColor:RegisterBtnColor forState:UIControlStateNormal];
        [self.refuseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.refuseBtn.backgroundColor = [UIColor clearColor];
        self.refuseBtn.layer.cornerRadius = 3;
        self.refuseBtn.frame = CGRectMake(self.locIconImg.frame.origin.x, RegisterListCellHeight - 30, RegisterBtnWidth, RegisterBtnHeight);
        [self.refuseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [self.contentView addSubview:self.refuseBtn];
        
        self.connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.connectBtn setTitle:@"联系商家" forState:UIControlStateNormal];
        [self.connectBtn setBackgroundImage:[UIImage imageNamed:@"my_registration_btn_normal"] forState:UIControlStateNormal];
        [self.connectBtn setBackgroundImage:[UIImage imageNamed:@"my_registration_btn_pressed"] forState:UIControlStateHighlighted];
        self.connectBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.connectBtn setTitleColor:RegisterBtnColor forState:UIControlStateNormal];
        [self.connectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.connectBtn.backgroundColor = [UIColor clearColor];
        self.connectBtn.layer.borderWidth = 1;
        self.connectBtn.layer.borderColor = RegisterBtnColor.CGColor;
        self.connectBtn.layer.cornerRadius = 3;
        self.connectBtn.frame = CGRectMake(CGRectGetMaxX(self.refuseBtn.frame) + 10, self.refuseBtn.frame.origin.y, RegisterBtnWidth, RegisterBtnHeight);
         [self.connectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [self.contentView addSubview:self.connectBtn];
        
        self.workTimeType = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.jobImg.frame), CGRectGetMaxY(self.jobImg.frame) + 5, RegisterJobImgRadius * 2, 20)];
        self.workTimeType.textAlignment = NSTextAlignmentCenter;
        self.workTimeType.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.workTimeType.textColor = RegisterStatusLabColorNotSignUp;
        [self.contentView addSubview:self.workTimeType];
        
        self.separator.frame = CGRectMake(0, RegisterListCellHeight - 0.5, SCREEN_WIDTH, 0.5);
        
    }
    return self;
}

- (void)setJobStatus:(int)status
{
    if(status == 1)
    {
        self.statusLab.hidden = YES;
        self.refuseBtn.hidden = NO;
        self.connectBtn.hidden = NO;
        self.statusLab.textColor = RegisterStatusLabColorFinished;
    }
    if(status == 2)
    {
        self.statusLab.hidden = NO;
        self.refuseBtn.hidden = YES;
        self.connectBtn.hidden = YES;
        self.statusLab.text = @"已完成";
        self.statusLab.textColor = RegisterStatusLabColorFinished;
    }
    if(status == 3)
    {
        self.statusLab.hidden = NO;
//        self.refuseBtn.hidden = YES;
//        self.connectBtn.hidden = YES;
//        self.statusLab.text = @"未签到";
        self.statusLab.textColor = RegisterStatusLabColorNotSignUp;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
