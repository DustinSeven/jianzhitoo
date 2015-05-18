//
//  ZGActivityIndicator.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/19/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGActivityIndicator.h"

@interface ZGActivityIndicator()
{
    UIImageView *_imgViewLeft;
    UIImageView *_imgViewRight;
}

@end

@implementation ZGActivityIndicator

- (id)initWithView:(UIView *)view
{
    self = [super init];
    if(self)
    {
        self.fatherView = view;
        [self initWitgets];
    }
    return self;
}

- (void)initWitgets
{
    self.hideWhenAnimationStop = YES;
    
    self.backView = [[ZGBaseView alloc]init];
    self.backView.backgroundColor = VIEW_BACKGROUND;
    self.backView.layer.cornerRadius = 5;
    [self addSubview:self.backView];
    
    _imgViewLeft = [[UIImageView alloc]init];
    _imgViewLeft.backgroundColor = [UIColor clearColor];
    _imgViewLeft.image = [UIImage imageNamed:@"zgactivity_indicator_img"];
    [self.backView addSubview:_imgViewLeft];
    
    _imgViewRight = [[UIImageView alloc]init];
    _imgViewRight.backgroundColor = [UIColor clearColor];
    _imgViewRight.image = [UIImage imageNamed:@"zgactivity_indicator_word"];
    [self.backView addSubview:_imgViewRight];
    
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setAnimation:(UIView *)view
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = AnimationDuration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = AnimationRepeat;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)startAnimation
{
    self.hidden = NO;
}


- (void)stopAnimation
{
    if(self.hideWhenAnimationStop)
        self.hidden = YES;
}

- (void)setImgLeft:(UIImage *)imgLeft
{
    _imgViewLeft.image = imgLeft;
}

- (void)setImgRight:(UIImage *)imgRight
{
    _imgViewRight.image = imgRight;
}

- (void)setFatherView:(UIView *)fatherView
{
    self.frame = CGRectMake(0, HeadViewHeight , SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
}

- (void)setColor:(UIColor *)color
{
    self.backgroundColor = color;
}

- (void)layoutSubviews
{
    self.backView.frame = CGRectMake((self.frame.size.width - BackViewWidth) / 2, (self.frame.size.height - BackViewHeight) / 2 - HeadViewHeight, BackViewWidth, BackViewHeight);
    
    _imgViewLeft.frame = CGRectMake(12, 4, ImgLeftViewWidth, ImgLeftViewHeight);
    [self setAnimation:_imgViewLeft];
    
    _imgViewRight.frame = CGRectMake(CGRectGetMaxX(_imgViewLeft.frame) + 10, 7, ImgRightViewWidth, ImgRightViewHeight);
}

@end
