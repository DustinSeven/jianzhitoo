//
//  ZGFailImgAlertView.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/26/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGFailImgAlertViewIphone.h"

@implementation ZGFailImgAlertViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        self.img = [[UIImageView alloc]init];
        self.img.backgroundColor = [UIColor clearColor];
        self.img.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTouched:)];
        [self.img addGestureRecognizer:tap];
        [self addSubview:self.img];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)imgTouched:(UITapGestureRecognizer *)recognize
{
    [self.delegate tapOnAlertView];
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


- (void)showAlertWithImg:(UIImage *)img frame:(CGRect)rect delegate:(id<ZGFailImgAlertViewIphoneDelegate>) delegate fatherView:(UIView *)fatherView
{
    self.img.image = img;
    self.img.frame = rect;
    self.delegate = delegate;
    self.fatherView = fatherView;
    
    self.hidden = NO;
}

- (void)alertDismiss:(UIButton *)button
{
    self.hidden = YES;
}

- (void)layoutSubviews
{
}


@end
