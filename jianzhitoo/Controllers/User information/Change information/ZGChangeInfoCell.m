//
//  ZGChangeInfoCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/17/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGChangeInfoCell.h"

@implementation ZGChangeInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.separator = [[ZGBaseView alloc]init];
        self.separator.backgroundColor = [UIColor colorWithRed:196.0f / 255.0f green:196.0f / 255.0f blue:196.0f / 255.0f alpha:1.0f];
        [self.contentView addSubview:self.separator];
        
        self.separator.frame = CGRectMake(0, ChangeInfoCellHeight - 0.5, SCREEN_WIDTH, 0.5);
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = CELL_SELECTED_COLOR;
        
        self.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.textLabel.textColor = APP_FONT_COLOR_NORMAL;
    }
    return self;
}

@end
