//
//  ZGUpdateAlertView.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/11/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAlertViewBase.h"
#import "ZGUpdateInfoEntity.h"

#define TitleHeight 30
#define LineHeight 2

#define BaseViewWidth 250
#define BtnWidth (BaseViewWidth - 10 - 10 - 10) / 2
#define BtnHeight 30

#define UpdateBtnBackgroundNormal [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]
#define UpdateBtnBackgroundPressed [UIColor colorWithRed:219.0f / 255.0f green:139.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f]
#define CancelBtnBackgroundNormal [UIColor colorWithRed:166.0f / 255.0f green:166.0f / 255.0f blue:166.0f / 255.0f alpha:1.0f]
#define CancelBtnBackgroundPressed [UIColor colorWithRed:236.0f / 255.0f green:236.0f / 255.0f blue:236.0f / 255.0f alpha:1.0f]

#define LineColor [UIColor colorWithRed:213.0f / 255.0f green:213.0f / 255.0f blue:213.0f / 255.0f alpha:1.0f]

@interface ZGUpdateAlertView : ZGBaseView

@property (nonatomic , strong) ZGBaseView *baseView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) ZGBaseView *line;
@property (nonatomic , strong) UILabel *contentLab;
@property (nonatomic , strong) UIButton *updateBtn;
@property (nonatomic , strong) UIButton *cancelBtn;

@property (nonatomic , strong) UIView *fatherView;
@property (nonatomic , strong) ZGUpdateInfoEntity *updateInfoEntity;

- (id)initWithView:(UIView *)view;
- (void)showAlertWithEntity:(ZGUpdateInfoEntity *)entity;
- (void)alertDismiss:(UIButton *)button;
@end
