//
//  ZGUserInfoCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUserInfoCell.h"

@implementation ZGUserInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.leftLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 115, UserInfoCellHeight)];
        self.leftLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.leftLab.textColor = APP_FONT_COLOR_NORMAL;
        self.leftLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftLab];
        
        self.rightLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 0, 185, UserInfoCellHeight)];
        self.rightLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.rightLab.textColor = APP_FONT_COLOR_THIN;
        self.rightLab.backgroundColor = [UIColor clearColor];
        self.rightLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.rightLab];
        
        self.rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(225, UserInfoCellUserImgHeight / 2 - 32.5, 65, 65)];
        if(IS_IPHONE6)
            self.rightImg.frame= CGRectMake(280, UserInfoCellUserImgHeight / 2 - 32.5, 65, 65);
        self.rightImg.backgroundColor = [UIColor whiteColor];
//        self.rightImg.layer.borderWidth = 2;
//        self.rightImg.layer.borderColor = [UIColor whiteColor].CGColor;
        self.rightImg.layer.masksToBounds = YES;
        self.rightImg.layer.cornerRadius = 32.5;
        self.rightImg.hidden = YES;
        [self.contentView addSubview:self.rightImg];
        
       self.separator.frame = CGRectMake(0, UserInfoCellHeight - 0.5, SCREEN_WIDTH, 0.5);

    }
    return self;
}

- (void)setImgCell
{
    self.leftLab.frame = CGRectMake(15, 0, 115, UserInfoCellUserImgHeight);
    self.separator.frame = CGRectMake(0, UserInfoCellUserImgHeight - 0.5, SCREEN_WIDTH, 0.5);
}
@end
