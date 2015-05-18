//
//  ZGBankCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBankCell.h"

@implementation ZGBankCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.separator.frame = CGRectMake(0, BankCellHeight - 0.5, SCREEN_WIDTH, 0.5);
        
        self.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.textLabel.textColor = APP_FONT_COLOR_NORMAL;
    }
    return self;
}

@end
