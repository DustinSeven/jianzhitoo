//
//  ZGAdviceViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#define AdviceTextBorderColorNormal [UIColor colorWithRed:161.0f / 255.0f green:168.0f / 255.0f blue:176.0f / 255.0f alpha:1.0f]

#define AdviceTextPlaceHolderColor [UIColor colorWithRed:198.0f / 255.0f green:198.0f / 255.0f blue:198.0f / 255.0f alpha:1.0f]

#define AdviceTextWidth 284
#define AdviceTextHeight 112

#define AdviceBtnWidth 240
#define AdviceBtnHeight 40

#define AdviceBtnBackgroundNormal [UIColor colorWithRed:253.0f / 255.0f green:153.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f]
#define AdviceBtnBackgroundPressed [UIColor colorWithRed:219.0f / 255.0f green:139.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f]

@interface ZGAdviceViewBase : ZGBaseView

@property (nonatomic , strong)ZGHeadView *headView;
@property (nonatomic , strong)UITextView *adviceText;
@property (nonatomic , strong)UIButton *adviceBtn;

@property (nonatomic , strong)UILabel *adviceTextPlaceHolderLab;
@property (nonatomic , strong)NSString *placeHolder;

@end
