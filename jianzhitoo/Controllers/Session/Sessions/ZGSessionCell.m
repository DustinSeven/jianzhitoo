//
//  ZGSessionCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/6.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGSessionCell.h"

@implementation ZGSessionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = CELL_SELECTED_COLOR;
        
//        ZGBaseView *separator = [[ZGBaseView alloc]initWithFrame:CGRectMake(10, SessionCellRowHeight - 0.5, SCREEN_WIDTH + 1000, 0.5)];
//        separator.backgroundColor = SeparatorColor;
//        [self.contentView addSubview:separator];
        
        self.userImg = [[UIImageView alloc]initWithFrame:CGRectMake(14, 10, SessionCellRowHeight - 20, SessionCellRowHeight - 20)];
        self.userImg.backgroundColor = [UIColor clearColor];
        self.userImg.layer.cornerRadius = 5;
        self.userImg.layer.masksToBounds = YES;
        [self.contentView addSubview:self.userImg];
        
        self.userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(self.userImg.frame.origin.x + self.userImg.frame.size.width + 10, 10, (SCREEN_WIDTH - (self.userImg.frame.origin.x + self.userImg.frame.size.width + 10) - (SessionCellTimeLabWidth + 10)), SessionCellRowHeight / 2 - 10)];
        self.userNameLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.userNameLab.textColor = APP_FONT_COLOR_NORMAL;
//        self.userNameLab.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.userNameLab];
        
        self.descriptionLab = [[UILabel alloc]initWithFrame:CGRectMake(self.userImg.frame.origin.x + self.userImg.frame.size.width + 10, SessionCellRowHeight / 2, (SCREEN_WIDTH - (self.userImg.frame.origin.x + self.userImg.frame.size.width + 10) - 10), SessionCellRowHeight / 2 - 10)];
        self.descriptionLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL - 3];
        self.descriptionLab.textColor = APP_FONT_COLOR_THIN;
//        self.descriptionLab.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.descriptionLab];
        
        self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.userNameLab.frame.origin.x + self.userNameLab.frame.size.width + 10, 10, SessionCellTimeLabWidth - 10, self.userNameLab.frame.size.height)];
//        self.timeLab.backgroundColor = [UIColor blueColor];
        self.timeLab.textColor = APP_FONT_COLOR_THIN;
        self.timeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL - 3];
        self.timeLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.timeLab];
        
    }
    return self;
}

@end
