//
//  ZGMoneyDetailListCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMoneyDetailListCell.h"
#import "ZGMoneyDetailViewBase.h"

@implementation ZGMoneyDetailListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.moneyTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 20)];
        self.moneyTypeLab.backgroundColor = [UIColor clearColor];
        self.moneyTypeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.contentView addSubview:self.moneyTypeLab];
        
        self.moneyTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 140, 20)];
        self.moneyTimeLab.backgroundColor = [UIColor clearColor];
        self.moneyTimeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.moneyTimeLab.textColor = MoneyDetailMoneyTimeColor;
        [self.contentView addSubview:self.moneyTimeLab];
        
        self.moneyNumLab = [[UILabel alloc]initWithFrame:CGRectMake(210, 30, 100, 20)];
        self.moneyNumLab.backgroundColor = [UIColor clearColor];
        self.moneyNumLab.textAlignment = NSTextAlignmentRight;
        self.moneyNumLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.moneyNumLab.textColor = MoneyDetailMoneyNumColor;
        [self.contentView addSubview:self.moneyNumLab];
        
        self.separator.frame = CGRectMake(0, MoneyDetailListCellHeight - 0.5, SCREEN_WIDTH, 0.5);
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
