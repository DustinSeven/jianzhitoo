//
//  ZGRegistrationViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/13/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "GMGridView.h"


#define RegistrationCellWithHeight 55

#define RegistrationSubmitBtnBackgroundNormal [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]
#define RegistrationSubmitBtnBackgroundPressed [UIColor colorWithRed:219.0f / 255.0f green:139.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f]

#define RegistrationSubmitBtnWidth 242.5
#define RegistrationSubmitBtnHeight 40

@interface ZGRegistrationViewBase : ZGBaseView

@property (nonatomic , strong) GMGridView *baseGridView;

@property (nonatomic , strong) UIImageView *titleIcon;

@property (nonatomic , strong) UILabel *titleLab;

@property (nonatomic , strong) UIButton *submitBtn;

@property (nonatomic , strong) UILabel *noticeLab;

@end
