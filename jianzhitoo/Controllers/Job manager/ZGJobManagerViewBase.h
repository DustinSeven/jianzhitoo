//
//  ZGJobManagerViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/4.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGBaseView.h"

#define JobManagerListSeparatorColor [UIColor colorWithRed:196.0f / 255.0f green:196.0f / 255.0f blue:196.0f / 255.0f alpha:1.0f]

#define JobManagerSignInBtnBackgroundNormal [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]
#define JobManagerSignInBtnBackgroundPressed [UIColor colorWithRed:219.0f / 255.0f green:139.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f]

#define JobManagerListCellHeight 50

#define JobManagerSignInBtnWidth 245
#define JobManagerSignInBtnHeight 40

@interface ZGJobManagerViewBase : ZGBaseView

@property (nonatomic , strong) UITableView *baseTableView;

@property (nonatomic , strong) UIButton *signInBtn;

@end
