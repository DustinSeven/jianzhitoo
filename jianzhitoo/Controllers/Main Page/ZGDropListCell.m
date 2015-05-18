//
//  ZGDropListCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/18/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGDropListCell.h"

@implementation ZGDropListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.textLabel.textColor = APP_FONT_COLOR_NORMAL;
        
        self.separator.frame = CGRectMake(0,MainPageFilterListHeight - 0.5, SCREEN_WIDTH, 0.5);
    }
    return self;
}

@end
