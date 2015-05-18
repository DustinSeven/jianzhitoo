//
//  ZGSchoolmateViewBase.h
//  jianzhitoo
//
//  Created by 李明伟 on 12/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseView.h"
#import "GMGridView.h"

#define SchoolmateCellWithHeight 55

@interface ZGSchoolmateViewBase : ZGBaseView

@property (nonatomic , strong) ZGHeadView *headView;

@property (nonatomic , strong) GMGridView *baseGridView;

@end
