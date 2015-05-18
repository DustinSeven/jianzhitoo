//
//  ZGRegistrationViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegistrationDetailViewIphone.h"

@interface ZGRegistrationDetailViewIphone()
{
    ZGBaseView *line1;
    ZGBaseView *line2;
    ZGBaseView *line3;
    
    UIImageView *timeIcon;
    UIImageView *phoneIcon1;
    UIImageView *phoneIcon2;
}

@end

@implementation ZGRegistrationDetailViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        [self initWitgets];
    }
    return self;
}

- (void)initWitgets
{
    self.backgroundColor = VIEW_BACKGROUND;
    
    self.jobInfoBackView = [[ZGBaseView alloc]init];
    self.jobInfoBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.jobInfoBackView];
    
    line1 = [[ZGBaseView alloc]init];
    line1.backgroundColor = RegistrationDetailJobImgBorderColor;
    [self.jobInfoBackView addSubview:line1];
    
    self.jobImg = [[UIImageView alloc]init];
    self.jobImg.layer.borderWidth = 2;
    self.jobImg.layer.borderColor = RegistrationDetailJobImgBorderColor.CGColor;
    self.jobImg.layer.cornerRadius = RegistrationDetailJobImgRadius;
    self.jobImg.layer.masksToBounds = YES;
    [self.jobInfoBackView addSubview:self.jobImg];
    
    self.jobNamelab = [[UILabel alloc]init];
    self.jobNamelab.textColor = APP_FONT_COLOR_NORMAL;
    self.jobNamelab.lineBreakMode = NSLineBreakByWordWrapping;
    self.jobNamelab.numberOfLines = 0;
    self.jobNamelab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.jobNamelab.backgroundColor = [UIColor clearColor];
    [self.jobInfoBackView addSubview:self.jobNamelab];
    
    self.rmbIconImg = [[UIImageView alloc]init];
    self.rmbIconImg.backgroundColor = [UIColor clearColor];
    self.rmbIconImg.image = [UIImage imageNamed:@"main_page_rmb_icon"];
    [self.jobInfoBackView addSubview:self.rmbIconImg];
    
    self.rmbLab = [[UILabel alloc]init];
    //        self.rmbLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:APP_FONT_SIZE_NORMAL];
    self.rmbLab.backgroundColor = [UIColor clearColor];
    [self.jobInfoBackView addSubview:self.rmbLab];
    
    self.locIconImg = [[UIImageView alloc]init];
    self.locIconImg.backgroundColor = [UIColor clearColor];
    self.locIconImg.image = [UIImage imageNamed:@"main_page_loc_icon"];
    [self.jobInfoBackView addSubview:self.locIconImg];
    
    self.locLab = [[UILabel alloc]init];
    self.locLab.font = [UIFont systemFontOfSize:11];
    self.locLab.backgroundColor = [UIColor clearColor];
    self.locLab.textColor = APP_FONT_COLOR_THIN;
    [self.jobInfoBackView addSubview:self.locLab];
    
    timeIcon = [[UIImageView alloc]init];
    timeIcon.image = [UIImage imageNamed:@"registration_detail_time_icon"];
    timeIcon.backgroundColor = [UIColor clearColor];
    [self addSubview:timeIcon];
    
    self.jobTimeTitleLab = [[UILabel alloc]init];
    self.jobTimeTitleLab.backgroundColor = [UIColor clearColor];
    self.jobTimeTitleLab.font = [UIFont systemFontOfSize:17];
    self.jobTimeTitleLab.text = @"工作日期";
    self.jobTimeTitleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.jobTimeTitleLab];
    
    self.jobStatusBackView = [[ZGBaseView alloc]init];
    self.jobStatusBackView.backgroundColor = [UIColor whiteColor];
    self.jobStatusBackView.hidden = YES;
    [self addSubview:self.jobStatusBackView];
    
    line2 = [[ZGBaseView alloc]init];
    line2.backgroundColor = RegistrationDetailJobImgBorderColor;
    [self.jobStatusBackView addSubview:line2];
    
    line3 = [[ZGBaseView alloc]init];
    line3.backgroundColor = RegistrationDetailJobImgBorderColor;
    [self.jobStatusBackView addSubview:line3];
    
    self.jobTimeTableView = [[UITableView alloc]init];
    self.jobTimeTableView.separatorColor = [UIColor clearColor];
    self.jobTimeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jobTimeTableView.showsVerticalScrollIndicator = NO;
//    self.jobTimeTableView.bounces = NO;
    [self.jobStatusBackView addSubview:self.jobTimeTableView];
    
    self.refuseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.refuseBtn setTitle:@"不想去了" forState:UIControlStateNormal];
    [self.refuseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [self.refuseBtn setBackgroundImage:[UIImage imageNamed:@"registration_btn_icon_normal"] forState:UIControlStateNormal];
    [self.refuseBtn setBackgroundImage:[UIImage imageNamed:@"registration_btn_icon_pressed"] forState:UIControlStateHighlighted];
    self.refuseBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    [self.refuseBtn setTitleColor:RegisterDetailBtnColor forState:UIControlStateNormal];
    [self.refuseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.refuseBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.refuseBtn];
    
    self.connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.connectBtn setTitle:@"联系商家" forState:UIControlStateNormal];
    [self.connectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [self.connectBtn setBackgroundImage:[UIImage imageNamed:@"registration_btn_icon_normal"] forState:UIControlStateNormal];
    [self.connectBtn setBackgroundImage:[UIImage imageNamed:@"registration_btn_icon_pressed"] forState:UIControlStateHighlighted];
    self.connectBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    [self.connectBtn setTitleColor:RegisterDetailBtnColor forState:UIControlStateNormal];
    [self.connectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.connectBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.connectBtn];
    
    self.alertView = [[ZGMyRegistrationAlertViewIphone alloc]init];
    self.alertView.hidden = YES;
    [self addSubview:self.alertView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.jobInfoBackView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, RegistrationDetailJobInfoBackHeight);
    line1.frame = CGRectMake(0, self.jobInfoBackView.frame.size.height - 0.5, SCREEN_WIDTH, 0.5);
    
    self.jobImg.frame = CGRectMake(20 , RegistrationDetailJobInfoBackHeight / 2- RegistrationDetailJobImgRadius , 2 * RegistrationDetailJobImgRadius, 2 * RegistrationDetailJobImgRadius);
    
    self.jobNamelab.frame = CGRectMake(self.jobImg.frame.origin.x + 2 * RegistrationDetailJobImgRadius + 15, 5, 190, 40);
    
    self.rmbIconImg.frame = CGRectMake(self.jobImg.frame.origin.x + 2 * RegistrationDetailJobImgRadius + 15, CGRectGetMaxY(self.jobNamelab.frame) + 10, 9, 10);
    
    self.rmbLab.frame = CGRectMake(CGRectGetMaxX(self.rmbIconImg.frame) + 5, self.rmbIconImg.frame.origin.y - 5, 120, 20);
    
    self.locIconImg.frame = CGRectMake(self.jobImg.frame.origin.x + 2 * RegistrationDetailJobImgRadius + 16, CGRectGetMaxY(self.rmbIconImg.frame) + 10, 7.5, 9.5);
    
    self.locLab.frame = CGRectMake(CGRectGetMaxX(self.locIconImg.frame) + 6, self.locIconImg.frame.origin.y - 5, 120, 20);
    
    timeIcon.frame = CGRectMake(25,  HeadViewHeight + RegistrationDetailJobInfoBackHeight + 10, 25, 25);
    
    self.jobTimeTitleLab.frame = CGRectMake(65, HeadViewHeight + RegistrationDetailJobInfoBackHeight, 80, RegistrationDetailJobTimeTitleBackHeight);
    
    self.jobStatusBackView.frame = CGRectMake(0, HeadViewHeight + RegistrationDetailJobTimeTitleBackHeight + RegistrationDetailJobInfoBackHeight, SCREEN_WIDTH, RegistrationDetailJobTimeTableViewHeight + 1);
    self.jobTimeTableView.frame = CGRectMake(0, 0.5, SCREEN_WIDTH, RegistrationDetailJobTimeTableViewHeight);
    line2.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    line3.frame = CGRectMake(0, self.jobStatusBackView.frame.size.height - 0.5, SCREEN_WIDTH, 0.5);
    
    self.refuseBtn.frame = CGRectMake(SCREEN_WIDTH / 2 - RegisterDetailBtnWidth - 10, SCREEN_HEIGHT - RegisterDetailBtnHeight - 20, RegisterDetailBtnWidth, RegisterDetailBtnHeight);
    
    phoneIcon1.frame = CGRectMake(20, 10, 13.5, 14.5);
    phoneIcon2.frame = CGRectMake(20, 10, 13.5, 14.5);
    
    self.connectBtn.frame = CGRectMake(SCREEN_WIDTH / 2 + 10, SCREEN_HEIGHT - RegisterDetailBtnHeight - 20, RegisterDetailBtnWidth, RegisterDetailBtnHeight);
}

@end
