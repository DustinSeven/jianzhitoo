//
//  ZGUserCenterBtn.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUserCenterBtnArea.h"


@implementation ZGUserCenterBtnArea

- (id)init
{
    self = [super init];
    if(self)
    {
        self.lineFrameImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 85.5, 97.5)];
        self.lineFrameImg.image = [UIImage imageNamed:@"user_center_btn_line_frame"];
        [self addSubview:self.lineFrameImg];
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = CGRectMake((85.5 - 62) / 2, 8, 62, 66);
        [self addSubview:self.btn];
        
        self.btnNameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.btn.frame.origin.y + self.btn.frame.size.height + 3, 85.5, 15)];
        self.btnNameLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.btnNameLab.textAlignment = NSTextAlignmentCenter;
        self.btnNameLab.textColor = APP_FONT_COLOR_NORMAL;
        [self addSubview:self.btnNameLab];
    }
    return self;
}

@end
