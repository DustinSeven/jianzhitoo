//
//  ZGMonryDetailController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMonryDetailController.h"
#import "ZGMoneyDetailListCell.h"
#import "ZGMoneyDetailEntity.h"
#import "ZGMoneyDetailParam.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGMoneyDetailProcess.h"
#import "MJRefresh.h"

@interface ZGMonryDetailController ()<UITableViewDataSource,UITableViewDelegate,ZGFailImgAlertViewIphoneDelegate>
{
    ZGMoneyDetailViewBase *_baseView;

    ZGUserInfoEntity *userInfoEntity;
    
    ZGMoneyDetailParam *moneyDetailParam;
    
    NSMutableArray *moneyDetailArr;
    
    ZGFailImgAlertViewIphone *loadFail;
    ZGFailImgAlertViewIphone *noRecord;
}

@end

@implementation ZGMonryDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        moneyDetailArr = [NSMutableArray array];
        
        userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
        
        _baseView = [[ZGMoneyDetailViewIphone alloc]init];
        self.view = _baseView;
        
        [_baseView.headView.backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        [_baseView.baseTableView addHeaderWithTarget:self
                                                 action:@selector(headerLoad)];
        _baseView.baseTableView.headerPullToRefreshText = @"下拉刷新";
        _baseView.baseTableView.headerReleaseToRefreshText = @"释放刷新";
        _baseView.baseTableView.headerRefreshingText = @"刷新中...";
        
        [_baseView.baseTableView addFooterWithTarget:self action:@selector(footerLoad)];
        _baseView.baseTableView.footerPullToRefreshText = @"上拉刷新";
        _baseView.baseTableView.footerReleaseToRefreshText = @"释放刷新";
        _baseView.baseTableView.footerRefreshingText = @"刷新中...";
        
        if(userInfoEntity)
        {
            moneyDetailParam = [[ZGMoneyDetailParam alloc]init];
            moneyDetailParam.mobile = userInfoEntity.mobile;
            moneyDetailParam.pwd = userInfoEntity.password;
            moneyDetailParam.pageSize = 10;
            moneyDetailParam.page = 0;
            [self loadList];
        }
    }
}

- (void)headerLoad
{
    moneyDetailParam.page = 1;
    [[ZGMoneyDetailProcess shareInstance]getMoneyDetailListWithParam:[moneyDetailParam getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            [moneyDetailArr removeAllObjects];
            NSArray *data = [responseObject objectForKey:@"data"];
            for(int i = 0;i<data.count;++i)
            {
                ZGMoneyDetailEntity *entity = [[ZGMoneyDetailEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [moneyDetailArr addObject:entity];
            }
            [_baseView.baseTableView reloadData];
            
        }
        else
        {
            
        }
        
        [_baseView.baseTableView headerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_baseView.baseTableView headerEndRefreshing];
        
        [moneyDetailArr removeAllObjects];
        [_baseView.baseTableView reloadData];
        
        loadFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseTableView];
        
        
    }];

}

- (void)footerLoad
{
    [[ZGMoneyDetailProcess shareInstance]getMoneyDetailListWithParam:[moneyDetailParam getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            [moneyDetailArr removeAllObjects];
            NSArray *data = [responseObject objectForKey:@"data"];
            for(int i = 0;i<data.count;++i)
            {
                ZGMoneyDetailEntity *entity = [[ZGMoneyDetailEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [moneyDetailArr addObject:entity];
            }
            [_baseView.baseTableView reloadData];
            
        }
        else
        {
            
        }
        
        [_baseView.baseTableView footerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_baseView.baseTableView footerEndRefreshing];
        
        [moneyDetailArr removeAllObjects];
        [_baseView.baseTableView reloadData];
        
        loadFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseTableView];
        
    }];

}

- (void)loadList
{
    __block ZGActivityIndicator *progress;
    moneyDetailParam.page++;
    [[ZGMoneyDetailProcess shareInstance]getMoneyDetailListWithParam:[moneyDetailParam getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        progress = [ZGUtility showProgressWithParentView:_baseView.baseTableView
                                                                  background:nil];
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [responseObject objectForKey:@"data"];
            for(int i = 0;i<data.count;++i)
            {
                ZGMoneyDetailEntity *entity = [[ZGMoneyDetailEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [moneyDetailArr addObject:entity];
            }
            [_baseView.baseTableView reloadData];
            
        }
        else
        {
            noRecord = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"no_record_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:nil parentView:_baseView.baseTableView];
        }
        
        [progress stopAnimation];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [progress stopAnimation];
        
        [moneyDetailArr removeAllObjects];
        [_baseView.baseTableView reloadData];
        
        loadFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseTableView];
        
    }];
}

#pragma mark - ZGFailImgAlertViewIphoneDelegate
- (void)tapOnAlertView
{
    if(loadFail)
    {
        moneyDetailParam.page--;
        [self loadList];
        loadFail.hidden = YES;
        loadFail = nil;
    }
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return moneyDetailArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MoneyDetailListCell";
    ZGMoneyDetailListCell *cell = (ZGMoneyDetailListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGMoneyDetailListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    ZGMoneyDetailEntity *entity = [moneyDetailArr objectAtIndex:indexPath.row];
    
    if(entity.name)
        cell.moneyTypeLab.text = entity.name;
    if(entity.time)
        cell.moneyTimeLab.text = @"2014.10.22 10:00";
    if(entity.money)
        cell.moneyNumLab.text = [NSString stringWithFormat:@"%0.2f",entity.money];
    
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MoneyDetailListCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - back button clicked
- (void)backBtnClick:(UIButton *)button
{
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
