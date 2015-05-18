//
//  ZGUserCenterViewIphone.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUserCenterViewIphone.h"


@interface ZGUserCenterViewIphone()
{
    UIImageView *verticalLine1;
    UIImageView *verticalLine2;
    UILabel *takeNow;
    UIImageView *backIcon;
}

@end

@implementation ZGUserCenterViewIphone

 -(id)init
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
    
    self.headView = [[ZGHeadView alloc]init];
    self.headView.headTitleText.text = @"个人中心";
    self.headView.rightBtn.hidden = NO;
    [self.headView.rightBtn setTitle:@"签到" forState:UIControlStateNormal];
    [self.headView.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headView.rightBtn setTitleColor:APP_FONT_COLOR_THIN  forState:UIControlStateHighlighted];
    self.headView.rightBtn.backgroundColor = [UIColor clearColor];
    self.headView.rightBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headView.rightBtn.layer.borderWidth = 1;
    self.headView.rightBtn.layer.cornerRadius = 3;
    [self addSubview:self.headView];
    
    self.baseScrollView = [[UIScrollView alloc]init];
    self.baseScrollView.backgroundColor = [UIColor clearColor];
    self.baseScrollView.bounces = YES;
    self.baseScrollView.showsVerticalScrollIndicator = NO;
    self.baseScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 568 + 0.5 - HeadViewHeight);
    self.baseScrollView.delaysContentTouches =NO;
    [self addSubview:self.baseScrollView];
    
    self.userInfoBackImg = [[UIImageView alloc]init];
    self.userInfoBackImg.userInteractionEnabled = YES;
    self.userInfoBackImg.image = [UIImage imageNamed:@"user_center_user_info_back_img"];
    [self.baseScrollView addSubview:self.userInfoBackImg];
    
    self.userImg = [[UIImageView alloc]init];
    self.userImg.backgroundColor = [UIColor whiteColor];
    self.userImg.layer.borderWidth = 2;
    self.userImg.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userImg.layer.masksToBounds = YES;
    self.userImg.layer.cornerRadius = UserCenterUserImgRadius;
    [self.userInfoBackImg addSubview:self.userImg];
    
    self.userNameBackImg = [[UIImageView alloc]init];
    self.userNameBackImg.userInteractionEnabled = YES;
    self.userNameBackImg.image = [UIImage imageNamed:@"user_center_user_name_back_img"];
    [self.baseScrollView addSubview:self.userNameBackImg];
    
    self.userGenderImg = [[UIImageView alloc]init];
    self.userGenderImg.backgroundColor = [UIColor clearColor];
    [self.userInfoBackImg addSubview:self.userGenderImg];
    
    self.usernameLab = [[UILabel alloc]init];
    self.usernameLab.textAlignment = NSTextAlignmentCenter;
    self.usernameLab.backgroundColor = [UIColor clearColor];
    self.usernameLab.font = [UIFont systemFontOfSize:15];
    self.usernameLab.textColor = [UIColor whiteColor];
//    self.usernameLab.userInteractionEnabled = YES;
    [self.userNameBackImg addSubview:self.usernameLab];
    
    self.schoolNameLab = [[UILabel alloc]init];
    self.schoolNameLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.schoolNameLab.textAlignment = NSTextAlignmentCenter;
    self.schoolNameLab.textColor = APP_FONT_COLOR_NORMAL;
    [self.baseScrollView addSubview:self.schoolNameLab];
    
    self.keepedMoneyTitleLab = [[UILabel alloc]init];
    self.keepedMoneyTitleLab.text = @"账户资金";
    self.keepedMoneyTitleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.keepedMoneyTitleLab.backgroundColor = [UIColor clearColor];
    self.keepedMoneyTitleLab.textAlignment = NSTextAlignmentCenter;
    self.keepedMoneyTitleLab.textColor = APP_FONT_COLOR_NORMAL;
    [self.baseScrollView addSubview:self.keepedMoneyTitleLab];
    
    self.keepedMoneyNumLab = [[UILabel alloc]init];
    self.keepedMoneyNumLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.keepedMoneyNumLab.textColor = UserCenterKeepedMoneyNumColor;
    self.keepedMoneyNumLab.textAlignment = NSTextAlignmentCenter;
    self.keepedMoneyNumLab.backgroundColor = [UIColor clearColor];
    self.keepedMoneyNumLab.text = @"￥0.00";
    [self.baseScrollView addSubview:self.keepedMoneyNumLab];
    
    UIImage *vl = [UIImage imageNamed:@"user_center_vertical_line"];
    
    verticalLine1 = [[UIImageView alloc]init];
    verticalLine1.image = vl;
    [self.baseScrollView addSubview:verticalLine1];
    
    verticalLine2 = [[UIImageView alloc]init];
    verticalLine2.image = vl;
    [self.baseScrollView addSubview:verticalLine2];
    
    self.dealingMoneyTitleLab = [[UILabel alloc]init];
    self.dealingMoneyTitleLab.text = @"处理中";
    self.dealingMoneyTitleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.dealingMoneyTitleLab.backgroundColor = [UIColor clearColor];
    self.dealingMoneyTitleLab.textAlignment = NSTextAlignmentCenter;
    [self.baseScrollView addSubview:self.dealingMoneyTitleLab];
    
    self.dealingMoneyNumLab = [[UILabel alloc]init];
    self.dealingMoneyNumLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.dealingMoneyNumLab.textColor = UserCenterDealingMoneyNumColor;
    self.dealingMoneyNumLab.textAlignment = NSTextAlignmentCenter;
    self.dealingMoneyNumLab.backgroundColor = [UIColor clearColor];
    self.dealingMoneyTitleLab.textColor = APP_FONT_COLOR_NORMAL;
    self.dealingMoneyNumLab.text = @"￥0.00";
    [self.baseScrollView addSubview:self.dealingMoneyNumLab];
    
    self.takeNowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.takeNowBtn setImage:[UIImage imageNamed:@"user_center_money_take_now_btn_icon_normal"] forState:UIControlStateNormal];
    [self.takeNowBtn setImage:[UIImage imageNamed:@"user_center_money_take_now_btn_icon_pressed"] forState:UIControlStateHighlighted];
    [self.takeNowBtn setImage:[UIImage imageNamed:@"user_center_money_take_now_btn_icon_disable"] forState:UIControlStateDisabled];
    takeNow = [[UILabel alloc]init];
    takeNow.text = @"提现";
    takeNow.textColor = [UIColor whiteColor];
    takeNow.textAlignment = NSTextAlignmentCenter;
    takeNow.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.takeNowBtn.tag = 100;
    [self.takeNowBtn addSubview:takeNow];
    [self.baseScrollView addSubview:self.takeNowBtn];
    
    self.mySignUpBtn = [[ZGUserCenterBtnArea alloc]init];
    [self.mySignUpBtn.btn setImage: [UIImage imageNamed:@"user_center_my_sign_up_btn_icon_normal"] forState:UIControlStateNormal];
    [self.mySignUpBtn.btn setImage: [UIImage imageNamed:@"user_center_my_sign_up_btn_icon_pressed"] forState:UIControlStateHighlighted];
    self.mySignUpBtn.btnNameLab.text = @"我的报名";
    self.mySignUpBtn.btn.tag = 101;
    [self.baseScrollView addSubview:self.mySignUpBtn];
    
    self.myReadRecordBtn = [[ZGUserCenterBtnArea alloc]init];
    [self.myReadRecordBtn.btn setImage:[UIImage imageNamed:@"user_center_my_read_record_btn_icon_normal"]forState:UIControlStateNormal];
    [self.myReadRecordBtn.btn setImage:[UIImage imageNamed:@"user_center_my_read_record_btn_icon_pressed"]forState:UIControlStateHighlighted];
    self.myReadRecordBtn.btnNameLab.text = @"浏览记录";
    self.myReadRecordBtn.btn.tag = 102;
    [self.baseScrollView addSubview:self.myReadRecordBtn];
    
    self.myChangePwdBtn = [[ZGUserCenterBtnArea alloc]init];
    [self.myChangePwdBtn.btn setImage:[UIImage imageNamed:@"user_center_my_change_pwd_btn_icon_normal"]forState:UIControlStateNormal];
    [self.myChangePwdBtn.btn setImage:[UIImage imageNamed:@"user_center_my_change_pwd_btn_icon_pressed"]forState:UIControlStateHighlighted];
    self.myChangePwdBtn.btnNameLab.text = @"修改密码";
    self.myChangePwdBtn.btn.tag = 103;
    [self.baseScrollView addSubview:self.myChangePwdBtn];
    
    self.mySettingBtn = [[ZGUserCenterBtnArea alloc]init];
    [self.mySettingBtn.btn setImage:[UIImage imageNamed:@"user_center_my_setting_btn_icon_normal"] forState:UIControlStateNormal];
    [self.mySettingBtn.btn setImage:[UIImage imageNamed:@"user_center_my_setting_btn_icon_pressed"] forState:UIControlStateHighlighted];
    self.mySettingBtn.btnNameLab.text = @"设置";
    self.mySettingBtn.btn.tag = 104;
    [self.baseScrollView addSubview:self.mySettingBtn];
    
    self.myMoneyDetailBtn = [[ZGUserCenterBtnArea alloc]init];
    [self.myMoneyDetailBtn.btn setImage:[UIImage imageNamed:@"user_center_my_money_detail_btn_normal"] forState:UIControlStateNormal];
    [self.myMoneyDetailBtn.btn setImage:[UIImage imageNamed:@"user_center_my_money_detail_btn_pressed"] forState:UIControlStateHighlighted];
    self.myMoneyDetailBtn.btnNameLab.text = @"资金明细";
    self.myMoneyDetailBtn.btn.tag = 105;
    [self.baseScrollView addSubview:self.myMoneyDetailBtn];

    
    self.myAdviceBtn = [[ZGUserCenterBtnArea alloc]init];
    [self.myAdviceBtn.btn setImage:[UIImage imageNamed:@"user_center_my_advice_btn_icon_normal"] forState:UIControlStateNormal];
     [self.myAdviceBtn.btn setImage:[UIImage imageNamed:@"user_center_my_advice_btn_icon_pressed"] forState:UIControlStateHighlighted];
    self.myAdviceBtn.btnNameLab.text = @"提点意见";
    self.myAdviceBtn.btn.tag = 106;
    [self.baseScrollView addSubview:self.myAdviceBtn];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]init];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.baseScrollView addSubview:self.activityIndicatorView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseScrollView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
    
    self.headView.rightBtn.frame = CGRectMake(SCREEN_WIDTH - 65, HeadViewHeight - 33, 55, 25);
    
    self.userInfoBackImg.frame = CGRectMake(0, 0, SCREEN_WIDTH, UserCenterUserInfoBackHeight);
    
    self.userImg.frame = CGRectMake(SCREEN_WIDTH / 2 - UserCenterUserImgRadius,UserCenterUserInfoBackHeight - 2 * UserCenterUserImgRadius - 10, 2 * UserCenterUserImgRadius, 2 * UserCenterUserImgRadius);
    
    self.userGenderImg.frame = CGRectMake(self.userImg.frame.origin.x, self.userImg.frame.origin.y, 20, 20);
    
    self.userNameBackImg.frame = CGRectMake((SCREEN_WIDTH - UserCenterUserNameBackImgWidth) / 2, self.userInfoBackImg.frame.origin.y + self.userInfoBackImg.frame.size.height - 12, UserCenterUserNameBackImgWidth, UserCenterUserNameBackImgHeight);
    
    self.usernameLab.frame = CGRectMake(35, 11, 93, 24);
    
    self.schoolNameLab.frame = CGRectMake((SCREEN_WIDTH - UserCenterSchoolNameLabWidth) / 2, self.userNameBackImg.frame.origin.y + self.userNameBackImg.frame.size.height + 10, UserCenterSchoolNameLabWidth, UserCenterSchoolNameLabHeight);
    
    self.keepedMoneyTitleLab.frame = CGRectMake(23, self.schoolNameLab.frame.origin.y + self.schoolNameLab.frame.size.height + 10, 80, 15);
    self.keepedMoneyNumLab.frame = CGRectMake(13, self.schoolNameLab.frame.origin.y + self.schoolNameLab.frame.size.height + 30, 100, 20);
    if(IS_IPHONE6)
    {
        self.keepedMoneyTitleLab.frame = CGRectMake(50.5, self.schoolNameLab.frame.origin.y + self.schoolNameLab.frame.size.height + 10, 80, 15);
        self.keepedMoneyNumLab.frame = CGRectMake(40.5, self.schoolNameLab.frame.origin.y + self.schoolNameLab.frame.size.height + 30, 100, 20);
    }
    
    verticalLine1.frame = CGRectMake(113, self.keepedMoneyTitleLab.frame.origin.y + 3, 2, 32.5);
    verticalLine2.frame = CGRectMake(205, self.keepedMoneyTitleLab.frame.origin.y + 3, 2, 32.5);
    if(IS_IPHONE6)
    {
        verticalLine1.frame = CGRectMake(138.5, self.keepedMoneyTitleLab.frame.origin.y + 3, 2, 32.5);
        verticalLine2.frame = CGRectMake(232.5, self.keepedMoneyTitleLab.frame.origin.y + 3, 2, 32.5);
    }
    
    self.dealingMoneyTitleLab.frame = CGRectMake(verticalLine2.frame.origin.x + 10, self.schoolNameLab.frame.origin.y + self.schoolNameLab.frame.size.height + 10, 80, 15);
    self.dealingMoneyNumLab.frame = CGRectMake(verticalLine2.frame.origin.x+3, self.schoolNameLab.frame.origin.y + self.schoolNameLab.frame.size.height + 30, 100, 20);
    
    self.takeNowBtn.frame = CGRectMake((SCREEN_WIDTH - 63.5) / 2, verticalLine1.frame.origin.y + (verticalLine1.frame.size.height - 23) / 2, 63.5, 23);
    takeNow.frame = CGRectMake(0, 0, self.takeNowBtn.frame.size.width, self.takeNowBtn.frame.size.height);
    
    float spacing = (SCREEN_WIDTH - 3 * 85.5 - 2 * UserCenterBtnsFirstSpacing) / 2;
    self.mySignUpBtn.frame = CGRectMake(UserCenterBtnsFirstSpacing, self.takeNowBtn.frame.origin.y + self.takeNowBtn.frame.size.height + 20, 85.5, 97.5);
    self.myReadRecordBtn.frame = CGRectMake(self.mySignUpBtn.frame.origin.x + self.mySignUpBtn.frame.size.width + spacing, self.mySignUpBtn.frame.origin.y, 85.5, 97.5);
    self.myChangePwdBtn.frame = CGRectMake(self.myReadRecordBtn.frame.origin.x + self.myReadRecordBtn.frame.size.width + spacing, self.mySignUpBtn.frame.origin.y, 85.5, 97.5);
    self.mySettingBtn.frame = CGRectMake(self.mySignUpBtn.frame.origin.x , self.mySignUpBtn.frame.origin.y + self.mySignUpBtn.frame.size.height + UserCenterBtnsHSpacing, 85.5, 97.5);
    self.myMoneyDetailBtn.frame = CGRectMake(self.mySettingBtn.frame.origin.x + self.mySettingBtn.frame.size.width + spacing, self.mySignUpBtn.frame.origin.y + self.mySignUpBtn.frame.size.height + UserCenterBtnsHSpacing, 85.5, 97.5);
    self.myAdviceBtn.frame = CGRectMake(self.myMoneyDetailBtn.frame.origin.x + self.mySettingBtn.frame.size.width + spacing, self.mySignUpBtn.frame.origin.y + self.mySignUpBtn.frame.size.height + UserCenterBtnsHSpacing, 85.5, 97.5);
    
    self.activityIndicatorView.frame = CGRectMake(0, 0, 40, 40);
}

@end
