//
//  ZGSchoolmateAlertViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/25/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSchoolmateAlertViewIphone.h"
#import "UIImageView+WebCache.h"

@implementation ZGSchoolmateAlertViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        self.isBackViewEntable = YES;
        
        self.baseView = [[ZGBaseView alloc]init];
        self.baseView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.baseView];
        
        self.backImgUp = [[UIImageView alloc]init];
        self.backImgUp.backgroundColor = [UIColor clearColor];
        self.backImgUp.image = [UIImage imageNamed:@"schoolmate_bac_img"];
        [self.baseView addSubview:self.backImgUp];
        
        self.userImg = [[UIImageView alloc]init];
        self.userImg.backgroundColor = [UIColor whiteColor];
        self.userImg.layer.borderWidth = 2;
        self.userImg.layer.borderColor = [UIColor whiteColor].CGColor;
        self.userImg.layer.masksToBounds = YES;
        self.userImg.layer.cornerRadius = SchoolmateAlertViewUserImgRadius;
        [self.baseView addSubview:self.userImg];
        
        self.genderImg = [[UIImageView alloc]init];
        self.genderImg.backgroundColor = [UIColor clearColor];
        [self.baseView addSubview:self.genderImg];
        
        self.usernameLab = [[UILabel alloc]init];
        self.usernameLab.backgroundColor = [UIColor clearColor];
        self.usernameLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.usernameLab.textColor = [UIColor whiteColor];
        self.usernameLab.textAlignment = NSTextAlignmentCenter;
        [self.baseView addSubview:self.usernameLab];
        
        self.departmentLab = [[UILabel alloc]init];
        self.departmentLab.backgroundColor = [UIColor clearColor];
        self.departmentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL - 2];
        self.departmentLab.textColor = [UIColor whiteColor];
        self.departmentLab.textAlignment = NSTextAlignmentCenter;
        [self.baseView addSubview:self.departmentLab];
        
        self.phoneIcon = [[UIImageView alloc]init];
        self.phoneIcon.backgroundColor = [UIColor clearColor];
        self.phoneIcon.image = [UIImage imageNamed:@"schoolmate_alert_phone_icon"];
        [self.baseView addSubview:self.phoneIcon];
        
        self.phoneNumLab = [[UILabel alloc]init];
        self.phoneNumLab.backgroundColor = [UIColor clearColor];
        self.phoneNumLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.phoneNumLab.textColor = [UIColor whiteColor];
        self.phoneNumLab.textAlignment = NSTextAlignmentRight;
        [self.baseView addSubview:self.phoneNumLab];
        
        self.callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.callBtn.backgroundColor = [UIColor clearColor];
        [self.callBtn setBackgroundImage:[UIImage imageNamed:@"schoolmate_call_btn_icon_normal"] forState:UIControlStateNormal];
        [self.callBtn setBackgroundImage:[UIImage imageNamed:@"schoolmate_call_btn_icon_pressed"] forState:UIControlStateHighlighted];
        [self.callBtn setTitle:@"约一下" forState:UIControlStateNormal];
        self.callBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.baseView addSubview:self.callBtn];
        
    }
    return self;
}

- (id)initWithView:(UIView *)view
{
    self = [self init];
    if(self)
    {
        self.fatherView = view;
    }
    return self;
}

- (void)setFatherView:(UIView *)fatherView
{
    self.frame = CGRectMake(0, 0, fatherView.frame.size.width, fatherView.frame.size.height);
}

- (void)setSchoolmateEntity:(ZGSchoolmateEntity *)schoolmateEntity
{
    if(schoolmateEntity.userImg)
       [self.userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,schoolmateEntity.userImg]] placeholderImage:[UIImage imageNamed:@"user_img_default_120px"] isScaleToCustomSize:NO];
    else
        self.userImg.image = [UIImage imageNamed:@"user_img_default_120px"];
    if(schoolmateEntity.account)
        self.usernameLab.text = schoolmateEntity.account;
    if(schoolmateEntity.department)
        self.departmentLab.text = schoolmateEntity.department;
    if(schoolmateEntity.mobile)
        self.phoneNumLab.text = schoolmateEntity.mobile;
    if(schoolmateEntity.sex)
    {
        if(schoolmateEntity.sex == 1)
            self.genderImg.image = [UIImage imageNamed:@"user_center_user_gender_icon_male"];
        if(schoolmateEntity.sex == 2)
            self.genderImg.image = [UIImage imageNamed:@"user_center_user_gender_icon_female"];
    }
}

- (void)showAlertWithEntity:(ZGSchoolmateEntity *)entity
{
    if(entity)
        self.schoolmateEntity = entity;
    self.hidden = NO;
    [ZGUtility view:self.baseView appearAt:CGPointMake(self.fatherView.frame.size.width / 2, self.fatherView.frame.size.height / 2) withDalay:0.6 duration:0.2];
}

- (void)alertDismiss:(UIButton *)button
{
    self.hidden = YES;
}

- (void)layoutSubviews
{
    self.baseView.frame = CGRectMake((SCREEN_WIDTH - SchoolmateAlertViewBackImgUpWidth) / 2, (SCREEN_HEIGHT - HeadViewHeight - SchoolmateAlertViewBackImgUpHeight) / 2, SchoolmateAlertViewBackImgUpWidth, SchoolmateAlertViewBackImgUpHeight + SchoolmateAlertViewCallBtnHeight);
    
    self.backImgUp.frame = CGRectMake(0, 0, SchoolmateAlertViewBackImgUpWidth, SchoolmateAlertViewBackImgUpHeight);
    
    self.userImg.frame = CGRectMake(self.backImgUp.frame.origin.x + SchoolmateAlertViewBackImgUpWidth / 2 - SchoolmateAlertViewUserImgRadius, self.backImgUp.frame.origin.y - SchoolmateAlertViewUserImgRadius, 2 * SchoolmateAlertViewUserImgRadius, 2 * SchoolmateAlertViewUserImgRadius);
    
    self.genderImg.frame = CGRectMake(self.userImg.frame.origin.x, self.userImg.frame.origin.y, 20, 20);
    
    self.usernameLab.frame = CGRectMake(self.backImgUp.frame.origin.x + (SchoolmateAlertViewBackImgUpWidth - SchoolmateAlertViewUsernameLabWidth) / 2, self.userImg.frame.origin.y + self.userImg.frame.size.height, SchoolmateAlertViewUsernameLabWidth, SchoolmateAlertViewUsernameLabHeight);
    self.departmentLab.frame = CGRectMake(self.backImgUp.frame.origin.x + (SchoolmateAlertViewBackImgUpWidth - SchoolmateAlertViewDepartmentLabWidth) / 2, self.usernameLab.frame.origin.y + self.usernameLab.frame.size.height, SchoolmateAlertViewDepartmentLabWidth, SchoolmateAlertViewDepartmentLabHeight);
    
    self.phoneIcon.frame = CGRectMake(self.backImgUp.frame.origin.x + 20, self.backImgUp.frame.origin.y + self.backImgUp.frame.size.height - SchoolmateAlertViewPhoneIconHeight - 20, SchoolmateAlertViewPhoneIconWidth, SchoolmateAlertViewPhoneIconHeight);
    
    self.phoneNumLab.frame = CGRectMake(self.backImgUp.frame.origin.x + self.backImgUp.frame.size.width - SchoolmateAlertViewPhoneNumLabWidth - 20, self.phoneIcon.frame.origin.y, SchoolmateAlertViewPhoneNumLabWidth, SchoolmateAlertViewPhoneNumLabHeight);
    
    self.callBtn.frame = CGRectMake(self.backImgUp.frame.origin.x, self.backImgUp.frame.origin.y - 1 + self.backImgUp.frame.size.height, SchoolmateAlertViewCallBtnWidth, SchoolmateAlertViewCallBtnHeight);
}


@end
