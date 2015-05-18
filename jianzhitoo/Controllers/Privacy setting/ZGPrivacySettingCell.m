//
//  ZGPrivacySettingCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGPrivacySettingCell.h"


@implementation ZGPrivacySettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 230, PrivacyCellHeight)];
        self.titleLab.backgroundColor = [UIColor clearColor];
        self.titleLab.text = @"信息公开给校友";
        self.titleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.contentView addSubview:self.titleLab];
        
        ZGBaseView *line = [[ZGBaseView alloc]initWithFrame:CGRectMake(0, PrivacyCellHeight - 0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = PrivacySettingListSeparatorColor;
        [self.contentView addSubview:line];
        
        self.priSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 7, 20, 10)];
        self.priSwitch.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.priSwitch];
        
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
