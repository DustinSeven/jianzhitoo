//
//  ZGLeftMenuCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/4.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGLeftMenuCell.h"
#import "ZGLeftMenuViewBase.h"

@implementation ZGLeftMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.leftImg = [[UIImageView alloc]init];
        self.leftImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftImg];
        
        self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 100, LeftMenuTableViewRowHeight)];
        self.contentLab.textColor = [UIColor whiteColor];
        self.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL + 5];
        [self.contentView addSubview:self.contentLab];
        
        UIView *selectedView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LeftMenuTableViewRowHeight)];
        selectedView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.1];
        self.selectedBackgroundView = selectedView;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
