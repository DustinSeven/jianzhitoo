//
//  ZGJobsListCell.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/4/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGJobsListCell.h"
#import "ZGMainPageViewBase.h"

@implementation ZGJobsListCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
//        self.layoutMargins = UIEdgeInsetsZero;
        
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.jobImg = [[UIImageView alloc]initWithFrame:CGRectMake(20 , MainPageListRowHeight / 2- MainPageJobImgRadius , 2 * MainPageJobImgRadius, 2 * MainPageJobImgRadius)];
        self.jobImg.layer.borderWidth = 2;
        self.jobImg.layer.borderColor = MainPageJobImgBorderColor.CGColor;
        self.jobImg.layer.cornerRadius = MainPageJobImgRadius;
        self.jobImg.layer.masksToBounds = YES;
        [self.contentView addSubview:self.jobImg];
        
        self.isJobNewImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.jobImg.frame.origin.x - (76.5 - 2 * MainPageJobImgRadius) / 2, 60, 76.5, 24.5)];
        self.isJobNewImg.backgroundColor = [UIColor clearColor];
        self.isJobNewImg.image = [UIImage imageNamed:@"main_page_new_job_img"];
        [self.contentView addSubview:self.isJobNewImg];
        self.isJobNewImg.hidden = YES;
        
        self.jobNamelab = [[UILabel alloc]initWithFrame:CGRectMake(self.jobImg.frame.origin.x + 2 * MainPageJobImgRadius + 15, 5, 140, 40)];
        if(IS_IPHONE6)
            self.jobNamelab.frame = CGRectMake(self.jobImg.frame.origin.x + 2 * MainPageJobImgRadius + 15, 5, 195, 40);
        self.jobNamelab.textColor = APP_FONT_COLOR_NORMAL;
        self.jobNamelab.lineBreakMode = NSLineBreakByTruncatingTail;
        self.jobNamelab.numberOfLines = 0;
        self.jobNamelab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.jobNamelab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.jobNamelab];
        
        self.rmbIconImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.jobImg.frame.origin.x + 2 * MainPageJobImgRadius + 15, CGRectGetMaxY(self.jobNamelab.frame) + 10, 9, 10)];
        self.rmbIconImg.backgroundColor = [UIColor clearColor];
        self.rmbIconImg.image = [UIImage imageNamed:@"main_page_rmb_icon"];
        [self.contentView addSubview:self.rmbIconImg];
        
        self.rmbLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.rmbIconImg.frame) + 5, self.rmbIconImg.frame.origin.y - 5, 120, 20)];
        if(IS_IPHONE6)
            self.rmbLab.frame = CGRectMake(CGRectGetMaxX(self.rmbIconImg.frame) + 5, self.rmbIconImg.frame.origin.y - 5, 175, 20);
        self.rmbLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.rmbLab];
        
        self.locIconImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.jobImg.frame.origin.x + 2 * MainPageJobImgRadius + 16, CGRectGetMaxY(self.rmbIconImg.frame) + 10, 7.5, 9.5)];
        self.locIconImg.backgroundColor = [UIColor clearColor];
        self.locIconImg.image = [UIImage imageNamed:@"main_page_loc_icon"];
        [self.contentView addSubview:self.locIconImg];
        
        self.locLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.locIconImg.frame) + 6, self.locIconImg.frame.origin.y - 5, 185, 20)];
        if(IS_IPHONE6)
            self.locLab.frame = CGRectMake(CGRectGetMaxX(self.locIconImg.frame) + 6, self.locIconImg.frame.origin.y - 5, 175, 20);
        self.locLab.font = [UIFont systemFontOfSize:11];;
        self.locLab.backgroundColor = [UIColor clearColor];
        self.locLab.textColor = APP_FONT_COLOR_THIN;
        [self.contentView addSubview:self.locLab];
        
        self.typeImg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.jobNamelab.frame) + 15, 0, 46.5, 22.5)];
//        if(IS_PHONE6)
//            self.typeImg.frame = CGRectMake(self.jobNamelab.frame.origin.x + self.jobNamelab.frame.size.width + 15, 0, 46.5, 22.5);
        self.typeImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.typeImg];
        
        self.statusImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.typeImg.frame.origin.x - 30, 35, 75, 45)];
        self.statusImg.backgroundColor = [UIColor clearColor];
        self.statusImg.image = [UIImage imageNamed:@"main_page_status_icon_full"];
        [self.contentView addSubview:self.statusImg];
        self.statusImg.hidden = YES;
        
        self.separator.frame = CGRectMake(0, MainPageListRowHeight - 0.5, SCREEN_WIDTH, 0.5);
    }
    return self;
}

@end
