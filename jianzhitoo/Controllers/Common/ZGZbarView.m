//
//  ZGZbarView.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGZbarView.h"

@interface ZGZbarView ()
{
    ZGBaseView *upBack;
    ZGBaseView *downBack;
    UILabel * label;
    UIImageView * image;
    UIImageView *line;
    
    int num;
    BOOL isDown;
    
    NSTimer *timer;
}

@end

@implementation ZGZbarView

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
    num = 0;
    isDown = YES;
    
    self.backgroundColor = [UIColor clearColor];
    
    upBack = [[ZGBaseView alloc]init];
    upBack.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:upBack];
    
    downBack = [[ZGBaseView alloc]init];
    downBack.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:downBack];
    
    label = [[UILabel alloc] init];
    label.text = @"请扫描商家二维码进行签到！";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
    
    image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QR_scan_pane_img"]];
    image.frame = CGRectMake((SCREEN_WIDTH - 280) / 2, (SCREEN_HEIGHT - 280) / 2, 280, 280);
    [self addSubview:image];
    
    line = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
    line.image = [UIImage imageNamed:@"QR_scan_line_img"];
    [image addSubview:line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.backgroundColor = [UIColor clearColor];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_close_normal"] forState:UIControlStateNormal];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_close_pressed"] forState:UIControlStateHighlighted];
    [self addSubview:self.backBtn];

}

-(void)animation
{
    if (isDown) {
        num ++;
        line.frame = CGRectMake(30, 10+2*num, 220, 2);
        if (2*num == 260) {
            isDown = NO;
        }
    }
    else {
        num --;
        line.frame = CGRectMake(30, 10+2*num, 220, 2);
        if (num == 0) {
            isDown = YES;
        }
    }
    
    
}


- (void) layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    upBack.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 280) / 2 - (SCREEN_WIDTH - 280) / 2);
    downBack.frame = CGRectMake(0, (SCREEN_HEIGHT - 280) / 2 + 288 + (SCREEN_WIDTH - 280) / 2  , SCREEN_WIDTH, SCREEN_HEIGHT - (SCREEN_HEIGHT - 280) / 2 + (SCREEN_WIDTH - 280) / 2);
    label.frame = CGRectMake(0, 50, SCREEN_WIDTH, 40);
    
    self.backBtn.frame = CGRectMake((SCREEN_WIDTH - 50) / 2, (SCREEN_HEIGHT - 280) / 2 + 288 + (SCREEN_WIDTH - 280) / 2 + 20, 50, 50);
}

@end
