//
//  ZGRegistrationSuccessViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegistrationSuccessViewIphone.h"

@interface ZGRegistrationSuccessViewIphone()
{
    UILabel *connectBtnLab;
    UILabel *shareBtnLab;
}

@end

@implementation ZGRegistrationSuccessViewIphone

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
    
    self.noticeLab = [[UILabel alloc]init];
    self.noticeLab.backgroundColor = [UIColor clearColor];
    self.noticeLab.lineBreakMode = NSLineBreakByWordWrapping;
    self.noticeLab.numberOfLines = 0;
    self.noticeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL + 2];
    self.noticeLab.textColor = APP_FONT_COLOR_NORMAL;
    [self addSubview:self.noticeLab];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"您已成功报名兼职，记得每天做完兼职要签到哦~如有疑问请及时联系客服。"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str.string length])];
    self.noticeLab.attributedText = str;
    
    self.connectServerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.connectServerBtn.backgroundColor = [UIColor clearColor];
    [self.connectServerBtn setImage:[UIImage imageNamed:@"registration_connect_btn_icon_normal"] forState:UIControlStateNormal];
    [self.connectServerBtn setImage:[UIImage imageNamed:@"registration_connect_btn_icon_pressed"] forState:UIControlStateHighlighted];
    [self addSubview:self.connectServerBtn];
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.backgroundColor = [UIColor clearColor];
    [self.shareBtn setImage:[UIImage imageNamed:@"registration_share_btn_icon_normal"] forState:UIControlStateNormal];
    [self.shareBtn setImage:[UIImage imageNamed:@"registration_share_btn_icon_pressed"] forState:UIControlStateHighlighted];
    [self addSubview:self.shareBtn];
    
    connectBtnLab = [[UILabel alloc]init];
    connectBtnLab.backgroundColor = [UIColor clearColor];
    connectBtnLab.textColor = APP_FONT_COLOR_NORMAL;
    connectBtnLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    connectBtnLab.text = @"联系商家";
    connectBtnLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:connectBtnLab];
    
    shareBtnLab = [[UILabel alloc]init];
    shareBtnLab.backgroundColor = [UIColor clearColor];
    shareBtnLab.textColor = APP_FONT_COLOR_NORMAL;
    shareBtnLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    shareBtnLab.text = @"分享给好友";
    shareBtnLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:shareBtnLab];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.noticeLab.frame = CGRectMake((SCREEN_WIDTH - 260) / 2, HeadViewHeight + 20, 260, 90);
    
    self.connectServerBtn.frame = CGRectMake(65, self.noticeLab.frame.origin.y + self.noticeLab.frame.size.height + 20, 62, 66);
    self.shareBtn.frame = CGRectMake(SCREEN_WIDTH - self.connectServerBtn.frame.origin.x - self.connectServerBtn.frame.size.width, self.connectServerBtn.frame.origin.y, 62, 66);
    
    connectBtnLab.frame = CGRectMake(self.connectServerBtn.frame.origin.x + self.connectServerBtn.frame.size.width / 2 - 70 / 2, self.connectServerBtn.frame.origin.y + self.connectServerBtn.frame.size.height + 10, 70, 20);
    shareBtnLab.frame = CGRectMake(self.shareBtn.frame.origin.x + self.shareBtn.frame.size.width / 2 - 100 / 2, self.shareBtn.frame.origin.y + self.shareBtn.frame.size.height + 10, 100, 20);
}

@end
