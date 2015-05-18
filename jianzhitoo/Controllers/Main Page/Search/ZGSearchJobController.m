//
//  ZGSearchJobControllerViewController.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/4/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSearchJobController.h"
#import "ZGSearchHistoryCell.h"
#import "ZGSearchRecordEntity.h"

@interface ZGSearchJobController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ZGFailImgAlertViewIphoneDelegate>
{
    ZGMainPageViewBase *_baseView;
    
//    UITapGestureRecognizer *userImgTapGesture;
    
    UITapGestureRecognizer *filterListGenderBackViewTapGesture;
    UITapGestureRecognizer *filterListTypeBackViewTapGesture;
    UITapGestureRecognizer *filterListLocationBackViewTapGesture;
    
    NSMutableArray *genderArr;
    NSMutableArray *typeArr;
    NSMutableArray *locationArr;
    
    ZGUserInfoEntity *userInfoEntity;
    
    ZGJobParam *searchParam;
    NSMutableArray *searchArr;
    
    ZGFailImgAlertViewIphone *searchFail;
    ZGFailImgAlertViewIphone *searchHeaderLoadFail;
    ZGFailImgAlertViewIphone *searchFooterLoadFail;
    
    ZGFailImgAlertViewIphone *noRecordView;
    
    ZGUtility *util;
    
    NSMutableArray *searchHistoryArr;
    
    ZGJobTypeEntity *currentSelectedsearchJobType;
    ZGAreaEntity *currentSelectedsearchJobArea;
}

@end

@implementation ZGSearchJobController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
//        self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(menuBtnClicked:) spacing:-15];
        
        util = [ZGUtility shareUtility];
        
        typeArr = util.jobTypeArr;
        locationArr = util.locationArr;
        genderArr = [[NSMutableArray alloc]initWithObjects:@"性别不限",@"男",@"女", nil];
        
        searchParam = [[ZGJobParam alloc]init];
        searchParam.pageSize = MAIN_PAGE_JOB_PAGE_SIZE;
        searchArr = [NSMutableArray array];
        
        _baseView = [[ZGMainPageViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.searchText.frame = MainPageSearchTextFrameNormal;
        
//        userImgTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userImgTaped:)];
//        [_baseView.userImg addGestureRecognizer:userImgTapGesture];
//        
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
        
        //        [_baseView.jobListTableView headerBeginRefreshing];
        
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
        
        [_baseView.cancelBtn addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    searchHistoryArr = [[ZGDatabaseHelper shareHelper] getListOnSearchHistoryTable];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self transitionView:YES];
    [self updateUI];
    [_baseView.searchText becomeFirstResponder];
}

- (void)updateUI
{
    userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    
//    if(userEntity && userEntity.userImg)
//        [_baseView.userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,userEntity.userImg]]
//                             placeholderImage:[UIImage imageNamed:@"user_img_default_80px"]
//                          isScaleToCustomSize:NO];
//    else
//        _baseView.userImg.image = [UIImage imageNamed:@"user_img_default_80px"];
    
    UIImage *tipImg = [UIImage imageNamed:@"main_page_filter_btn_icon_down"];
    _baseView.genterBtnTipImg.image = tipImg;
    _baseView.typeBtnTipImg.image = tipImg;
    _baseView.locationBtnTipImg.image = tipImg;
}

- (void)deleteRecord:(UIButton *)button
{
    [[ZGDatabaseHelper shareHelper]deleteOnSearchHistoryTable];
    [searchHistoryArr removeAllObjects];
    [_baseView.jobListTableView reloadData];
}

- (void)reUpdateList
{
    [searchArr removeAllObjects];
    [_baseView.jobListTableView reloadData];
    
    [searchHistoryArr removeAllObjects];
    [_baseView.jobListTableView reloadData];
    
    ZGActivityIndicator *progress =[ZGUtility showProgressWithParentView:_baseView
                                                              background:nil];
    
    searchParam.pageNum = 0;
    [self getJobWithParam:searchParam success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if([[responseObject objectForKey:@"code"]intValue] == 200)
         {
             NSArray *data = [responseObject objectForKey:@"data"];
             for(int i = 0; i<data.count ; ++i)
             {
                 ZGJobEntity *jobEntity = [[ZGJobEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                 [searchArr addObject:jobEntity];
             }
             [_baseView.jobListTableView reloadData];
         }
         else
         {
             searchParam.pageNum--;
             [searchArr removeAllObjects];
             [_baseView.jobListTableView reloadData];
             
             if(!noRecordView)
                 noRecordView = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"no_record_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.jobListTableView];
             else
                 noRecordView.hidden = NO;
         }
         [progress stopAnimation];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         searchParam.pageNum--;
         [searchArr removeAllObjects];
         [_baseView.jobListTableView reloadData];
         searchFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.jobListTableView];
         
         [progress stopAnimation];
     }];
    
}

- (void)headerUpdate
{
    searchParam.pageNum = 0;
    if(searchParam.keyword && ![searchParam.keyword isEqualToString:@""])
    {
        [self getJobWithParam:searchParam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if([[responseObject objectForKey:@"code"]intValue] == 200)
             {
                 NSArray *data = [responseObject objectForKey:@"data"];
                 [searchArr removeAllObjects];
                 for(int i = 0; i<data.count ; ++i)
                 {
                     ZGJobEntity *jobEntity = [[ZGJobEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                     [searchArr addObject:jobEntity];
                 }
                 [_baseView.jobListTableView reloadData];
             }
             else
                 searchParam.pageNum--;
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             [searchArr removeAllObjects];
             [_baseView.jobListTableView reloadData];
             searchHeaderLoadFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.jobListTableView];
             searchParam.pageNum--;
         }];
    }
    else
        [_baseView.jobListTableView headerEndRefreshing];
    
}

- (void)footerUpdate
{
    if(searchParam.keyword && ![searchParam.keyword isEqualToString:@""])
    {
        [self getJobWithParam:searchParam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSMutableArray *insertArr = [NSMutableArray array];
             if([[responseObject objectForKey:@"code"]intValue] == 200)
             {
                 NSArray *data = [responseObject objectForKey:@"data"];
                 for(int i = 0; i<data.count ; ++i)
                 {
                     ZGJobEntity *jobEntity = [[ZGJobEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                     [searchArr addObject:jobEntity];
                     [insertArr addObject:[NSIndexPath indexPathForRow:searchArr.count - 1 inSection:0]];
                 }
                 [_baseView.jobListTableView insertRowsAtIndexPaths:insertArr withRowAnimation:UITableViewRowAnimationNone];
             }
             else
             {
                 searchParam.pageNum--;
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             searchParam.pageNum--;
             [searchArr removeAllObjects];
             [_baseView.jobListTableView reloadData];
             searchFooterLoadFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.jobListTableView];
         }];
    }
    else
        [_baseView.jobListTableView footerEndRefreshing];
}


- (void)getJobWithParam:(ZGJobParam *)param
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    param.pageNum++;
    
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
    
    if(searchArr.count)
        return searchArr.count;
    else
        return searchHistoryArr.count;
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
    
    if(searchArr.count)
    {
        static NSString *cellIdentifier = @"JobsListCell";
        ZGJobsListCell *cell = (ZGJobsListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[ZGJobsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        ZGJobEntity *tmpEntity  = [searchArr objectAtIndex:indexPath.row];
       
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
        
        if(!tmpEntity.remaining)
            cell.statusImg.hidden = NO;
        
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"SearchHistoryCell";
        ZGSearchHistoryCell *cell = (ZGSearchHistoryCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[ZGSearchHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        ZGSearchRecordEntity *tmpEntity  = [searchHistoryArr objectAtIndex:indexPath.row];
        cell.keyWordText.text = tmpEntity.keyWord;
        cell.filterText.text = tmpEntity.condition;
       
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateStr = [dateFormatter stringFromDate:tmpEntity.searchDate];
        cell.dateText.text = dateStr;
        
        return cell;
    }
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 204 || tableView.tag == 205 || tableView.tag == 206)
        return MainPageFilterListHeight;
    if(searchArr.count)
        return MainPageListRowHeight;
    else
        return SearchHistoryCellHight;
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

        searchParam.sex = (int)indexPath.row;
        
        if(searchParam.keyword && ![searchParam.keyword isEqualToString:@""])
            [self reUpdateList];
    }
    else if(tableView.tag == 205)
    {
        [self updateFilterList:_baseView.typeList tag:202];
        
        ZGJobTypeEntity *typeEntity = [typeArr objectAtIndex:indexPath.row];
        currentSelectedsearchJobType = typeEntity;
        
        [_baseView.typeFilterBtn setTitle:typeEntity.name forState:UIControlStateNormal];
        
        searchParam.typeId = typeEntity.identity;
        if(searchParam.keyword && ![searchParam.keyword isEqualToString:@""])
            [self reUpdateList];
        
    }
    else if(tableView.tag == 206)
    {
        [self updateFilterList:_baseView.locationList tag:203];
        
        ZGAreaEntity *areaEntity = [locationArr objectAtIndex:indexPath.row];
        currentSelectedsearchJobArea = areaEntity;
        
        [_baseView.locationFilterBtn setTitle:areaEntity.name forState:UIControlStateNormal];

        searchParam.areaId = areaEntity.identity;
        if(searchParam.keyword && ![searchParam.keyword isEqualToString:@""])
            [self reUpdateList];
    }
    else
    {
        if(searchArr.count)
        {
            ZGJobEntity *tmpEntity  = [searchArr objectAtIndex:indexPath.row];
            
            ZGBrowseRecordEntity *browseRecordEntity = [[ZGBrowseRecordEntity alloc]init];
            browseRecordEntity.jobEntity = tmpEntity;
            browseRecordEntity.date = [NSDate date];
            
            [[ZGDatabaseHelper shareHelper]insertOnJobTableWithEntity:browseRecordEntity];
            
            ZGJobDetailParam *param = [[ZGJobDetailParam alloc]init];
            param.jobId = tmpEntity.identity;
            if(userInfoEntity)
                param.userId = userInfoEntity.identity;
            
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            ZGJobDetailController *detailController = [[ZGJobDetailController alloc]init];
            detailController.param = param;
            [self.navigationController pushViewController:detailController animated:NO];
        }
        else
        {
            ZGSearchRecordEntity *tmpEntity = [searchHistoryArr objectAtIndex:indexPath.row];
            _baseView.searchText.text = tmpEntity.keyWord;
            NSArray *conditions = [tmpEntity.condition componentsSeparatedByString:@"/"];
            [_baseView.genderFilterBtn setTitle:[conditions objectAtIndex:0] forState:UIControlStateNormal];
            [_baseView.typeFilterBtn setTitle:[conditions objectAtIndex:1] forState:UIControlStateNormal];
            [_baseView.locationFilterBtn setTitle:[conditions objectAtIndex:2] forState:UIControlStateNormal];
            
            searchParam.keyword = _baseView.searchText.text;
            if(tmpEntity.sex)
                searchParam.sex = tmpEntity.sex;
            if(tmpEntity.typeId)
                searchParam.typeId = tmpEntity.typeId;
            if(tmpEntity.locationId)
                searchParam.areaId = tmpEntity.locationId;
            
            [searchHistoryArr removeAllObjects];
            [_baseView.jobListTableView reloadData];
            
            [self reUpdateList];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(!(tableView.tag == 204 || tableView.tag == 205 || tableView.tag == 206))
    {
        if(!searchHistoryArr.count)
            return 0;
        return 50;
    }
    
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZGBaseView *backView = [[ZGBaseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    backView.backgroundColor = VIEW_BACKGROUND;
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 50 - 15, 50)];
    text.text = @"    搜索历史";
    text.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    text.textColor = APP_FONT_COLOR_NORMAL;
    text.backgroundColor = [UIColor clearColor];
    [backView addSubview:text];
    
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleBtn.backgroundColor = [UIColor clearColor];
    [deleBtn setBackgroundImage:[UIImage imageNamed:@"delete_btn_icon_pressed"] forState:UIControlStateNormal];
    [deleBtn setBackgroundImage:[UIImage imageNamed:@"delete_btn_icon_normal"] forState:UIControlStateHighlighted];
    deleBtn.frame = CGRectMake(SCREEN_WIDTH - 50 - 15, (50 - 45) / 2, 50, 45);
    [backView addSubview:deleBtn];
    [deleBtn addTarget:self action:@selector(deleteRecord:) forControlEvents:UIControlEventTouchUpInside];
    
    ZGBaseView *line = [[ZGBaseView alloc]initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = SeparatorColor;
    [backView addSubview:line];
    
    
    return backView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_baseView.searchText resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(noRecordView)
    noRecordView.hidden = YES;
    
    if ([string isEqualToString:@"\n"])
    {
        searchParam.keyword = _baseView.searchText.text;
        ZGSearchRecordEntity *entity = [[ZGSearchRecordEntity alloc]init];
        entity.keyWord = searchParam.keyword;
        entity.searchDate = [NSDate date];
        entity.sex = searchParam.sex;
        NSString *condition = @"";
        if(searchParam.sex == 1)
            condition = @"男";
        else if(searchParam.sex == 2)
            condition = @"女";
        else
            condition = @"性别不限";
        condition = [condition stringByAppendingString:@"/"];
        if(currentSelectedsearchJobType)
            condition = [[condition stringByAppendingString:currentSelectedsearchJobType.name]stringByAppendingString:@"/"];
        else
            condition = [[condition stringByAppendingString:@"类型不限"]stringByAppendingString:@"/"];
        if(currentSelectedsearchJobArea)
            condition = [condition stringByAppendingString:currentSelectedsearchJobArea.name];
        else
            condition = [condition stringByAppendingString:@"地区不限"];
        entity.condition = condition;
        
        entity.typeId = currentSelectedsearchJobType.identity;
        entity.locationId = currentSelectedsearchJobArea.identity;
        [[ZGDatabaseHelper shareHelper]insertOnSearchHistoryTableWithEntity:entity];
        
        [self reUpdateList];
        
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark - cancel button clicked
- (void)cancelButtonClicked:(UIButton *)button
{
    [_baseView.searchText resignFirstResponder];
    _baseView.searchText.text = @"";
    
    [UIView animateWithDuration:0.3 animations:^{
        [self transitionView:NO];
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }];
}

- (void)transitionView:(BOOL)isFirst
{
    if(!_baseView.genderList.hidden)
        [self updateFilterList:_baseView.genderList tag:201];
    if(!_baseView.typeList.hidden)
        [self updateFilterList:_baseView.typeList tag:202];
    if(!_baseView.locationList.hidden)
        [self updateFilterList:_baseView.locationList tag:203];

    if(isFirst)
    {
        [_baseView.genderFilterBtn setTitle:@"性别不限" forState:UIControlStateNormal];
        [_baseView.typeFilterBtn setTitle:@"类型不限" forState:UIControlStateNormal];
        [_baseView.locationFilterBtn setTitle:@"地区不限" forState:UIControlStateNormal];
        [searchArr removeAllObjects];
        [_baseView.jobListTableView reloadData];
    }
    else
    {
        _baseView.searchText.frame = MainPageSearchTextFrameNormal;
    }
    
}
#pragma mark - ZGFailImgAlertViewIphoneDelegate
- (void)tapOnAlertView
{
    if(searchFail)
    {
        [self reUpdateList];
        searchFail.hidden = YES;
        searchFail = nil;
    }
    if(searchHeaderLoadFail)
    {
        [self headerUpdate];
        searchHeaderLoadFail.hidden = YES;
        searchHeaderLoadFail = nil;
    }
    if(searchFooterLoadFail)
    {
        [self footerUpdate];
        searchFooterLoadFail.hidden = YES;
        searchFooterLoadFail = nil;
    }
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
