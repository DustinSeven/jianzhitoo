//
//  ZGUserInfoChangeController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/13/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUserInfoChangeController.h"
#import "ZGUserInfoChangeSchoolCell.h"
#import "ZGChangeUserInfoProcess.h"
#import "ZGProvinceEntity.h"
#import "ZGChangeInfoCell.h"
#import "ZGCityParam.h"
#import "ZGCityEntity.h"
#import "ZGAreaEntity.h"
#import "ZGAreaParam.h"
#import "ZGUpdateLocationParam.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGCollegeEntity.h"
#import "ZGCollegeParam.h"
#import "ZGDepartmentEntity.h"
#import "ZGDepartmentParam.h"
#import "ZGSchoolParam.h"
#import "ZGAccountParam.h"
#import "ZGQQParam.h"
#import "ZGSpecialtyParam.h"


@interface ZGUserInfoChangeController ()<PushTreeViewDataSource, PushTreeViewDelegate>
{
    ZGUserInfoChangeViewBase *_baseView;
    
    NSMutableArray *provinceArr;
    NSMutableArray *cityArr;
    NSMutableArray *areaArr;
    
    NSMutableArray *collegeArr;
    NSMutableArray *departmentArr;
    
    ZGProvinceEntity *selectedProvinceEntity;
    ZGCityEntity *selectedCityEntity;
    ZGAreaEntity *selectedAreaEntity;
    
    ZGCollegeEntity *selectedCollegeEntity;
    ZGDepartmentEntity *selectedDepartmentEntity;
    
    ZGUserInfoEntity *userInfoEntity;
    
    UISwipeGestureRecognizer *baseGestrueRecognize;
}

@end

@implementation ZGUserInfoChangeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        provinceArr = [NSMutableArray array];
        cityArr = [NSMutableArray array];
        areaArr = [NSMutableArray array];
        
        collegeArr = [NSMutableArray array];
        departmentArr = [NSMutableArray array];
        
        baseGestrueRecognize = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(baseViewSwipe:)];
        
        userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
        
        _baseView = [[ZGUserInfoChangeViewIphone alloc]init];
        self.view = _baseView;
        
        [_baseView addGestureRecognizer:baseGestrueRecognize];
       
        [_baseView chooseViewWithType:self.changeType];
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.changeType == UserInfoChangeType_Province || self.changeType == UserInfoChangeType_College)
    {
        [[ZGChangeUserInfoProcess shareInstance]getAllProvinceWithParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if([[responseObject objectForKey:@"code"]intValue] == 200)
            {
                NSArray *data = [responseObject objectForKey:@"data"];
                for(int i = 0;i<data.count;++i)
                {
                    ZGProvinceEntity *tmpEntity = [[ZGProvinceEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                    [provinceArr addObject:tmpEntity];
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
    else
    {
        self.navigationItem.rightBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"保存" target:self action:@selector(saveBtnClicked:) spacing:-15];
    }
}

#pragma mark - save btn clicked
- (void)saveBtnClicked:(UIButton *)button
{
    if(![[_baseView.usernameText.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
    {
        if(self.changeType == UserInfoChangeType_Username)
        {
            ZGAccountParam *accountParam = [[ZGAccountParam alloc]init];
            accountParam.userId = userInfoEntity.identity;
            accountParam.mobile = userInfoEntity.mobile;
            accountParam.password = userInfoEntity.password;
            accountParam.account =  [_baseView.usernameText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            [[ZGChangeUserInfoProcess shareInstance]updateUserInfoWithParam:[accountParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    userInfoEntity.account = accountParam.account;
                    userInfoEntity.account = accountParam.account;
                    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
                    [ZGUtility saveUserDefaults:userInfoEntity key:USERDEFAULTS_USER_INFO_KEY];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
                
            }];
        }
        
        if(self.changeType == UserInfoChangeType_QQ)
        {
            ZGQQParam *qqParam = [[ZGQQParam alloc]init];
            qqParam.userId = userInfoEntity.identity;
            qqParam.mobile = userInfoEntity.mobile;
            qqParam.password = userInfoEntity.password;
            qqParam.qq =  [_baseView.usernameText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            [[ZGChangeUserInfoProcess shareInstance]updateUserInfoWithParam:[qqParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    userInfoEntity.qq = qqParam.qq;
                    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
                    [ZGUtility saveUserDefaults:userInfoEntity key:USERDEFAULTS_USER_INFO_KEY];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
                
            }];
        }
        
        if(self.changeType == UserInfoChangeType_Specialty)
        {
            ZGSpecialtyParam *specialtyParam = [[ZGSpecialtyParam alloc]init];
            specialtyParam.userId = userInfoEntity.identity;
            specialtyParam.mobile = userInfoEntity.mobile;
            specialtyParam.password = userInfoEntity.password;
            specialtyParam.specialty =  [_baseView.usernameText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            [[ZGChangeUserInfoProcess shareInstance]updateUserInfoWithParam:[specialtyParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    userInfoEntity.specialty = specialtyParam.specialty;
                    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
                    [ZGUtility saveUserDefaults:userInfoEntity key:USERDEFAULTS_USER_INFO_KEY];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
                
            }];
        }


    }
    else
    {
        [ZGUtility showAlertWithText:@"您还没完成输入！" parentView:nil];
    }
}

#pragma mark - base view swipe
- (void)baseViewSwipe:(UISwipeGestureRecognizer *)recognize
{
    NSLog(@"%ld",(long)_baseView.baseTableView.level);
    
    if (recognize.direction == UISwipeGestureRecognizerDirectionRight) {
        if(_baseView.baseTableView.level > 0)
           [_baseView.baseTableView back];
    }
}

#pragma mark - PushTreeViewDataSource
- (NSInteger)numberOfSectionsInLevel:(NSInteger)level
{
    return 1;
}

- (NSInteger)numberOfRowsInLevel:(NSInteger)level section:(NSInteger)section
{
    if(self.changeType == UserInfoChangeType_Province)
    {
        if(level == 0)
            return provinceArr.count;
        if(level == 1)
            return cityArr.count;
        if(level == 2)
            return areaArr.count;
    }
    if(self.changeType == UserInfoChangeType_College)
    {
        if(level == 0)
            return provinceArr.count;
        if(level == 1)
            return collegeArr.count;
        if(level == 2)
            return departmentArr.count;
    }
    return 0;
}

- (InfiniteTreeBaseCell *)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    static NSString *identifier = @"ChangeInfoCell";
    ZGChangeInfoCell *cell = (ZGChangeInfoCell*)[pushTreeView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZGChangeInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(self.changeType == UserInfoChangeType_Province)
    {
        if(level == 0)
        {
            ZGProvinceEntity *tmpEntity = [provinceArr objectAtIndex:indexPath.row];
            cell.textLabel.text = tmpEntity.name;
        }
        if(level == 1)
        {
            ZGCityEntity *tmpEntity = [cityArr objectAtIndex:indexPath.row];
            cell.textLabel.text = tmpEntity.name;
        }
        if(level == 2)
        {
            ZGAreaEntity *tmpEntity = [areaArr objectAtIndex:indexPath.row];
            cell.textLabel.text = tmpEntity.name;
        }
    }
    
    if(self.changeType == UserInfoChangeType_College)
    {
        if(level == 0)
        {
            ZGProvinceEntity *tmpEntity = [provinceArr objectAtIndex:indexPath.row];
            cell.textLabel.text = tmpEntity.name;
        }
        if(level == 1)
        {
            ZGCollegeEntity *tmpEntity = [collegeArr objectAtIndex:indexPath.row];
            cell.textLabel.text = tmpEntity.name;
        }
        if(level == 2)
        {
            ZGDepartmentEntity *tmpEntity = [departmentArr objectAtIndex:indexPath.row];
            cell.textLabel.text = tmpEntity.name;
        }
    }
    
    
    return cell;
}

#pragma mark - PushTreeViewDelegate
- (void)pushTreeView:(InfiniteTreeView *)pushTreeView didSelectedLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    if(self.changeType == UserInfoChangeType_Province)
    {
        if(level == 0)
        {
            ZGCityParam *cityParam = [[ZGCityParam alloc]init];
            selectedProvinceEntity = [provinceArr objectAtIndex:indexPath.row];
            cityParam.provinceId = selectedProvinceEntity.identity;
            [[ZGChangeUserInfoProcess shareInstance]getCityWithParam:[cityParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 if([[responseObject objectForKey:@"code"]intValue] == 200)
                 {
                     NSArray *data = [responseObject objectForKey:@"data"];
                     [cityArr removeAllObjects];
                     for(int i = 0;i<data.count;++i)
                     {
                         ZGCityEntity *tmpCityEntity = [[ZGCityEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                         [cityArr addObject:tmpCityEntity];
                     }
                     [_baseView.baseTableView reloadLastTabData];
                 }
                 else
                 {
                     [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                 }
                 
             }
                                                             failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
             }];
        }
        
        if(level == 1)
        {
            ZGAreaParam *areaParam = [[ZGAreaParam alloc]init];
            selectedCityEntity = [cityArr objectAtIndex:indexPath.row];
            areaParam.cityId = selectedCityEntity.identity;
            [[ZGChangeUserInfoProcess shareInstance]getAreaWithParam:[areaParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 if([[responseObject objectForKey:@"code"]intValue] == 200)
                 {
                     NSArray *data = [responseObject objectForKey:@"data"];
                     [areaArr removeAllObjects];
                     for(int i = 0;i<data.count;++i)
                     {
                         ZGAreaEntity *tmpAreaEntity = [[ZGAreaEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                         [areaArr addObject:tmpAreaEntity];
                     }
                     [_baseView.baseTableView reloadLastTabData];
                 }
                 else
                 {
                     [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                 }
                 
             }
                                                             failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
             }];
        }
        
        if(level == 2)
        {
            selectedAreaEntity = [areaArr objectAtIndex:indexPath.row];
            
            ZGUpdateLocationParam *locationParam = [[ZGUpdateLocationParam alloc]init];
            locationParam.provinceId = selectedProvinceEntity.identity;
            locationParam.cityId = selectedCityEntity.identity;
            locationParam.areaId = selectedAreaEntity.identity;
            locationParam.userId = userInfoEntity.identity;
            locationParam.password = userInfoEntity.password;
            locationParam.mobile = userInfoEntity.mobile;
            
            [[ZGChangeUserInfoProcess shareInstance]updateUserInfoWithParam:[locationParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    userInfoEntity.provinceId = selectedProvinceEntity.identity;
                    userInfoEntity.province = selectedProvinceEntity.name;
                    userInfoEntity.cityId = selectedCityEntity.identity;
                    userInfoEntity.city = selectedCityEntity.name;
                    userInfoEntity.areaId = selectedAreaEntity.identity;
                    userInfoEntity.area = selectedAreaEntity.name;
                    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
                    [ZGUtility saveUserDefaults:userInfoEntity key:USERDEFAULTS_USER_INFO_KEY];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
                
            }];
        }

    }
    
    if(self.changeType == UserInfoChangeType_College)
    {
        if(level == 0)
        {
            ZGCollegeParam *collegeParam = [[ZGCollegeParam alloc]init];
            selectedProvinceEntity = [provinceArr objectAtIndex:indexPath.row];
            collegeParam.provinceId = selectedProvinceEntity.identity;
            [[ZGChangeUserInfoProcess shareInstance]getCollegeWithParam:[collegeParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    NSArray *data = [responseObject objectForKey:@"data"];
                    [collegeArr removeAllObjects];
                    for(int i = 0;i<data.count;++i)
                    {
                        ZGCollegeEntity *tmpCollegeEntity = [[ZGCollegeEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                        [collegeArr addObject:tmpCollegeEntity];
                    }
                    [_baseView.baseTableView reloadLastTabData];
                    
                }
                else
                {
                    [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
            }];
        }
        
        if(level == 1)
        {
            ZGDepartmentParam *departmentParam = [[ZGDepartmentParam alloc]init];
            selectedCollegeEntity = [collegeArr objectAtIndex:indexPath.row];
            departmentParam.collegeId = selectedCollegeEntity.identity;
            [[ZGChangeUserInfoProcess shareInstance]getDepartmentWithParam:[departmentParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    NSArray *data = [responseObject objectForKey:@"data"];
                    [departmentArr removeAllObjects];
                    for(int i = 0;i<data.count;++i)
                    {
                        ZGDepartmentEntity *tmpDepartmentEntity = [[ZGDepartmentEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                        [departmentArr addObject:tmpDepartmentEntity];
                    }
                    [_baseView.baseTableView reloadLastTabData];
                    
                }
                else
                {
                    [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
            }];
        }
        
        if(level == 2)
        {
            selectedDepartmentEntity = [departmentArr objectAtIndex:indexPath.row];
            
            ZGSchoolParam *schoolParam = [[ZGSchoolParam alloc]init];
            schoolParam.collegeId = selectedCollegeEntity.identity;
            schoolParam.departmentId = selectedDepartmentEntity.identity;
            schoolParam.userId = userInfoEntity.identity;
            schoolParam.password = userInfoEntity.password;
            schoolParam.mobile = userInfoEntity.mobile;
            
            [[ZGChangeUserInfoProcess shareInstance]updateUserInfoWithParam:[schoolParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    userInfoEntity.collegeId = selectedCollegeEntity.identity;
                    userInfoEntity.college = selectedCollegeEntity.name;
                    userInfoEntity.depatmentId = selectedDepartmentEntity.identity;
                    userInfoEntity.depatment = selectedDepartmentEntity.name;
                    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
                    [ZGUtility saveUserDefaults:userInfoEntity key:USERDEFAULTS_USER_INFO_KEY];
                    
                    userInfoEntity.collegeId = selectedCollegeEntity.identity;
                    userInfoEntity.college = selectedCollegeEntity.name;
                    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
                    [ZGUtility saveUserDefaults:userInfoEntity key:USERDEFAULTS_USER_INFO_KEY];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
                
            }];
        }


    }
    
}

- (UIView *)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level viewForHeaderInSection:(NSInteger)section
{
    CGFloat headerHeight = ChangeInfoCellHeight;
    UIView *headerview = nil;
    headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, headerHeight)];
    headerview.backgroundColor = RGBCOLOR(233, 238, 247);
    UILabel *titL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, headerHeight)];
    titL.textColor = RGBCOLOR(104, 104, 104);
    titL.backgroundColor = [UIColor clearColor];
    titL.font = [UIFont boldSystemFontOfSize:16];
    [headerview addSubview:titL];
    
    if(self.changeType == UserInfoChangeType_Province)
    {
        if(level == 0)
            titL.text = @"省份";
        if(level == 1)
            titL.text = @"市/县";
        if(level == 2)
            titL.text = @"区";
    }
    
    if(self.changeType == UserInfoChangeType_College)
    {
        if(level == 0)
            titL.text = @"省份";
        if(level == 1)
            titL.text = @"学校";
        if(level == 2)
            titL.text = @"院系";
    }
    return headerview;
}

- (CGFloat)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level heightForHeaderInSection:(NSInteger)section
{
    return ChangeInfoCellHeight;
}

- (CGFloat)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ChangeInfoCellHeight;
}

- (BOOL)pushTreeViewHasNextLevel:(InfiniteTreeView *)pushTreeView currentLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    if(self.changeType == UserInfoChangeType_Province)
    {
        if (level >= 2 )
        {
            return NO;
        }
    }
    if(self.changeType == UserInfoChangeType_College)
    {
        if (level >= 2 )
        {
            return NO;
        }
    }
    return YES;
}

- (void)pushTreeViewWillReloadAtLevel:(InfiniteTreeView*)pushTreeView currentLevel:(NSInteger)currentLevel level:(NSInteger)level                            indexPath:(NSIndexPath*)indexPath
{
//    NSLog(@"current level %ld level %ld", currentLevel, level);
}


#pragma mark - back button clicked
- (void)backBtnClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
