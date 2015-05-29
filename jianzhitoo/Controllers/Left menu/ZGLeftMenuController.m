//
//  ZGLeftMenuController.m
//  jianzhitoo
//
//  Created by 李明伟 on 14/12/30.
//  Copyright (c) 2014年 Lee Mingwei. All rights reserved.
//

#import "ZGLeftMenuController.h"
#import "ZGLeftMenuCell.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGBaseNavigationController.h"
#import "ZGUserInfoController.h"
#import "ZGDrawerController.h"
#import "ZGLoginController.h"
#import "ZGMainPageController.h"
#import "ZGSettingController.h"
#import "ZGJobManagerController.h"
#import "UIImageView+WebCache.h"
#import "ZGSocialContactController.h"

@interface ZGLeftMenuController ()<UITableViewDataSource,UITableViewDelegate>
{
    ZGLeftMenuViewBase *_baseView;
    
    ZGUserInfoEntity *userInfoEntity;
    
    BOOL isMainPageGone;
}

@end

@implementation ZGLeftMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[ZGLeftMenuViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        isMainPageGone = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    
    self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"job_detail_share_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"job_detail_share_btn_icon_pressed"] text:@"" target:self action:@selector(centerCaller:) spacing:-15];
    [_baseView.baseTableView reloadData];
    
    
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LeftMenuCell";
    ZGLeftMenuCell *cell = (ZGLeftMenuCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGLeftMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(indexPath.row == 0)
    {
        cell.leftImg.frame = CGRectMake(10, 5, LeftMenuTableViewRowHeight - 10, LeftMenuTableViewRowHeight - 10);
        cell.leftImg.layer.cornerRadius = (LeftMenuTableViewRowHeight - 10) / 2;
        cell.leftImg.layer.masksToBounds = YES;
        
        cell.contentLab.frame = CGRectMake(70, 0, 100, LeftMenuTableViewRowHeight);
        if(userInfoEntity)
        {
            cell.contentLab.text = userInfoEntity.account;
            if(userInfoEntity.userImg)
                [cell.leftImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,userInfoEntity.userImg]] placeholderImage:[UIImage imageNamed:@"user_img_default_80px"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                }];
            else
                cell.leftImg.image = [UIImage imageNamed:@"user_img_default_80px"];
        }
        else
        {
            cell.contentLab.text = @"登陆/注册";
            cell.leftImg.image = [UIImage imageNamed:@"user_img_default_80px"];
        }
    }
    if(indexPath.row == 1)
    {
        UIImage *icon = [UIImage imageNamed:@"left_menu_job_icon"];
        cell.leftImg.image = icon;
        cell.leftImg.frame = CGRectMake(CGRectGetMinX(cell.contentLab.frame) - 10 - icon.size.width , (LeftMenuTableViewRowHeight - icon.size.height) / 2, icon.size.width, icon.size.height);
        cell.contentLab.text = @"我要兼职";
    }
    if(indexPath.row == 2)
    {
        UIImage *icon = [UIImage imageNamed:@"left_menu_session_icon"];
        cell.leftImg.image = icon;
        cell.leftImg.frame = CGRectMake(CGRectGetMinX(cell.contentLab.frame) - 10 - icon.size.width , (LeftMenuTableViewRowHeight - icon.size.height) / 2, icon.size.width, icon.size.height);
        cell.contentLab.text = @"我的会话";
    }
    if(indexPath.row == 3)
    {
        UIImage *icon = [UIImage imageNamed:@"left_menu_sign_in_icon"];
        cell.leftImg.image = icon;
        cell.leftImg.frame = CGRectMake(CGRectGetMinX(cell.contentLab.frame) - 10 - icon.size.width , (LeftMenuTableViewRowHeight - icon.size.height) / 2, icon.size.width, icon.size.height);
        cell.contentLab.text = @"工作签到";
    }
    if(indexPath.row == 4)
    {
        UIImage *icon = [UIImage imageNamed:@"left_menu_my_job_icon"];
        cell.leftImg.image = icon;
        cell.leftImg.frame = CGRectMake(CGRectGetMinX(cell.contentLab.frame) - 10 - icon.size.width , (LeftMenuTableViewRowHeight - icon.size.height) / 2, icon.size.width, icon.size.height);
        cell.contentLab.text = @"兼职管理";
    }
    if(indexPath.row == 5)
    {
        UIImage *icon = [UIImage imageNamed:@"left_menu_setting_icon"];
        cell.leftImg.image = icon;
        cell.leftImg.frame = CGRectMake(CGRectGetMinX(cell.contentLab.frame) - 10 - icon.size.width , (LeftMenuTableViewRowHeight - icon.size.height) / 2, icon.size.width, icon.size.height);
        cell.contentLab.text = @"我的设置";
    }
    
    return cell;
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LeftMenuTableViewRowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ZGLeftMenuCell *cell = (ZGLeftMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    ZGBaseNavigationController * centerSideNavController;
    if(indexPath.row == 0)
    {
        ZGUserInfoController *userInfoController = [[ZGUserInfoController alloc]init];
        centerSideNavController = [[ZGBaseNavigationController alloc] initWithRootViewController:userInfoController];
        isMainPageGone = YES;
    }
    if(indexPath.row == 1)
    {
        ZGMainPageController *mainPageController = [[ZGMainPageController alloc]init];
        centerSideNavController = [[ZGBaseNavigationController alloc] initWithRootViewController:mainPageController];
        isMainPageGone = YES;
    }
    if(indexPath.row == 2)
    {
        ZGSocialContactController *socialContactController = [[ZGSocialContactController alloc]init];
        centerSideNavController = [[ZGBaseNavigationController alloc] initWithRootViewController:socialContactController];
        isMainPageGone = YES;
    }
    if(indexPath.row == 3)
    {
        ZGJobManagerController *jobManagerController = [[ZGJobManagerController alloc]init];
        jobManagerController.isSignIn = YES;
        centerSideNavController = [[ZGBaseNavigationController alloc] initWithRootViewController:jobManagerController];
        isMainPageGone = YES;
    }
    if(indexPath.row == 4)
    {
        ZGJobManagerController *jobManagerController = [[ZGJobManagerController alloc]init];
        centerSideNavController = [[ZGBaseNavigationController alloc] initWithRootViewController:jobManagerController];
        isMainPageGone = YES;
    }
    if(indexPath.row == 5)
    {
        ZGSettingController *settingController = [[ZGSettingController alloc]init];
        centerSideNavController = [[ZGBaseNavigationController alloc] initWithRootViewController:settingController];
        isMainPageGone = YES;
    }
    [centerSideNavController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    self.mm_drawerController.centerViewController = centerSideNavController;
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark - centerCaller
- (void)centerCaller:(UIButton *)button
{
    if(isMainPageGone)
    {
        ZGMainPageController *mainPageController = [[ZGMainPageController alloc]init];
        ZGBaseNavigationController * centerSideNavController = [[ZGBaseNavigationController alloc] initWithRootViewController:mainPageController];
        [centerSideNavController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
        self.mm_drawerController.centerViewController = centerSideNavController;
        isMainPageGone = NO;
    }
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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
