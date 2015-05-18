//
//  ZGSocialContactViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/6.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGSocialContactViewIphone.h"

@interface ZGSocialContactViewIphone()
{
    NSArray *segmentedArray;
}

@end

@implementation ZGSocialContactViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        [self initWitgets];
    }
    return self;
}

- (void)initWitgets
{
    self.backgroundColor = VIEW_BACKGROUND;
    
    segmentedArray = [[NSArray alloc]initWithObjects:@"信息",@"联系人",nil];
    self.segController = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segController.selectedSegmentIndex = 0;
    self.segController.tintColor = [UIColor blackColor];
    
    [self.segController setBackgroundImage:[ZGUtility imageWithColor:[UIColor yellowColor] size:CGSizeMake(150, 50)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segController setBackgroundImage:[ZGUtility imageWithColor:[UIColor whiteColor] size:CGSizeMake(150, 50)] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self.segController setBackgroundImage:[ZGUtility imageWithColor:[UIColor grayColor] size:CGSizeMake(150, 50)] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
//    [self.segController addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    [self addSubview:self.segController];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.segController.frame = CGRectMake(0,SCREEN_HEIGHT - SocialContactSegHeight,SCREEN_WIDTH,SocialContactSegHeight);
}
@end
