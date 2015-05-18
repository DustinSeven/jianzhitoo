//
//  ZGBankController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBankController.h"
#import "ZGBankProcess.h"
#import "ZGBankCell.h"

@interface ZGBankController ()<UITableViewDelegate,UITableViewDataSource>
{
    ZGBankViewBase *_baseView;
    
    NSMutableArray *bankArr;
}

@end

@implementation ZGBankController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        bankArr = [NSMutableArray array];
        
        _baseView = [[ZGBankViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        [_baseView.headView.backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[ZGBankProcess shareInstance]getAllBankWithParentView:nil progressText:@"加载中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [responseObject objectForKey:@"data"];
            [bankArr removeAllObjects];
            for(int i = 0;i<data.count;++i)
            {
                ZGBankEntity *tmpEntity = [[ZGBankEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [bankArr addObject:tmpEntity];
            }
            [_baseView.baseTableView reloadData];
        }
        else
        {
            [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
        
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return bankArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"BankCell";
    ZGBankCell *cell = (ZGBankCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGBankCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    ZGBankEntity *tmpEntity = [bankArr objectAtIndex:indexPath.row];
    cell.textLabel.text = tmpEntity.bankName;

    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return BankCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    ZGBankEntity *tmpEntity = [bankArr objectAtIndex:indexPath.row];
    [self.delegate gainTheBank:tmpEntity];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
