//
//  ZGAboutUsViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAboutUsViewIphone.h"

@implementation ZGAboutUsViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = VIEW_BACKGROUND;
        
        self.baseImgView = [[UIImageView alloc]init];
        self.baseImgView.backgroundColor = [UIColor clearColor];
        if(IS_IPHONE4)
            self.baseImgView.image = [UIImage imageNamed:@"about_us_img_640x834"];
        if(IS_IPHONE5)
            self.baseImgView.image = [UIImage imageNamed:@"about_us_img_640x1008"];
        if(IS_IPHONE6)
            self.baseImgView.image = [UIImage imageNamed:@"about_us_img_750x1208"];
        [self addSubview:self.baseImgView];
    }
    return self;
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.baseImgView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
}

@end
