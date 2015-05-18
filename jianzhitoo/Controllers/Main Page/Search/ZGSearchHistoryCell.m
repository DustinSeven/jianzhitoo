//
//  ZGSearchHistoryCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/4/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSearchHistoryCell.h"



@implementation ZGSearchHistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.separator.frame = CGRectMake(0, SearchHistoryCellHight - 0.5, SCREEN_WIDTH, 0.5);
        
        self.keyWordText = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 180, 20)];
        self.keyWordText.backgroundColor = [UIColor clearColor];
        self.keyWordText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.keyWordText.textColor = APP_FONT_COLOR_NORMAL;
        [self.contentView addSubview:self.keyWordText];
        
        self.filterText = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 300, 20)];
        self.filterText.backgroundColor = [UIColor clearColor];
        self.filterText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL - 3];
        self.filterText.textColor = APP_FONT_COLOR_THIN;
        [self.contentView addSubview:self.filterText];
        
        self.dateText = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 100, 0, 100, 20)];
        self.dateText.backgroundColor = [UIColor clearColor];
        self.dateText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL - 5];
        self.dateText.textColor = APP_FONT_COLOR_THIN;
        [self.contentView addSubview:self.dateText];
    }
    return self;
}

@end
