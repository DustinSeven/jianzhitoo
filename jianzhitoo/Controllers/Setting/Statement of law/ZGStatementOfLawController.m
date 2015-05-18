//
//  ZGStatementOfLawController.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGStatementOfLawController.h"

@interface ZGStatementOfLawController ()
{
    ZGStatementOfLawViewBase *_baseView;
}

@end

@implementation ZGStatementOfLawController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.title = @"法律申明";
        
        _baseView = [[ZGStatementOfLawViewIphone alloc]init];
        self.view = _baseView;
        
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"legal_notice" ofType:@"html"];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_baseView.baseWebView loadRequest:request];
        
//        self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(backBtnClicked:) spacing:-15];
    }
}


//#pragma mark - backBtnClicked
//- (void)backBtnClicked:(UIButton *)button
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
