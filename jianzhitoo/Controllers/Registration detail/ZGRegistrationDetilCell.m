//
//  ZGRegistrationDetilCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegistrationDetilCell.h"
#import "ZGRegistrationDetailViewBase.h"

@implementation ZGRegistrationDetilCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
            
        self.dateLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, RegisterDetailCellDateLabWidth, RegisterDetailCellDateLabHeight)];
        self.dateLab.layer.cornerRadius = 3;
        self.dateLab.layer.borderWidth = 1;
        self.dateLab.layer.borderColor = RegisterDetailBtnColor.CGColor;
        self.dateLab.textColor = RegisterDetailBtnColor;
        self.dateLab.textAlignment = NSTextAlignmentCenter;
        self.dateLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.contentView addSubview:self.dateLab];
        
        self.statusLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.dateLab.frame) + 10, 0, SCREEN_WIDTH - (CGRectGetMaxX(self.dateLab.frame) + 10) - 15, RegisterDetailStatusCellHeight)];
        self.statusLab.textAlignment = NSTextAlignmentRight;
        self.statusLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.contentView addSubview:self.statusLab];
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
