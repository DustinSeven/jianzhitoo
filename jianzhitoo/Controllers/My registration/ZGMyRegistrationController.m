//
//  ZGMyRegistrationController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/8/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMyRegistrationController.h"
#import "ZGMyRegistrationListCell.h"
#import "ZGRegistrationDetailController.h"
#import "ZGMyRegistrationProcess.h"
#import "ZGMyRegistrationParam.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGMyRegistrationEntity.h"
#import "UIImageView+WebCache.h"

@interface ZGMyRegistrationController ()<UITableViewDataSource,UITableViewDelegate,ZGFailImgAlertViewIphoneDelegate>
{
    ZGMyRegistrationViewBase *_baseView;
    
    ZGUserInfoEntity *userInfoEntity;
    
    NSMutableArray *myRegistrationArr;
    
    ZGMyRegistrationParam *param;
    
    ZGFailImgAlertViewIphone *loadFail;
    
    ZGMyRegistrationEntity* currentEntity;
}

@end

@implementation ZGMyRegistrationController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if(IS_PHONE)
    {
        self.title = @"我的报名";
        
        myRegistrationArr = [NSMutableArray array];
        
        _baseView = [[ZGMyRegistrationViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        [_baseView.baseTableView addHeaderWithTarget:self
                                              action:@selector(headerLoad)];
        _baseView.baseTableView.headerPullToRefreshText = @"下拉刷新";
        _baseView.baseTableView.headerReleaseToRefreshText = @"释放刷新";
        _baseView.baseTableView.headerRefreshingText = @"刷新中...";
//        [_baseView.baseTableView addFooterWithTarget:self action:@selector(footerLoad)];
//        _baseView.baseTableView.footerPullToRefreshText = @"上拉刷新";
//        _baseView.baseTableView.footerReleaseToRefreshText = @"释放刷新";
//        _baseView.baseTableView.footerRefreshingText = @"刷新中...";
        
        [_baseView.alertView.talkBtn addTarget:self action:@selector(talkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.alertView.noTalkBtn addTarget:self action:@selector(noTalkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
        
        if(userInfoEntity)
        {
            param = [[ZGMyRegistrationParam alloc]init];
            param.userId = userInfoEntity.identity;
            param.mobile = userInfoEntity.mobile;
            param.password = userInfoEntity.password;
            param.page = 1;
            param.pageSize = 10;
            
            [self loadList];
        }
        
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)headerLoad
{
    param.page = 0;
    [[ZGMyRegistrationProcess shareInstance]getMyRegistrationWithParam:[param getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            [myRegistrationArr removeAllObjects];
            NSArray *data = [responseObject objectForKey:@"data"];
            for(int i = 0;i<data.count;++i)
            {
                ZGMyRegistrationEntity *tmpEntity = [[ZGMyRegistrationEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [myRegistrationArr addObject:tmpEntity];
            }
            
            [_baseView.baseTableView reloadData];
        }
        else
        {

        }
        
        [_baseView.baseTableView headerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        [_baseView.baseTableView headerEndRefreshing];
        
        [myRegistrationArr removeAllObjects];
        [_baseView.baseTableView reloadData];
        
        loadFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseTableView];
        
    }];

}

- (void)footerLoad
{
    param.page ++;
    [[ZGMyRegistrationProcess shareInstance]getMyRegistrationWithParam:[param getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [responseObject objectForKey:@"data"];
            for(int i = 0;i<data.count;++i)
            {
                ZGMyRegistrationEntity *tmpEntity = [[ZGMyRegistrationEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [myRegistrationArr addObject:tmpEntity];
            }
            
            [_baseView.baseTableView reloadData];
        }
        else
        {

        }
        
        [_baseView.baseTableView footerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_baseView.baseTableView footerEndRefreshing];
        
        [myRegistrationArr removeAllObjects];
        [_baseView.baseTableView reloadData];
        
        loadFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseTableView];
        
    }];
}


- (void)loadList
{
    ZGActivityIndicator *progress =[ZGUtility showProgressWithParentView:_baseView.baseTableView
                                                              background:nil];
    [[ZGMyRegistrationProcess shareInstance]getMyRegistrationWithParam:[param getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            [myRegistrationArr removeAllObjects];
            NSArray *data = [responseObject objectForKey:@"data"];
            for(int i = 0;i<data.count;++i)
            {
                ZGMyRegistrationEntity *tmpEntity = [[ZGMyRegistrationEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [myRegistrationArr addObject:tmpEntity];
            }
            
            [_baseView.baseTableView reloadData];
        }
        else
        {
            [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"no_record_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:nil parentView:_baseView.baseTableView];
        }
        [progress stopAnimation];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [progress stopAnimation];
        
        loadFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseTableView];
        
    }];

}

#pragma mark - ZGFailImgAlertViewIphoneDelegate
- (void)tapOnAlertView
{
    if(loadFail)
    {
        [self loadList];
        loadFail.hidden = YES;
        loadFail = nil;
    }
}

#pragma mark - talkBtn clicked
- (void)talkBtnClicked:(UIButton *)button
{
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"telprompt://%@",currentEntity.jianzhitooMobile]];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        NSLog(@"no");
    }

}

#pragma mark - notalkBtn clicked
- (void)noTalkBtnClicked:(UIButton *)button
{
    _baseView.alertView.hidden = YES;
}


#pragma mark - refuse btn clicked
- (void)refuseBtnClicked:(UIButton *)button
{
    currentEntity = [myRegistrationArr objectAtIndex:button.tag - 200];
    _baseView.alertView.hidden = NO;
    [ZGUtility view:_baseView.alertView.backView appearAt:CGPointMake(SCREEN_WIDTH / 2, (SCREEN_HEIGHT - HeadViewHeight) / 2) withDalay:0.6 duration:0.2];
}

#pragma mark - connect clicked
- (void)connectBtnClicked:(UIButton *)button
{
    ZGMyRegistrationEntity *tmpEntity = [myRegistrationArr objectAtIndex:button.tag - 300];
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"telprompt://%@",tmpEntity.customMobile]];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        NSLog(@"no");
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return myRegistrationArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyRegisterJobsListCell";
    ZGMyRegistrationListCell *cell = (ZGMyRegistrationListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGMyRegistrationListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ZGMyRegistrationEntity *tmpEntity = [myRegistrationArr objectAtIndex:indexPath.row];
    
    if(tmpEntity.jobImg)
    {
        [cell.jobImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,tmpEntity.jobImg]] placeholderImage:[UIImage imageNamed:@"job_default_img_small"] isScaleToCustomSize:NO];
    }
    else
        cell.jobImg.image = [UIImage imageNamed:@"job_default_img_small"];
    
    if(tmpEntity.jobTitle)
        cell.jobNamelab.text = tmpEntity.jobTitle;
   
    NSMutableAttributedString *money = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%0.2f/天",tmpEntity.money]];
    NSRange range1 = NSMakeRange(0, money.string.length - 2);
    NSRange range2 = NSMakeRange(money.string.length - 2, 2);
    [money addAttribute:NSForegroundColorAttributeName value:MyRegostrationMoneyColor range:range1];
    [money addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL] range:range2];
    cell.rmbLab.attributedText = money;
    
    if(tmpEntity.address)
        cell.locLab.text = tmpEntity.address;
    
    [cell setJobStatus:1];
    
    if([tmpEntity.timeType isEqualToString:@"longterm"])
    {
        cell.workTimeType.text = @"长期兼职";
    }
    else
    {
        cell.workTimeType.text = @"短期兼职";
    }
    
    [cell setJobStatus:1];

    cell.refuseBtn.tag = 200 + indexPath.row;
    cell.connectBtn.tag = 300 + indexPath.row;
    [cell.refuseBtn addTarget:self action:@selector(refuseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.connectBtn addTarget:self action:@selector(connectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    for (id obj in cell.subviews)
    {
        if ([NSStringFromClass([obj class])isEqualToString:@"UIScrollView"])
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            scroll.delaysContentTouches =NO;
            break;
        }
    }
    
    
    return cell;

}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RegisterListCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGMyRegistrationListCell *cell = (ZGMyRegistrationListCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    ZGMyRegistrationEntity *tmpEntity = [myRegistrationArr objectAtIndex:indexPath.row];
    ZGRegistrationDetailController *registrationDetail = [[ZGRegistrationDetailController alloc]init];
    registrationDetail.myRegistrationEntity = tmpEntity;
    [self.navigationController pushViewController:registrationDetail animated:YES];
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
