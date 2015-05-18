//
//  ZGContactCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/9.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGContactCell.h"

@implementation ZGContactCell

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
        
        self.userImg = [[UIImageView alloc]initWithFrame:CGRectMake(14, 5, ContactCellRowHeight - 10, ContactCellRowHeight - 10)];
        self.userImg.backgroundColor = [UIColor clearColor];
        self.userImg.layer.cornerRadius = 5;
        self.userImg.layer.masksToBounds = YES;
        [self.contentView addSubview:self.userImg];
        
        self.userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg.frame) + 10,0 ,SCREEN_WIDTH - 28,ContactCellRowHeight)];
        self.userNameLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.userNameLab.textColor = APP_FONT_COLOR_NORMAL;
        [self.contentView addSubview:self.userNameLab];
        
    }
    return self;
}


@end
