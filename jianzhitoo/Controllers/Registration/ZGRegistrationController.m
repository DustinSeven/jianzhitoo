//
//  ZGRegistrationController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/13/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegistrationController.h"
#import "ZGRegistrationCell.h"
#import "ZGRegistrationSuccessController.h"
#import "ZGJobDateShortParam.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGRegistrationProcess.h"
#import "ZGJobDateShortEntity.h"
#import "ZGRegistrationShortParam.h"
#import "ZGJobDateLongEntity.h"
#import "ZGRegistrationLongParam.h"
#import "ZGBaseNavigationController.h"

@interface ZGRegistrationController ()<GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewActionDelegate,GMGridViewTransformationDelegate,ZGFailImgAlertViewIphoneDelegate>
{
    ZGRegistrationViewBase *_baseView;
    
    ZGUserInfoEntity *userInfoEntity;
    
     ZGFailImgAlertViewIphone *loadDetailFailAlert;
    
    NSMutableArray *dateArr;
    NSMutableArray *selectedDateArr;
    
    ZGJobDateLongEntity *longEntity;
    
    ZGRegistrationLongParam *longParam;
    ZGRegistrationShortParam *shortParam;
    
    BOOL isLongTermSelected;
    int longNum;
}

@end

@implementation ZGRegistrationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.title = @"我要报名";
        
        isLongTermSelected = NO;
        longNum= 0;
        
        userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
        
        longParam = [[ZGRegistrationLongParam alloc]init];
        shortParam = [[ZGRegistrationShortParam alloc]init];
        
        dateArr = [NSMutableArray array];
        selectedDateArr = [NSMutableArray array];
        
        _baseView = [[ZGRegistrationViewIphone alloc]init];
        self.view = _baseView;
    
        _baseView.baseGridView.actionDelegate = self;
        _baseView.baseGridView.sortingDelegate = self;
        _baseView.baseGridView.transformDelegate = self;
        _baseView.baseGridView.dataSource = self;
        
        [_baseView.submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if([self.workTimeType isEqualToString:@"longterm"])
        {
            _baseView.baseGridView.minEdgeInsets = UIEdgeInsetsMake(0, (SCREEN_WIDTH - RegistrationCellWithHeight) / 2, 0, 0);
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadList];
        
}

- (void)loadList
{
    ZGJobDateShortParam *shortDateParam = [[ZGJobDateShortParam alloc]init];
    if(userInfoEntity)
    {
        shortDateParam.userId = userInfoEntity.identity;
        shortDateParam.mobile = userInfoEntity.mobile;
        shortDateParam.password = userInfoEntity.password;
        shortDateParam.jobId = self.jobId;
    }
    
    if([self.workTimeType isEqualToString:@"shortterm"])
    {
        [[ZGRegistrationProcess shareInstance]getShortDateWithParam:[shortDateParam getDictionary] parentView:_baseView success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if([[responseObject objectForKey:@"code"]intValue] == 200)
            {
                NSArray *arr = [responseObject objectForKey:@"data"];
                [dateArr removeAllObjects];
                for(int i = 0;i<arr.count;++i)
                {
                    ZGJobDateShortEntity *tmpEntity = [[ZGJobDateShortEntity alloc]initWithAttributes:[arr objectAtIndex:i]];
                    [dateArr addObject:tmpEntity];
                }
                
                [_baseView.baseGridView reloadData];
            }
            else
            {
                [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            loadDetailFailAlert = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseGridView];
        }];
    }
    else
    {
        [[ZGRegistrationProcess shareInstance]getLongDateWithParam:[shortDateParam getDictionary] parentView:_baseView success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if([[responseObject objectForKey:@"code"]intValue] == 200)
            {
                longEntity = [[ZGJobDateLongEntity alloc]init];
                longEntity.code = 200;
                longNum = 1;
                [_baseView.baseGridView reloadData];
            }
            else if([[responseObject objectForKey:@"code"]intValue] == 300)
            {
                longEntity = [[ZGJobDateLongEntity alloc]init];
                longEntity.code = 300;
                longNum = 1;
                [_baseView.baseGridView reloadData];
            }
            else
            {
                [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            loadDetailFailAlert = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseGridView];
        }];

    }

}

#pragma mark - ZGFailImgAlertViewIphoneDelegate
- (void)tapOnAlertView
{
    loadDetailFailAlert.hidden = YES;
    [self loadList];
}

#pragma  mark - submit btn clicked
- (void)submitBtnClicked:(UIButton *)button
{
    if([self.workTimeType isEqualToString:@"shortterm"])
    {
        if(selectedDateArr.count)
        {
            NSString *workDate = @"";
            for(int i = 0;i<selectedDateArr.count;++i)
            {
                ZGJobDateShortEntity *tmpEntity = [selectedDateArr objectAtIndex:i];
                if(workDate.length)
                    workDate = [workDate stringByAppendingString:[NSString stringWithFormat:@",%@",tmpEntity.workDate]];
                else
                    workDate = [workDate stringByAppendingString:tmpEntity.workDate];
            }
            shortParam.userId = userInfoEntity.identity;
            shortParam.mobile = userInfoEntity.mobile;
            shortParam.password = userInfoEntity.password;
            shortParam.jobId = self.jobId;
            shortParam.workDate = workDate;
            
            [[ZGRegistrationProcess shareInstance]registrationShortWithParam:[shortParam getDictionary] parentView:nil text:@"报名中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    ZGRegistrationSuccessController *registrationSuccessController = [[ZGRegistrationSuccessController alloc]init];
                    if(self.jobDetailController)
                    {
                        self.jobDetailController.isDataChanged = YES;
                        registrationSuccessController.jobDetailController = self.jobDetailController;
                        registrationSuccessController.jobName = self.jobName;
                        registrationSuccessController.shareUrl = self.shareUrl;
                        registrationSuccessController.mobile = [responseObject objectForKey:@"mobile"];
                    }
                    ZGBaseNavigationController *regiNav = [[ZGBaseNavigationController alloc]initWithRootViewController:registrationSuccessController];
                    [self presentViewController:regiNav animated:YES completion:^{
                        
                        [self.navigationController popViewControllerAnimated:NO];
                    }];
                }
                else
                {
                    [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
            }];
        }
        else
        {
            [ZGUtility showAlertWithText:@"您还没选择兼职日期呢！" parentView:nil];
        }
    }
    else
    {
        if(isLongTermSelected)
        {
            longParam.userId = userInfoEntity.identity;
            longParam.mobile = userInfoEntity.mobile;
            longParam.password = userInfoEntity.password;
            longParam.jobId = self.jobId;
            
            [[ZGRegistrationProcess shareInstance]registrationLongWithParam:[longParam getDictionary] parentView:nil text:@"报名中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    NSArray *data = [responseObject objectForKey:@"data"];
                    ZGRegistrationSuccessController *registrationSuccessController = [[ZGRegistrationSuccessController alloc]init];
                    registrationSuccessController.jobDetailController = self.jobDetailController;
                    registrationSuccessController.jobName = self.jobName;
                    registrationSuccessController.shareUrl = self.shareUrl;
                    registrationSuccessController.mobile = [[data objectAtIndex:0] objectForKey:@"mobile"];
                    ZGBaseNavigationController *nav = [[ZGBaseNavigationController alloc]initWithRootViewController:registrationSuccessController];
                    [self.navigationController presentViewController:nav animated:YES completion:^{
                        
                        [self.navigationController popViewControllerAnimated:NO];
                    }];
                }
                else
                {
                    [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
            }];
        }
        else
        {
            [ZGUtility showAlertWithText:@"您还没选择兼职日期呢！" parentView:nil];
        }
    }
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    if([self.workTimeType isEqualToString:@"shortterm"])
        return dateArr.count;
    return longNum;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(RegistrationCellWithHeight, RegistrationCellWithHeight);
    
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    
//    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    ZGRegistrationCell *cell = (ZGRegistrationCell *)[gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[ZGRegistrationCell alloc] init];
    }
    if([self.workTimeType isEqualToString:@"shortterm"])
    {
        ZGJobDateShortEntity *tmpEntity = [dateArr objectAtIndex:index];
        NSRange monthRange = NSMakeRange(5, 2);
        NSString *month = [[tmpEntity.workDate substringWithRange:monthRange] stringByAppendingString:@"月\n"];
        NSRange dayRange = NSMakeRange(8, 2);
        NSString *day = [[tmpEntity.workDate substringWithRange:dayRange] stringByAppendingString:@"日"];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",month,day]];
        NSRange range1 = NSMakeRange(0, 3);
        NSRange range2 = NSMakeRange(str.string.length - 3, 3);
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL] range:range1];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL + 3] range:range2];
        cell.textLab.attributedText = str;
        
        [cell chooseStatus:RegistrationCellType_add];

        if(tmpEntity.full == 1 || tmpEntity.userEnRoll == 1)
            [cell chooseStatus:RegistrationCellType_cancel];
    }
    else
    {
        [cell chooseStatus:RegistrationCellType_add];
        cell.textLab.text = @"日期\n不限";
        
        if(longEntity.code == 300)
            [cell chooseStatus:RegistrationCellType_cancel];
    }
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
    ZGRegistrationCell *cell = (ZGRegistrationCell *)[gridView cellForItemAtIndex:position];
    if(cell.cellType == RegistrationCellType_add)
    {
        [cell chooseStatus:RegistrationCellType_added];
        
        if([self.workTimeType isEqualToString:@"shortterm"])
        {
            ZGJobDateShortEntity *tmpEntity = [dateArr objectAtIndex:position];
            [selectedDateArr addObject:tmpEntity];
        }
        else
        {
            isLongTermSelected = YES;
        }
    }
    else if(cell.cellType == RegistrationCellType_added)
    {
        [cell chooseStatus:RegistrationCellType_add];
        
        if([self.workTimeType isEqualToString:@"shortterm"])
        {
            for(int i = 0;i<selectedDateArr.count ;++i)
            {
                ZGJobDateShortEntity *tmpEntity = [dateArr objectAtIndex:position];
                ZGJobDateShortEntity *entity = [selectedDateArr objectAtIndex:i];
                if([entity.workDate isEqualToString:tmpEntity.workDate])
                {
                    [selectedDateArr removeObjectAtIndex:i];
                }
            }
        }
        else
        {
            isLongTermSelected = NO;
        }
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

- (void)didReceiveMemoryWarning
{
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
