//
//  ZGSessionDetailViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/12.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGBaseView.h"

#define SessionDetailViewColor [UIColor colorWithRed:230.0f / 255.0f green:230.0f / 255.0f blue:230.0f / 255.0f alpha:1.0f]
#define BottomViewColor [UIColor colorWithRed:240.0f / 255.0f green:240.0f / 255.0f blue:240.0f / 255.0f alpha:1.0f]
#define BottomViewBorderColor [UIColor colorWithRed:173.0f / 255.0f green:173.0f / 255.0f blue:173.0f / 255.0f alpha:1.0f]
#define BottomViewHeight 70


#define ChatTextBorderColor [UIColor colorWithRed:100.0f / 255.0f green:100.0f / 255.0f blue:100.0f / 255.0f alpha:1.0f]
#define ChatTextHeight 40
#define ChatTextWidth (SCREEN_WIDTH - 100)

#define SendBtnHeight 40
#define SendBtnWidth 50



@interface ZGSessionDetailViewBase : ZGBaseView

@property (nonatomic , strong) ZGBaseView *bottomBackView;
@property (nonatomic , strong) UITextField *chatTextField;
@property (nonatomic , strong) UIButton *sendBtn;

@property (nonatomic , strong) UITableView *baseTableView;

@end
