//
//  ZGAlertViewBase.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGAlertViewBase.h"


@implementation ZGAlertViewBase

- (id)init
{
    self = [super init];
    if(self)
    {
        self.tag = 100;
        
        self.baseRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        self.baseRecognizer.delegate = self;
        [self addGestureRecognizer:self.baseRecognizer];
        
        self.backgroundColor = [UIColor colorWithRed:0.0f / 255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:0.2f];
        self.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
    }
    return self;
}

#pragma mark - other place clicked
- (void)tapAction:(UITapGestureRecognizer *)recognize
{
    if(self.isBackViewEntable)
        self.hidden = YES;
}

#pragma mark - UIGestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(touch.view.tag == 100)
    {
        return YES;
    }
    return NO;
}

@end
