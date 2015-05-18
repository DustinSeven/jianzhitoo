//
//  ZGSearchHistoryCell.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/4/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseTableViewCell.h"

#define SearchHistoryCellHight 40

@interface ZGSearchHistoryCell : ZGBaseTableViewCell

@property (nonatomic , strong) UILabel *keyWordText;
@property (nonatomic , strong) UILabel *filterText;
@property (nonatomic , strong) UILabel *dateText;

@end
