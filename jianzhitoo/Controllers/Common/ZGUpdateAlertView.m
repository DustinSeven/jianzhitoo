//
//  ZGUpdateAlertView.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/11/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUpdateAlertView.h"

@implementation ZGUpdateAlertView

- (id)init
{
    self = [super init];
    if(self)
    {
        self.baseView = [[ZGBaseView alloc]init];
        self.baseView.backgroundColor = [UIColor whiteColor];
        self.baseView.layer.cornerRadius = 5;
        self.baseView.layer.masksToBounds = YES;
        [self addSubview:self.baseView];
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.backgroundColor = [UIColor clearColor];
        self.titleLab.text = @"发现新版本";
        self.titleLab.textColor = HeadViewBackground;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL + 3];
        [self.baseView addSubview:self.titleLab];
        
        self.line = [[ZGBaseView alloc]init];
        self.line.backgroundColor = LineColor;
        [self.baseView addSubview:self.line];
        
        self.contentLab = [[UILabel alloc]init];
        self.contentLab.backgroundColor = [UIColor clearColor];
        self.contentLab.textColor = APP_FONT_COLOR_THIN;
//        self.contentLab.textAlignment = NSTextAlignmentCenter;
        self.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.contentLab.lineBreakMode = NSLineBreakByWordWrapping;
        self.contentLab.numberOfLines = 0;
        [self.baseView addSubview:self.contentLab];
        
        self.updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        self.updateBtn.layer.cornerRadius = 3;
        self.updateBtn.layer.masksToBounds = YES;
        self.updateBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
//        self.updateBtn.layer.borderColor = APP_FONT_COLOR_THIN.CGColor;
//        self.updateBtn.layer.borderWidth = 0.5;
        [self.updateBtn setBackgroundImage:[ZGUtility imageWithColor:UpdateBtnBackgroundNormal size:CGSizeMake(BtnWidth, BtnHeight)] forState:UIControlStateNormal];
        [self.updateBtn setBackgroundImage:[ZGUtility imageWithColor:UpdateBtnBackgroundPressed size:CGSizeMake(BtnWidth, BtnHeight)] forState:UIControlStateHighlighted];
        [self.baseView addSubview:self.updateBtn];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelBtn setTitle:@"取消更新" forState:UIControlStateNormal];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.cancelBtn.layer.cornerRadius = 3;
        self.cancelBtn.layer.masksToBounds = YES;
//        self.cancelBtn.layer.borderColor = APP_FONT_COLOR_THIN.CGColor;
//        self.cancelBtn.layer.borderWidth = 0.5;
        [self.cancelBtn setBackgroundImage:[ZGUtility imageWithColor:CancelBtnBackgroundNormal size:CGSizeMake(BtnWidth, BtnHeight)] forState:UIControlStateNormal];
        [self.cancelBtn setBackgroundImage:[ZGUtility imageWithColor:CancelBtnBackgroundPressed size:CGSizeMake(BtnWidth, BtnHeight)] forState:UIControlStateHighlighted];
        [self.baseView addSubview:self.cancelBtn];
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

- (void)setUpdateInfoEntity:(ZGUpdateInfoEntity *)updateInfoEntity
{
    self.titleLab.frame = CGRectMake(0, 0, BaseViewWidth, TitleHeight);
    self.line.frame = CGRectMake(10, TitleHeight, BaseViewWidth - 20, LineHeight);
    NSString *content = @"最新版本：";
    content = [[content stringByAppendingString:updateInfoEntity.versionName] stringByAppendingString:@"\n"];
    content = [[[content stringByAppendingString:@"新版本大小："] stringByAppendingString:updateInfoEntity.fileSize] stringByAppendingString:@"\n\n"];
    content = [[content stringByAppendingString:@"更新内容："] stringByAppendingString:updateInfoEntity.updateInfo];
    self.contentLab.text = content;
    CGSize size = [self.contentLab sizeThatFits:CGSizeMake(BaseViewWidth - 20, 0)];
    self.contentLab.frame = CGRectMake(10, self.line.frame.origin.y + self.line.frame.size.height + 10, BaseViewWidth - 20, size.height);
    self.updateBtn.frame = CGRectMake(10, self.contentLab.frame.origin.y + self.contentLab.frame.size.height + 20, BtnWidth, BtnHeight);
    self.cancelBtn.frame = CGRectMake(self.updateBtn.frame.origin.x + self.updateBtn.frame.size.width + 10, self.contentLab.frame.origin.y + self.contentLab.frame.size.height + 20, BtnWidth, BtnHeight);
    
    self.baseView.frame = CGRectMake((SCREEN_WIDTH - BaseViewWidth) / 2, (SCREEN_HEIGHT - (self.updateBtn.frame.origin.y + self.updateBtn.frame.size.height + 10)) / 2, BaseViewWidth, self.updateBtn.frame.origin.y + self.updateBtn.frame.size.height + 20);
    
    self.backgroundColor = [UIColor colorWithRed:0.0f / 255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:0.2f];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}


- (void)showAlertWithEntity:(ZGUpdateInfoEntity *)entity
{
    if(entity)
        self.updateInfoEntity = entity;
    self.hidden = NO;
    [ZGUtility view:self.baseView appearAt:CGPointMake(SCREEN_WIDTH/ 2, SCREEN_HEIGHT / 2 + 20) withDalay:0.6 duration:0.2];
}

- (void)alertDismiss:(UIButton *)button
{
    
    self.hidden = YES;
}


@end
