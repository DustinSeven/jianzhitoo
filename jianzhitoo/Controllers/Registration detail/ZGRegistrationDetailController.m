//
//  ZGRegistrationContration.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegistrationDetailController.h"
#import "ZGRegistrationDetilCell.h"
#import "UIImageView+WebCache.h"
#import "ZGMyRegistrationDetailEntity.h"
#import "ZGMyRegistrationDetailParam.h"
#import "ZGMyRegistrationDetailProcess.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGBrowseRecordEntity.h"
#import "ZGDatabaseHelper.h"
#import "ZGJobDetailParam.h"
#import "ZGJobDetailController.h"

@interface ZGRegistrationDetailController ()<UITableViewDataSource,UITableViewDelegate,ZGFailImgAlertViewIphoneDelegate>
{
    ZGRegistrationDetailViewBase *_baseView;
    
    NSMutableArray *dateArr;
    
    ZGUserInfoEntity *userInfoEntity;
    
    ZGFailImgAlertViewIphone *loadFail;
}

@end

@implementation ZGRegistrationDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.title = @"报名详情";
        
        dateArr = [NSMutableArray array];
        
        userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
        
        _baseView = [[ZGRegistrationDetailViewIphone alloc]init];
        self.view = _baseView;
        
        if(self.myRegistrationEntity)
        {
            if(self.myRegistrationEntity.jobImg)
               [_baseView.jobImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,self.myRegistrationEntity.jobImg]] placeholderImage:[UIImage imageNamed:@"job_default_img_small"] isScaleToCustomSize:NO];
            else
                _baseView.jobImg.image = [UIImage imageNamed:@"job_default_img_small"];
            if(self.myRegistrationEntity.jobTitle)
                _baseView.jobNamelab.text = self.myRegistrationEntity.jobTitle;
            NSMutableAttributedString *money = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%0.2f/天",self.myRegistrationEntity.money]];
            NSRange range1 = NSMakeRange(0, money.string.length - 2);
            NSRange range2 = NSMakeRange(money.string.length - 2, 2);
            [money addAttribute:NSForegroundColorAttributeName value:RegostrationMoneyColor range:range1];
            [money addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL] range:range2];
            _baseView.rmbLab.attributedText = money;
            if(self.myRegistrationEntity.address)
                _baseView.locLab.text = self.myRegistrationEntity.address;
            
            if(self.myRegistrationEntity.checkIn == 1)
            {
                _baseView.refuseBtn.hidden = YES;
                _baseView.connectBtn.hidden = YES;
            }
        }
        
        _baseView.jobTimeTableView.dataSource = self;
        _baseView.jobTimeTableView.delegate = self;
        [_baseView.refuseBtn addTarget:self action:@selector(refuseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.alertView.talkBtn addTarget:self action:@selector(talkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.alertView.noTalkBtn addTarget:self action:@selector(noTalkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.connectBtn addTarget:self action:@selector(connectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jobInfoBackViewClicked:)];
        [_baseView.jobInfoBackView addGestureRecognizer:tap];
    }
}

- (void)jobInfoBackViewClicked:(UITapGestureRecognizer *)recognize
{
//    ZGBrowseRecordEntity *browseRecordEntity = [[ZGBrowseRecordEntity alloc]init];
//    browseRecordEntity.jobEntity = tmpEntity;
//    browseRecordEntity.date = [NSDate date];
//    
//    [[ZGDatabaseHelper shareHelper]insertOnJobTableWithEntity:browseRecordEntity];
//    
    ZGJobDetailParam *param = [[ZGJobDetailParam alloc]init];
    param.jobId = self.myRegistrationEntity.jobId;
    if(userInfoEntity)
        param.userId = userInfoEntity.identity;
    
    ZGJobDetailController *detailController = [[ZGJobDetailController alloc]init];
    detailController.param = param;
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadList];
}

-(void)loadList
{
    ZGMyRegistrationDetailParam *param = [[ZGMyRegistrationDetailParam alloc]init];
    param.mobile = userInfoEntity.mobile;
    param.password = userInfoEntity.password;
    param.jobId = self.myRegistrationEntity.jobId;
    param.userId = userInfoEntity.identity;
    
    ZGActivityIndicator *progress =[ZGUtility showProgressWithParentView:_baseView
                                                              background:nil];
    [[ZGMyRegistrationDetailProcess shareInstance]getMyRegistrationDetailWithParam:[param getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            [dateArr removeAllObjects];
            NSArray *data = [responseObject objectForKey:@"data"];
            for(int i = 0;i<data.count;++i)
            {
                ZGMyRegistrationDetailEntity *tmpEntity = [[ZGMyRegistrationDetailEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [dateArr addObject:tmpEntity];
            }
            
            _baseView.jobStatusBackView.hidden = NO;
            [_baseView.jobTimeTableView reloadData];
        }
        else
        {
            [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"no_record_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:nil parentView:_baseView.jobTimeTableView];
            
        }
        [progress stopAnimation];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [progress stopAnimation];
        
        loadFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.jobStatusBackView];
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

#pragma mark - refuse btn clicked
- (void)refuseBtnClicked:(UIButton *)button
{
    _baseView.alertView.hidden = NO;
    [ZGUtility view:_baseView.alertView.backView appearAt:CGPointMake(SCREEN_WIDTH / 2, (SCREEN_HEIGHT - HeadViewHeight) / 2) withDalay:0.6 duration:0.2];
    
}

#pragma mark - talkBtn clicked
- (void)talkBtnClicked:(UIButton *)button
{
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"telprompt://%@",self.myRegistrationEntity.jianzhitooMobile]];
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

#pragma mark - connect clicked
- (void)connectBtnClicked:(UIButton *)button
{
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"telprompt://%@",self.myRegistrationEntity.customMobile]];
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
    return dateArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"RegistrationDetilCell";
    ZGRegistrationDetilCell *cell = (ZGRegistrationDetilCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGRegistrationDetilCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ZGMyRegistrationDetailEntity *tmpEntity = [dateArr objectAtIndex:indexPath.row];
    cell.dateLab.text = tmpEntity.workDate;
    cell.statusLab.text = tmpEntity.message;
    
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RegisterDetailStatusCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
