//
//  ZGWithdrawalDetailCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/11/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGWithdrawalDetailCell.h"

@implementation ZGWithdrawalDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.separator.frame = CGRectMake(0, WithdrawalDetailCellHeight - 0.5, SCREEN_WIDTH, 0.5);
        
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 65, WithdrawalDetailCellHeight)];
        self.titleLab.backgroundColor = [UIColor clearColor];
        self.titleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.titleLab.textColor = APP_FONT_COLOR_NORMAL;
        [self.contentView addSubview:self.titleLab];
        
        self.contentText = [[UITextField alloc]initWithFrame:CGRectMake(90, 0, 175, WithdrawalDetailCellHeight)];
        self.contentText.backgroundColor = [UIColor clearColor];
        self.contentText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.contentText.textColor = APP_FONT_COLOR_NORMAL;
        [self.contentView addSubview:self.contentText];
        
        self.rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(282, (WithdrawalDetailCellHeight - 18) / 2, 24.5, 18)];
        self.rightImg.backgroundColor = [UIColor clearColor];
        self.rightImg.image = [UIImage imageNamed:@"widrawal_bank_card_icon"];
        self.rightImg.hidden = YES;
        [self.contentView addSubview:self.rightImg];
    }
    return self;
}

@end
