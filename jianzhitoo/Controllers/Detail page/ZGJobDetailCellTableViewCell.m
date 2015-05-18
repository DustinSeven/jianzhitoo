//
//  ZGJobDetailCellTableViewCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/6/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGJobDetailCellTableViewCell.h"

@implementation ZGJobDetailCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.jobImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        self.jobImg.userInteractionEnabled = YES;
        self.jobImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.jobImg];
        
        self.jobTypeImg = [[UIImageView alloc]initWithFrame:CGRectMake(255, 0, 46.5, 22.5)];
        self.jobTypeImg.backgroundColor = [UIColor clearColor];
        [self.jobImg addSubview:self.jobTypeImg];
        
        self.jobNameLab = [[UILabel alloc]init];
        self.backgroundColor = [UIColor clearColor];
        self.jobNameLab.font = [UIFont fontWithName:APP_FONT_NORMAL size:JobDetailJobNameSize];
        self.jobNameLab.textColor = [UIColor blackColor];
        self.jobNameLab.textAlignment = NSTextAlignmentCenter;
        self.jobNameLab.lineBreakMode = NSLineBreakByWordWrapping;
        self.jobNameLab.numberOfLines = 0;
        [self.contentView addSubview:self.jobNameLab];
        
        self.leftIcon = [[UIImageView alloc]init];
        self.leftIcon.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftIcon];
        
        self.contentLab = [[UILabel alloc]init];
        self.contentLab.textAlignment = NSTextAlignmentLeft;
        self.contentLab.lineBreakMode = NSLineBreakByWordWrapping;
        self.contentLab.numberOfLines = 0;
        self.contentLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.contentLab];
        
        self.moneyIcon = [[UIImageView alloc]init];
        self.moneyIcon.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.moneyIcon];
        
        self.mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mapBtn setTitle:@"查看地图" forState:UIControlStateNormal];
        [self.mapBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15.5, 0, 0)];
        [self.mapBtn setTitleColor:[UIColor colorWithRed:68.0f / 255.0f green:208.0f / 255.0f blue:179.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
        UIImageView *mapBtnIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 3, 15.5, 15.5)];
        mapBtnIcon.image = [UIImage imageNamed:@"job_detail_map_btn_icon"];
        [self.mapBtn addSubview:mapBtnIcon];
        self.mapBtn.backgroundColor = [UIColor clearColor];
        self.mapBtn.titleLabel.font = [UIFont fontWithName:APP_FONT_NORMAL size:13];
        self.mapBtn.frame = CGRectMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailMapBtnWidth, 10, JobDetailMapBtnWidth, 21);
        [self.contentView addSubview:self.mapBtn];
        
        self.schoolmateTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(JobDetailMainSpacing, JobDetailUpDownSpacing, 70, 20)];
        self.schoolmateTitleLab.text = @"已报校友";
        self.schoolmateTitleLab.font = [UIFont fontWithName:APP_FONT_NORMAL size:JobDetailJobNameSize];
        self.schoolmateTitleLab.textColor = APP_FONT_COLOR_NORMAL;
        [self.contentView addSubview:self.schoolmateTitleLab];
        
        float spacing = (SCREEN_WIDTH - (JobDetailMainSpacing + 15) * 2 - 5 * JobDetailSchoolMateWidth) / 4;
        self.schoolmateImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(JobDetailMainSpacing + 15, 45, JobDetailSchoolMateWidth, JobDetailSchoolMateWidth)];
        self.schoolmateImg1.layer.cornerRadius = JobDetailSchoolMateWidth / 2;
        self.schoolmateImg1.layer.masksToBounds = YES;
        self.schoolmateImg1.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.schoolmateImg1];
        
        self.schoolmateImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(JobDetailMainSpacing + 15 + JobDetailSchoolMateWidth + spacing, 45, JobDetailSchoolMateWidth, JobDetailSchoolMateWidth)];
        self.schoolmateImg2.layer.cornerRadius = JobDetailSchoolMateWidth / 2;
        self.schoolmateImg2.layer.masksToBounds = YES;
        self.schoolmateImg2.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.schoolmateImg2];
        
        self.schoolmateImg3 = [[UIImageView alloc]initWithFrame:CGRectMake(JobDetailMainSpacing + 15 + 2 * JobDetailSchoolMateWidth + 2 * spacing, 45, JobDetailSchoolMateWidth, JobDetailSchoolMateWidth)];
        self.schoolmateImg3.layer.cornerRadius = JobDetailSchoolMateWidth / 2;
        self.schoolmateImg3.layer.masksToBounds = YES;
        self.schoolmateImg3.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.schoolmateImg3];
        
        self.schoolmateImg4 = [[UIImageView alloc]initWithFrame:CGRectMake(JobDetailMainSpacing + 15 + 3 * JobDetailSchoolMateWidth + 3 * spacing, 45, JobDetailSchoolMateWidth, JobDetailSchoolMateWidth)];
        self.schoolmateImg4.layer.cornerRadius = JobDetailSchoolMateWidth / 2;
        self.schoolmateImg4.layer.masksToBounds = YES;
        self.schoolmateImg4.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.schoolmateImg4];
        
        self.schoolmateImg5 = [[UIImageView alloc]initWithFrame:CGRectMake(JobDetailMainSpacing + 15 + 4 * JobDetailSchoolMateWidth + 4 * spacing, 45, JobDetailSchoolMateWidth, JobDetailSchoolMateWidth)];
        self.schoolmateImg5.layer.cornerRadius = JobDetailSchoolMateWidth / 2;
        self.schoolmateImg5.layer.masksToBounds = YES;
        self.schoolmateImg5.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.schoolmateImg5];
        
        self.joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.joinBtn.frame = CGRectMake((SCREEN_WIDTH - JobDetailSchoolJoinBtnWidth) / 2 , 100, JobDetailSchoolJoinBtnWidth, JobDetailSchoolJoinBtnHeight);
        self.joinBtn.backgroundColor = JobDetailSchoolJoinBtnColor;
        [self.joinBtn setTitle:@"我要报名" forState:UIControlStateNormal];
        [self.joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.joinBtn.titleLabel.font = [UIFont fontWithName:APP_FONT_NORMAL size:15];
        self.joinBtn.layer.cornerRadius = 5;
        [self.contentView addSubview:self.joinBtn];
        
    }
    return self;
}

- (void)hideCellUI
{
    self.jobImg.hidden = YES;
    self.jobTypeImg.hidden = YES;
    self.jobNameLab.hidden = YES;
    self.leftIcon.hidden = YES;
    self.contentLab.hidden = YES;
    self.moneyIcon.hidden = YES;
    self.mapBtn.hidden = YES;
    self.schoolmateTitleLab.hidden = YES;
    self.schoolmateImg1.hidden = YES;
    self.schoolmateImg2.hidden = YES;
    self.schoolmateImg3.hidden = YES;
    self.schoolmateImg4.hidden = YES;
    self.schoolmateImg5.hidden = YES;
    self.joinBtn.hidden = YES;
}

-(void)updateUI:(JobDetailCellType)type
{
    switch (type) {
        case JobDetailCellType_JobImg:
        {
            [self hideCellUI];
            
            self.jobImg.hidden = NO;
            self.jobTypeImg.hidden = NO;
        }
            break;
        case JobDetailCellType_JobName:
        {
            [self hideCellUI];
            
            self.jobNameLab.hidden = NO;
        }
            break;
        case JobDetailCellType_Company:
        {
            [self hideCellUI];
            
            self.leftIcon.hidden = NO;
            self.contentLab.hidden = NO;
        }
            break;
        case JobDetailCellType_Money:
        {
            [self hideCellUI];
            
            self.leftIcon.hidden = NO;
            self.contentLab.hidden = NO;
            self.moneyIcon.hidden = NO;
        }
            break;
        case JobDetailCellType_Time:
        {
            [self hideCellUI];
            
            self.leftIcon.hidden = NO;
            self.contentLab.hidden = NO;
        }
            break;
        case JobDetailCellType_Deadline:
        {
            [self hideCellUI];
            
            self.leftIcon.hidden = NO;
            self.contentLab.hidden = NO;
        }
            break;
        case JobDetailCellType_Location:
        {
            [self hideCellUI];
            
            self.leftIcon.hidden = NO;
            self.contentLab.hidden = NO;
            
            self.mapBtn.hidden = NO;
        }
            break;
        case JobDetailCellType_NumAndGender:
        {
            [self hideCellUI];
            
            self.contentLab.hidden = NO;
        }
            break;
        case JobDetailCellType_HeightAndHealth:
        {
            [self hideCellUI];
            
            self.contentLab.hidden = NO;
        }
            break;
        case JobDetailCellType_Detail:
        {
            [self hideCellUI];
            
            self.leftIcon.hidden = NO;
            self.contentLab.hidden = NO;
        }
            break;
        case JobDetailCellType_Remark:
        {
            [self hideCellUI];
            
            self.leftIcon.hidden = NO;
            self.contentLab.hidden = NO;
        }
            break;
        case JobDetailCellType_Schoolmate:
        {
            [self hideCellUI];
            
            self.schoolmateTitleLab.hidden = NO;
            
            self.schoolmateImg1.hidden = NO;
            self.schoolmateImg2.hidden = NO;
            self.schoolmateImg3.hidden = NO;
            self.schoolmateImg4.hidden = NO;
            self.schoolmateImg5.hidden = NO;
            
            self.joinBtn.hidden = NO;
        }
            break;

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
