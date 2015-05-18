//
//  ZGSessionDetailViewIphone.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/12.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGSessionDetailViewIphone.h"

@implementation ZGSessionDetailViewIphone

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
    self.backgroundColor = SessionDetailViewColor;
    
    self.bottomBackView = [[ZGBaseView alloc]init];
    self.bottomBackView.backgroundColor = BottomViewColor;
    self.bottomBackView.layer.borderWidth = 0.5;
    self.bottomBackView.layer.borderColor = BottomViewBorderColor.CGColor;
    [self addSubview:self.bottomBackView];
    
    self.chatTextField = [[UITextField alloc]init];
    self.chatTextField.backgroundColor = [UIColor whiteColor];
    self.chatTextField.layer.borderColor = ChatTextBorderColor.CGColor;
    self.chatTextField.layer.borderWidth = 0.5;
    self.chatTextField.layer.masksToBounds = YES;
    self.chatTextField.layer.cornerRadius = 3;
    self.chatTextField.returnKeyType = UIReturnKeySend;
    [self.bottomBackView addSubview:self.chatTextField];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [self.sendBtn setImage:[ZGUtility imageWithColor:[UIColor yellowColor] size:CGSizeMake(SendBtnWidth, SendBtnHeight)] forState:UIControlStateNormal];
//    [self.sendBtn setImage:[ZGUtility imageWithColor:[UIColor grayColor] size:CGSizeMake(SendBtnWidth, SendBtnHeight)] forState:UIControlStateHighlighted];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
//    [self.sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.bottomBackView addSubview:self.sendBtn];
    
    self.baseTableView = [[UITableView alloc]init];
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.allowsSelection = NO;
    [self addSubview:self.baseTableView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.bottomBackView.frame = CGRectMake(-0.5, SCREEN_HEIGHT - BottomViewHeight, SCREEN_WIDTH + 1, BottomViewHeight + 1);
    
    self.chatTextField.frame = CGRectMake((SCREEN_WIDTH - ChatTextWidth - SendBtnWidth - 10) / 2, (BottomViewHeight - ChatTextHeight) / 2, ChatTextWidth, ChatTextHeight);
    
    self.sendBtn.frame = CGRectMake(CGRectGetMaxX(self.chatTextField.frame) + 10, (BottomViewHeight - SendBtnHeight) / 2, SendBtnWidth, SendBtnHeight);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - BottomViewHeight - HeadViewHeight);
}

@end
