//
//  ZGAlertViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//


@interface ZGAlertViewBase : ZGBaseView<UIGestureRecognizerDelegate>

@property (nonatomic , strong)UITapGestureRecognizer *baseRecognizer;
@property (nonatomic , assign)BOOL isBackViewEntable;

@end
