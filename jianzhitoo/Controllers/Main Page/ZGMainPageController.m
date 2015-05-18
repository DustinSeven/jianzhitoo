//
//  ZGMainPageController.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMainPageController.h"
#import "ZGMainPageViewIphone.h"
#import "ZGJobsListCell.h"
#import "ZGLoginController.h"
#import "ZGUserCenterController.h"
#import "ZGJobDetailController.h"
#import "ZGJobDetailParam.h"
#import "ZGDropListCell.h"
#import "ZGJobTypeEntity.h"
#import "ZGMainPageProcess.h"
#import "ZGAreaParam.h"
#import "ZGAreaEntity.h"
#import "ZGJobParam.h"
#import "ZGJobEntity.h"
#import "UIImageView+WebCache.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "UIImageView+AFNetworking.h"
#import "ZGDatabaseHelper.h"
#import "ZGSearchJobController.h"

@interface ZGMainPageController()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ZGFailImgAlertViewIphoneDelegate>
{
    ZGMainPageViewBase *_baseView;
    
//    UITapGestureRecognizer *userImgTapGesture;
    
    UITapGestureRecognizer *filterListGenderBackViewTapGesture;
    UITapGestureRecognizer *filterListTypeBackViewTapGesture;
    UITapGestureRecognizer *filterListLocationBackViewTapGesture;
    
    NSMutableArray *genderArr;
    NSMutableArray *typeArr;
    NSMutableArray *locationArr;
    
    ZGJobParam *jobParam;
    NSMutableArray *jobArr;
    
    ZGUserInfoEntity *userInfoEntity;
    
    BOOL isRuningFirst;
    
    ZGFailImgAlertViewIphone *jobListFail;
    ZGFailImgAlertViewIphone *headerLoadFail;
    ZGFailImgAlertViewIphone *footerLoadFail;
    
    ZGFailImgAlertViewIphone *noRecordView;
    
    ZGUtility *util;
}

@end

@implementation ZGMainPageController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.title = @"兼职兔";
        
        util = [ZGUtility shareUtility];
        
        isRuningFirst = YES;
        
        genderArr = [[NSMutableArray alloc]initWithObjects:@"性别不限",@"男",@"女", nil];
        typeArr = [NSMutableArray array];
        locationArr = [NSMutableArray array];
        
        jobParam = [[ZGJobParam alloc]init];
        jobParam.pageSize = MAIN_PAGE_JOB_PAGE_SIZE;
        jobParam.pageNum = 1;
        jobArr = [NSMutableArray array];
        
        _baseView = [[ZGMainPageViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.headBackView.hidden = YES;
        
        _baseView.searchText.frame = MainPageSearchTextFrameNormal;
        
//        userImgTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userImgTaped:)];
//        [_baseView.userImg addGestureRecognizer:userImgTapGesture];
        
        filterListGenderBackViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fiterListBackTaped:)];
        filterListLocationBackViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fiterListBackTaped:)];
        filterListTypeBackViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fiterListBackTaped:)];
        
        [_baseView.genderList.baseView addGestureRecognizer:filterListGenderBackViewTapGesture];
        [_baseView.typeList.baseView addGestureRecognizer:filterListTypeBackViewTapGesture];
        [_baseView.locationList.baseView addGestureRecognizer:filterListLocationBackViewTapGesture];
        
        _baseView.jobListTableView.delegate = self;
        _baseView.jobListTableView.dataSource = self;
        
        [_baseView.jobListTableView addHeaderWithTarget:self
                                                 action:@selector(headerUpdate)];
        _baseView.jobListTableView.headerPullToRefreshText = @"下拉刷新";
        _baseView.jobListTableView.headerReleaseToRefreshText = @"释放刷新";
        _baseView.jobListTableView.headerRefreshingText = @"刷新中...";
        
        [_baseView.jobListTableView addFooterWithTarget:self action:@selector(footerUpdate)];
        _baseView.jobListTableView.footerPullToRefreshText = @"上拉刷新";
        _baseView.jobListTableView.footerReleaseToRefreshText = @"释放刷新";
        _baseView.jobListTableView.footerRefreshingText = @"刷新中...";
        
        _baseView.typeList.baseTableView.delegate = self;
        _baseView.typeList.baseTableView.dataSource = self;
        
        _baseView.locationList.baseTableView.delegate = self;
        _baseView.locationList.baseTableView.dataSource = self;
        
        _baseView.genderList.baseTableView.delegate = self;
        _baseView.genderList.baseTableView.dataSource = self;
        
        _baseView.searchText.delegate = self;
        
        [_baseView.genderFilterBtn addTarget:self action:@selector(filterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.typeFilterBtn addTarget:self action:@selector(filterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.locationFilterBtn addTarget:self action:@selector(filterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _baseView.searchText.userInteractionEnabled = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
//    NSLog(@"%f",[[UIApplication sharedApplication] statusBarFrame].size.height);
//    NSLog(@"%f",self.navigationController.navigationBar.frame.size.height);
    [super viewDidAppear:animated];

    [self setRestorationIdentifier:@"MMExampleCenterControllerRestorationKey"];
    if(isRuningFirst)
    {
        self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"main_page_left_menu_icon"] pressedImg:nil text:@"" target:self action:@selector(menuBtnClicked:) spacing:-15];
        self.navigationItem.rightBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"main_page_search_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"main_page_search_btn_icon_normal"] text:@"" target:self action:@selector(searchBtnClicked:) spacing:-15];
        
        ZGJobParam *tmpParam = [[ZGJobParam alloc]init];
        tmpParam.pageSize = MAIN_PAGE_JOB_PAGE_SIZE;
        tmpParam.pageNum = 1;
        
        ZGAreaParam *areaParam = [[ZGAreaParam alloc]init];
        areaParam.cityId = 330100;
        
        ZGActivityIndicator *progress =[ZGUtility showProgressWithParentView:_baseView
                                                                  background:nil];
        
        [[ZGMainPageProcess shareInstance]getAllJobTypeWithParam:[tmpParam getDictionary] areaParam:[areaParam getDictionary] typeSuccess:^(AFHTTPRequestOperation *operation1, id responseObject1) {
            
            if([[responseObject1 objectForKey:@"code"]intValue] == 200)
            {
                NSArray *data = [responseObject1 objectForKey:@"data"];
                [typeArr removeAllObjects];
                ZGJobTypeEntity *emptyEntity = [[ZGJobTypeEntity alloc]init];
                emptyEntity.identity = 0;
                emptyEntity.name = @"类型不限";
                [typeArr addObject:emptyEntity];
                for(int i = 0; i<data.count ; ++i)
                {
                    ZGJobTypeEntity *jobTypeEntity = [[ZGJobTypeEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                    [typeArr addObject:jobTypeEntity];
                }
                util.jobTypeArr = typeArr;
                
                _baseView.searchText.userInteractionEnabled = YES;
            }

        } typeFailure:^(AFHTTPRequestOperation *operation1, NSError *error1) {
            
        } areaSuccess:^(AFHTTPRequestOperation *operation2, id responseObject2) {
            
            if([[responseObject2 objectForKey:@"code"]intValue] == 200)
            {
                NSArray *data = [responseObject2 objectForKey:@"data"];
                [locationArr removeAllObjects];
                ZGAreaEntity *emptyEntity = [[ZGAreaEntity alloc]init];
                emptyEntity.identity = 0;
                emptyEntity.name = @"地区不限";
                [locationArr addObject:emptyEntity];
                for(int i = 0; i<data.count ; ++i)
                {
                    ZGAreaEntity *areaEntity = [[ZGAreaEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                    [locationArr addObject:areaEntity];
                }
                util.locationArr = locationArr;
            }

        } areaFailure:^(AFHTTPRequestOperation *operation2, NSError *error2) {
            
        } jobSuccess:^(AFHTTPRequestOperation *operation3, id responseObject3) {
            
            if([[responseObject3 objectForKey:@"code"]intValue] == 200)
            {
                NSArray *data = [responseObject3 objectForKey:@"data"];
                for(int i = 0; i<data.count ; ++i)
                {
                    ZGJobEntity *jobEntity = [[ZGJobEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                    [jobArr addObject:jobEntity];
                }
                [progress stopAnimation];
                [_baseView.jobListTableView reloadData];
                [_baseView.typeList.baseTableView reloadData];
                [_baseView.locationList.baseTableView reloadData];
            }
            else
            {
                [progress stopAnimation];
                [jobArr removeAllObjects];
                [_baseView.jobListTableView reloadData];
                
                if(!noRecordView)
                    noRecordView = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"no_record_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.jobListTableView];
                else
                    noRecordView.hidden = NO;
            }
            
            
            
        } jobFailure:^(AFHTTPRequestOperation *operation3, NSError *error3) {
            
            [jobArr removeAllObjects];
            [_baseView.jobListTableView reloadData];
            jobListFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.jobListTableView];
            
            [progress stopAnimation];
        }];

        isRuningFirst = NO;
    }
    
    
    [self updateUI];
}

- (void)updateUI
{
    userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    
//    if(userEntity && userEntity.userImg)
//        [_baseView.userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,userEntity.userImg]]
//                         placeholderImage:[UIImage imageNamed:@"user_img_default_80px"]
//                      isScaleToCustomSize:NO];
//    else
//        _baseView.userImg.image = [UIImage imageNamed:@"user_img_default_80px"];
    
    UIImage *tipImg = [UIImage imageNamed:@"main_page_filter_btn_icon_down"];
    _baseView.genterBtnTipImg.image = tipImg;
    _baseView.typeBtnTipImg.image = tipImg;
    _baseView.locationBtnTipImg.image = tipImg;
}

- (void)reUpdateList
{
    [jobArr removeAllObjects];
    [_baseView.jobListTableView reloadData];
    
    ZGActivityIndicator *progress =[ZGUtility showProgressWithParentView:_baseView
                                                              background:nil];
    
    jobParam.pageNum = 1;
    [self getJobWithParam:jobParam success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if([[responseObject objectForKey:@"code"]intValue] == 200)
         {
             NSArray *data = [responseObject objectForKey:@"data"];
             for(int i = 0; i<data.count ; ++i)
             {
                 ZGJobEntity *jobEntity = [[ZGJobEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                 [jobArr addObject:jobEntity];
             }
             [_baseView.jobListTableView reloadData];
         }
         else
         {
             [jobArr removeAllObjects];
             [_baseView.jobListTableView reloadData];
             
             if(!noRecordView)
                 noRecordView = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"no_record_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.jobListTableView];
             else
                 noRecordView.hidden = NO;
         }
         [progress stopAnimation];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [jobArr removeAllObjects];
         [_baseView.jobListTableView reloadData];
         jobListFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.jobListTableView];

         [progress stopAnimation];
     }];

}

- (void)headerUpdate
{
    jobParam.pageNum = 1;
    [self getJobWithParam:jobParam success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if([[responseObject objectForKey:@"code"]intValue] == 200)
         {
             NSArray *data = [responseObject objectForKey:@"data"];
             [jobArr removeAllObjects];
             for(int i = 0; i<data.count ; ++i)
             {
                 ZGJobEntity *jobEntity = [[ZGJobEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                 [jobArr addObject:jobEntity];
             }
             [_baseView.jobListTableView reloadData];
         }


     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [jobArr removeAllObjects];
         [_baseView.jobListTableView reloadData];
         headerLoadFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.jobListTableView];
     }];
}

- (void)footerUpdate
{
    jobParam.pageNum++;
    [self getJobWithParam:jobParam success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSMutableArray *insertArr = [NSMutableArray array];
         if([[responseObject objectForKey:@"code"]intValue] == 200)
         {
             NSArray *data = [responseObject objectForKey:@"data"];
             for(int i = 0; i<data.count ; ++i)
             {
                 ZGJobEntity *jobEntity = [[ZGJobEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                 [jobArr addObject:jobEntity];
                 [insertArr addObject:[NSIndexPath indexPathForRow:jobArr.count - 1 inSection:0]];
             }
             [_baseView.jobListTableView insertRowsAtIndexPaths:insertArr withRowAnimation:UITableViewRowAnimationNone];
         }
         else
         {
             jobParam.pageNum--;
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         jobParam.pageNum--;
         [jobArr removeAllObjects];
         [_baseView.jobListTableView reloadData];
         footerLoadFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.jobListTableView];
     }];
}


- (void)getJobWithParam:(ZGJobParam *)param
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [[ZGMainPageProcess shareInstance]getJobWithParam:[param getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [_baseView.jobListTableView headerEndRefreshing];
        [_baseView.jobListTableView footerEndRefreshing];
        success(operation,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_baseView.jobListTableView headerEndRefreshing];
        [_baseView.jobListTableView footerEndRefreshing];
        failure(operation,error);
    }];
}

- (void)updateFilterList:(ZGDropDownList *)list tag:(int)tag
{
    if(list.hidden == YES)
    {
       list.hidden = NO;
        [UIView animateWithDuration:0.1 animations:^{
            
            float height = 0;
            if(tag == 201)
                height = 3 * MainPageFilterListHeight;
            if(tag == 202)
                height = 8 * MainPageFilterListHeight;
            if(tag == 203)
                height = 9 * MainPageFilterListHeight;
            list.baseTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
            list.baseView.alpha = 0.2f;
            
            if(tag == 201)
            {
                if(!_baseView.typeList.hidden)
                    _baseView.typeBtnTipImg.transform = CGAffineTransformRotate(_baseView.typeBtnTipImg.transform, DEGREES_TO_RADIANS(180));
                if(!_baseView.locationList.hidden)
                    _baseView.locationBtnTipImg.transform = CGAffineTransformRotate(_baseView.locationBtnTipImg.transform, DEGREES_TO_RADIANS(180));
                _baseView.genterBtnTipImg.transform = CGAffineTransformRotate(_baseView.genterBtnTipImg.transform, DEGREES_TO_RADIANS(180));
                _baseView.typeList.hidden = YES;
                _baseView.locationList.hidden = YES;
            }
            if(tag == 202)
            {
                if(!_baseView.genderList.hidden)
                    _baseView.genterBtnTipImg.transform = CGAffineTransformRotate(_baseView.genterBtnTipImg.transform, DEGREES_TO_RADIANS(180));
                if(!_baseView.locationList.hidden)
                    _baseView.locationBtnTipImg.transform = CGAffineTransformRotate(_baseView.locationBtnTipImg.transform, DEGREES_TO_RADIANS(180));
                _baseView.typeBtnTipImg.transform = CGAffineTransformRotate(_baseView.typeBtnTipImg.transform, DEGREES_TO_RADIANS(180));
                _baseView.genderList.hidden = YES;
                _baseView.locationList.hidden = YES;
            }
            if(tag == 203)
            {
                if(!_baseView.typeList.hidden)
                    _baseView.typeBtnTipImg.transform = CGAffineTransformRotate(_baseView.typeBtnTipImg.transform, DEGREES_TO_RADIANS(180));
                if(!_baseView.genderList.hidden)
                    _baseView.genterBtnTipImg.transform = CGAffineTransformRotate(_baseView.genterBtnTipImg.transform, DEGREES_TO_RADIANS(180));
                _baseView.locationBtnTipImg.transform = CGAffineTransformRotate(_baseView.locationBtnTipImg.transform, DEGREES_TO_RADIANS(180));
                
                _baseView.typeList.hidden = YES;
                _baseView.genderList.hidden = YES;
            }
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    else
    {
        [UIView animateWithDuration:0.1 animations:^{
            
           list.baseTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
            list.baseView.alpha = 0.0f;
            if(tag == 201)
                _baseView.genterBtnTipImg.transform = CGAffineTransformRotate(_baseView.genterBtnTipImg.transform, DEGREES_TO_RADIANS(180));
            if(tag == 202)
                _baseView.typeBtnTipImg.transform = CGAffineTransformRotate(_baseView.typeBtnTipImg.transform, DEGREES_TO_RADIANS(180));
            if(tag == 203)
                _baseView.locationBtnTipImg.transform = CGAffineTransformRotate(_baseView.locationBtnTipImg.transform, DEGREES_TO_RADIANS(180));
        } completion:^(BOOL finished) {
            list.frame = CGRectMake(0, _baseView.filterBtnBackView.frame.origin.y + MainPageFilterBackHeight, SCREEN_WIDTH, 0);
            list.hidden = YES;
        }];
        
    }
}

#pragma mark - filter btn clicked
- (void)filterBtnClicked:(UIButton *)button
{
    if(noRecordView)
        noRecordView.hidden = YES;
    
    [_baseView.searchText resignFirstResponder];
    if(button.tag == 201)
    {
        [self updateFilterList:_baseView.genderList tag:201];
    }
    if(button.tag == 202)
    {
        [self updateFilterList:_baseView.typeList tag:202];
    }
    if(button.tag == 203)
    {
        [self updateFilterList:_baseView.locationList tag:203];
    }
}

//#pragma mark  - user img taped
//- (void)userImgTaped:(UITapGestureRecognizer *)recognize
//{
//    ZGUserCenterController *userCenterController = [[ZGUserCenterController alloc]init];
//    [self.navigationController pushViewController:userCenterController animated:YES];
//}

#pragma mark  - filter list back view taped
- (void)fiterListBackTaped:(UITapGestureRecognizer *)recognize
{
    if(recognize.view.tag == 304)
    {
        [self updateFilterList:_baseView.genderList tag:201];
    }
    if(recognize.view.tag == 305)
    {
        [self updateFilterList:_baseView.typeList tag:202];
    }
    if(recognize.view.tag == 306)
    {
        [self updateFilterList:_baseView.locationList tag:203];
    }
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 204)
        return genderArr.count;
    if(tableView.tag == 205)
        return typeArr.count;
    if(tableView.tag == 206)
        return locationArr.count;
    return jobArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 204)
    {
        static NSString *cellIdentifier = @"FilterListGenderCell";
        ZGDropListCell *cell = (ZGDropListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[ZGDropListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.text = [genderArr objectAtIndex:indexPath.row];
        return cell;
    }
    if(tableView.tag == 205)
    {
        static NSString *cellIdentifier = @"FilterListTypeCell";
        ZGDropListCell *cell = (ZGDropListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[ZGDropListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        ZGJobTypeEntity *tmpEntity = [typeArr objectAtIndex:indexPath.row];
        cell.textLabel.text = tmpEntity.name;
        return cell;
    }
    if(tableView.tag == 206)
    {
        static NSString *cellIdentifier = @"FilterListLocationCell";
        ZGDropListCell *cell = (ZGDropListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[ZGDropListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        ZGAreaEntity *tmpEntity = [locationArr objectAtIndex:indexPath.row];
        cell.textLabel.text = tmpEntity.name;
        return cell;
    }
    static NSString *cellIdentifier = @"JobsListCell";
    ZGJobsListCell *cell = (ZGJobsListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGJobsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ZGJobEntity *tmpEntity = [jobArr objectAtIndex:indexPath.row];
    
    if(tmpEntity.jobImg)
       [cell.jobImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,tmpEntity.jobImg]] placeholderImage:[UIImage imageNamed:@"job_default_img_small"] isScaleToCustomSize:NO];
    else
        cell.jobImg.image = [UIImage imageNamed:@"job_default_img_small"];
    
    if(tmpEntity.title)
    cell.jobNamelab.text = tmpEntity.title;
    
    NSMutableAttributedString *money = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%0.2f/%@",tmpEntity.money,tmpEntity.moneyType]];
    NSRange range1 = NSMakeRange(0, money.string.length - 2);
    NSRange range2 = NSMakeRange(money.string.length - 2, 2);
    [money addAttribute:NSForegroundColorAttributeName value:MainPageMoneyColor range:range1];
    [money addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL] range:range2];
    cell.rmbLab.attributedText = money;
    
    if(tmpEntity.address)
        cell.locLab.text = tmpEntity.address;
    
    if(tmpEntity.isJobNew == 1)
        cell.isJobNewImg.hidden = NO;
    else
        cell.isJobNewImg.hidden = YES;
    
    if(tmpEntity.jobTypeCode)
        cell.typeImg.image = [[ZGUtility shareUtility] getJobTypeImg:[[ZGUtility shareUtility] reflectJobType:[NSString stringWithFormat:@"%ld",tmpEntity.jobTypeCode]]];
    
    if(tmpEntity.remaining<=0)
        cell.statusImg.hidden = NO;
    else
        cell.statusImg.hidden = YES;
    
    return cell;
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 204 || tableView.tag == 205 || tableView.tag == 206)
        return MainPageFilterListHeight;
    return MainPageListRowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_baseView.searchText resignFirstResponder];
    ZGJobsListCell *cell = (ZGJobsListCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if(tableView.tag == 204)
    {
        [self updateFilterList:_baseView.genderList tag:201];
        
        [_baseView.genderFilterBtn setTitle:[genderArr objectAtIndex:indexPath.row]forState:UIControlStateNormal];

        jobParam.sex = (int)indexPath.row;
        [self reUpdateList];
    }
    else if(tableView.tag == 205)
    {
        [self updateFilterList:_baseView.typeList tag:202];

       ZGJobTypeEntity *typeEntity = [typeArr objectAtIndex:indexPath.row];
        
        [_baseView.typeFilterBtn setTitle:typeEntity.name forState:UIControlStateNormal];

        jobParam.typeId = typeEntity.identity;
        [self reUpdateList];
    }
    else if(tableView.tag == 206)
    {
        [self updateFilterList:_baseView.locationList tag:203];
        
        ZGAreaEntity *areaEntity = [locationArr objectAtIndex:indexPath.row];
        
        [_baseView.locationFilterBtn setTitle:areaEntity.name forState:UIControlStateNormal];

        jobParam.areaId = areaEntity.identity;
        [self reUpdateList];
    }
    else
    {
        ZGJobEntity *tmpEntity = [jobArr objectAtIndex:indexPath.row];
        
        ZGBrowseRecordEntity *browseRecordEntity = [[ZGBrowseRecordEntity alloc]init];
        browseRecordEntity.jobEntity = tmpEntity;
        browseRecordEntity.date = [NSDate date];
        
        [[ZGDatabaseHelper shareHelper]insertOnJobTableWithEntity:browseRecordEntity];
        
        ZGJobDetailParam *param = [[ZGJobDetailParam alloc]init];
        param.jobId = tmpEntity.identity;
        if(userInfoEntity)
            param.userId = userInfoEntity.identity;
        
        ZGJobDetailController *detailController = [[ZGJobDetailController alloc]init];
        detailController.param = param;
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_baseView.searchText resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_baseView.searchText resignFirstResponder];
    
    ZGSearchJobController *searchController = [[ZGSearchJobController alloc]init];
    [self.navigationController pushViewController:searchController animated:NO];
}

#pragma mark - ZGFailImgAlertViewIphoneDelegate
- (void)tapOnAlertView
{
    if(jobListFail)
    {
        [self reUpdateList];
        jobListFail.hidden = YES;
        jobListFail = nil;
    }
    if(headerLoadFail)
    {
        [self headerUpdate];
        headerLoadFail.hidden = YES;
        headerLoadFail = nil;
    }
    if(footerLoadFail)
    {
        [self footerUpdate];
        footerLoadFail.hidden = YES;
        footerLoadFail = nil;
    }
}

#pragma mark - menuBtnClicked
- (void)menuBtnClicked:(UIButton *)btn
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - searchBtnClicked
- (void)searchBtnClicked:(UIButton *)btn
{
    ZGSearchJobController *searchController = [[ZGSearchJobController alloc]init];
    [self.navigationController pushViewController:searchController animated:YES];
}

@end
