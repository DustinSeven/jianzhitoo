//
//  ZGSchoolmateCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSchoolmateCell.h"

@implementation ZGSchoolmateCell

- (id)init
{
    self = [super init];
    if(self)
    {
        self.schoolmateImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SchoolmateCellWithHeight, SchoolmateCellWithHeight)];
        self.schoolmateImg.backgroundColor = [UIColor clearColor];
        self.schoolmateImg.layer.cornerRadius = SchoolmateCellWithHeight / 2;
        self.schoolmateImg.layer.masksToBounds = YES;
        [self addSubview:self.schoolmateImg];
        
        self.schoolmateLab = [[UILabel alloc]initWithFrame:CGRectMake(0, SchoolmateCellWithHeight, SchoolmateCellWithHeight, 20)];
        self.schoolmateLab.backgroundColor = [UIColor clearColor];
        self.schoolmateLab.textAlignment = NSTextAlignmentCenter;
        self.schoolmateLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL - 3];
        self.schoolmateLab.textColor = APP_FONT_COLOR_NORMAL;
        [self addSubview:self.schoolmateLab];
    }
    return self;
}


@end
