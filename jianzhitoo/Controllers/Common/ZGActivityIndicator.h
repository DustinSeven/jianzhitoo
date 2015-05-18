//
//  ZGActivityIndicator.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/19/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseView.h"

#define AnimationDuration 1.2
#define AnimationRepeat 99999

#define ImgLeftViewWidth 31
#define ImgLeftViewHeight 31

#define ImgRightViewWidth 75.5
#define ImgRightViewHeight 24.5

#define BackViewWidth 140
#define BackViewHeight 40

@interface ZGActivityIndicator : ZGBaseView

@property (nonatomic , strong) UIImage *imgLeft;
@property (nonatomic , strong) UIImage *imgRight;
@property (nonatomic , assign) BOOL hideWhenAnimationStop;
@property (nonatomic , strong) UIView *fatherView;
@property (nonatomic , strong) UIColor *color;
@property (nonatomic , strong) ZGBaseView *backView;

- (void)startAnimation;
- (void)stopAnimation;
- (id)initWithView:(UIView *)view;

@end
