//
//  ZGFailImgAlertView.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/26/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAlertViewBase.h"

@protocol ZGFailImgAlertViewIphoneDelegate <NSObject>

- (void)tapOnAlertView;

@end

@interface ZGFailImgAlertViewIphone : ZGBaseView

@property (nonatomic , strong) UIView *fatherView;
@property (nonatomic , strong) UIImageView *img;
@property (nonatomic , strong) id<ZGFailImgAlertViewIphoneDelegate> delegate;

- (void)showAlertWithImg:(UIImage *)img frame:(CGRect)rect delegate:(id<ZGFailImgAlertViewIphoneDelegate>) delegate fatherView:(UIView *)fatherView;
- (id)initWithView:(UIView *)view;

@end
