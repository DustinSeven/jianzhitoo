//
//  ZGPrivcySettingController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGPrivcySettingController.h"
#import "ZGPrivacyViewIphone.h"
#import "ZGProvacySettingProcess.h"
#import "ZGGetProvacyParam.h"
#import "ZGSetProvacyParam.h"
#import "ZGProvacyEntity.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"

@interface ZGPrivcySettingController ()<UITableViewDataSource,UITableViewDelegate>
{
    ZGPrivacyViewBase *_baseView;

    ZGSetProvacyParam *setProvacyParam;
    
    ZGUserInfoEntity *userInfoEntity;
}

@end

@implementation ZGPrivcySettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(IS_PHONE)
    {
        self.title = @"隐私设置";
        
        userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
        
//        self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(backBtnClicked:) spacing:-15];
        
        _baseView = [[ZGPrivacyViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.dataSource = self;
        _baseView.baseTableView.delegate = self;
    }
}

//#pragma mark - backBtnClicked
//- (void)backBtnClicked:(UIButton *)button
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - switch changed
- (void)switchChanged:(id)sendor
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    ZGPrivacySettingCell *cell = (ZGPrivacySettingCell *)[_baseView.baseTableView cellForRowAtIndexPath:path];
    
    setProvacyParam = [[ZGSetProvacyParam alloc]init];
    if(userInfoEntity)
    {
        setProvacyParam.userId = userInfoEntity.identity;
        setProvacyParam.mobile = userInfoEntity.mobile;
        setProvacyParam.pwd = userInfoEntity.password;
        if(cell.priSwitch.on)
            setProvacyParam.openToSchoolmateProvacy = 1;
        else
            setProvacyParam.openToSchoolmateProvacy = 0;
        [[ZGProvacySettingProcess shareInstance]setProvacyWithParam:[setProvacyParam getDictionary] parentView:nil progressText:@"加载中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if([[responseObject objectForKey:@"code"]intValue] == 200)
            {
                
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PrivacySettingListCell";
    ZGPrivacySettingCell *cell = (ZGPrivacySettingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGPrivacySettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }

    [cell.priSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    cell.priSwitch.on = self.isOn;
    
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PrivacyCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
