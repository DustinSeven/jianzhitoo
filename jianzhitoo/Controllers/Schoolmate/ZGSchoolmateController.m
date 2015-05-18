//
//  ZGSchoolmateController.m
//  jianzhitoo
//
//  Created by 李明伟 on 12/12/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSchoolmateController.h"
#import "ZGSchoolmateCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface ZGSchoolmateController ()<GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewActionDelegate,GMGridViewTransformationDelegate,ZGFailImgAlertViewIphoneDelegate>
{
    ZGSchoolmateViewBase *_baseView;
    
    NSMutableArray *schoolmateArr;
    
    int cuurentSchoolmateIndex;
    
    ZGFailImgAlertViewIphone *noRecordView;
    
     ZGFailImgAlertViewIphone *loadFailAlert;
}

@end

@implementation ZGSchoolmateController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        schoolmateArr = [NSMutableArray array];
        
        _baseView = [[ZGSchoolmateViewIphone alloc]init];
        self.view = _baseView;
        
        [_baseView.headView.backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        _baseView.baseGridView.actionDelegate = self;
        _baseView.baseGridView.sortingDelegate = self;
        _baseView.baseGridView.transformDelegate = self;
        _baseView.baseGridView.dataSource = self;
        
        [_baseView.baseGridView addHeaderWithTarget:self
                                                 action:@selector(headerUpload)];
        _baseView.baseGridView.headerPullToRefreshText = @"下拉刷新";
        _baseView.baseGridView.headerReleaseToRefreshText = @"释放刷新";
        _baseView.baseGridView.headerRefreshingText = @"刷新中...";
        
        [_baseView.baseGridView addFooterWithTarget:self action:@selector(footerUpload)];
        _baseView.baseGridView.footerPullToRefreshText = @"上拉刷新";
        _baseView.baseGridView.footerReleaseToRefreshText = @"释放刷新";
        _baseView.baseGridView.footerRefreshingText = @"刷新中...";
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadList];
}

- (void)loadList
{
    [[ZGSchoolmateProcess shareInstance]getSchoolmateWithParam:[self.param getDictionary] parentView:_baseView success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [responseObject objectForKey:@"data"];
            for(int i = 0;i<data.count;++i)
            {
                ZGSchoolmateEntity *entity = [[ZGSchoolmateEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [schoolmateArr addObject:entity];
            }
            [_baseView.baseGridView reloadData];
            
        }
        else
        {
            if(!noRecordView)
                noRecordView = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"no_record_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseGridView];
            else
                noRecordView.hidden = NO;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        loadFailAlert = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseGridView];
        
    }];
}

- (void)headerUpload
{
    self.param.page = 1;
    [[ZGSchoolmateProcess shareInstance]getSchoolmateWithParam:[self.param getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            [schoolmateArr removeAllObjects];
            NSArray *data = [responseObject objectForKey:@"data"];
            for(int i = 0;i<data.count;++i)
            {
                ZGSchoolmateEntity *entity = [[ZGSchoolmateEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [schoolmateArr addObject:entity];
            }
            [_baseView.baseGridView reloadData];
        }
        else
        {

        }
        
        [_baseView.baseGridView headerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        loadFailAlert = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseGridView];
        [_baseView.baseGridView headerEndRefreshing];
    }];
    
}

- (void)footerUpload
{
    self.param.page++;
    [[ZGSchoolmateProcess shareInstance]getSchoolmateWithParam:[self.param getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [responseObject objectForKey:@"data"];
            for(int i = 0;i<data.count;++i)
            {
                ZGSchoolmateEntity *entity = [[ZGSchoolmateEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [schoolmateArr addObject:entity];
            }
            [_baseView.baseGridView reloadData];
            
        }
        else
        {

        }
        [_baseView.baseGridView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        loadFailAlert = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseGridView];
        [_baseView.baseGridView footerEndRefreshing];
    }];
    
}


//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return schoolmateArr.count;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(SchoolmateCellWithHeight, SchoolmateCellWithHeight + 20);
    
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    ZGSchoolmateCell *cell = (ZGSchoolmateCell *)[gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[ZGSchoolmateCell alloc] init];
    }
    ZGSchoolmateEntity *tmpEntity = [schoolmateArr objectAtIndex:index];
    if(tmpEntity.userImg)
        [cell.schoolmateImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,tmpEntity.userImg]] placeholderImage:[UIImage imageNamed:@"user_img_default_90px"] isScaleToCustomSize:NO];
    else
        cell.schoolmateImg.image = [UIImage imageNamed:@"user_img_default_90px"];
    
    if(tmpEntity.account)
        cell.schoolmateLab.text = tmpEntity.account;
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return YES; //index % 2 == 0;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    ZGSchoolmateEntity *tmpEntity = [schoolmateArr objectAtIndex:position];
    if(tmpEntity.ota)
    {
        cuurentSchoolmateIndex = (int)position;
        ZGSchoolmateAlertViewIphone *schoolmateAlert = [ZGUtility showSchoolmateAlertWithEntity:[schoolmateArr objectAtIndex:position] parentView:nil];
        [schoolmateAlert.callBtn addTarget:self action:@selector(callBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewSortingDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor orangeColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}

- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    return YES;
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    
}


//////////////////////////////////////////////////////////////
#pragma mark DraggableGridViewTransformingDelegate
//////////////////////////////////////////////////////////////

- (CGSize)GMGridView:(GMGridView *)gridView sizeInFullSizeForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index inInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(52.5, 52.5);
    
}

- (UIView *)GMGridView:(GMGridView *)gridView fullSizeViewForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    UIView *fullView = [[UIView alloc] init];
    return fullView;
}

- (void)GMGridView:(GMGridView *)gridView didStartTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor blueColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEndTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEnterFullSizeForCell:(UIView *)cell
{
    
}

#pragma mark call btn clicked
- (void)callBtnClicked:(UIButton *)button
{
    ZGSchoolmateEntity *tmpEntity = [schoolmateArr objectAtIndex:cuurentSchoolmateIndex];
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"telprompt://%@",tmpEntity.mobile]];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        NSLog(@"no");
    }
}

#pragma mark - ZGFailImgAlertViewIphoneDelegate
- (void)tapOnAlertView
{
    loadFailAlert.hidden = YES;
    [self loadList];
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
