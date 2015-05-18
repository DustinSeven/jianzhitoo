//
//  ZGDropDownList.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/7/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseView.h"

@interface ZGDropDownList : ZGBaseView

@property (nonatomic , strong) UITableView *baseTableView;

@property (nonatomic , strong) ZGBaseView *baseView;

@property (nonatomic , strong) UIActivityIndicatorView *activityView;

@end
