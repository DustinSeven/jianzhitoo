//
//  ZGSettingController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/9/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGSettingController.h"
#import "ZGPrivcySettingController.h"
#import "ZGUtility.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGLoginController.h"
#import "ZGGetProvacyParam.h"
#import "ZGProvacySettingProcess.h"
#import "ZGProvacyEntity.h"
#import "ZGAboutUsController.h"
#import "ZGAdviceController.h"
#import "ZGChangePasswordController.h"

@interface ZGSettingController ()<UITableViewDataSource,UITableViewDelegate,ZGActionSheetDelegate>
{
    ZGSettingViewBase *_baseView;
    
    ZGUserInfoEntity *userInfoEntity;
    
    ZGGetProvacyParam *getProvacyParam;
    
    ZGProvacyEntity *provacyEntity;
    
    ZGUpdateAlertView *alertView;
    
    ZGActionSheet *shareActivity;
    NSArray *shareButtonTitleArr;
    NSArray *shareButtonImgArr;
    
    
    ZGUpdateInfoEntity *entity;
}

@end

@implementation ZGSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.title = @"设置";
        
        shareButtonTitleArr = @[@"微信朋友圈",@"微信好友"];
        shareButtonImgArr = @[@"share_btn_timeline_icon_normal",@"share_btn_session_icon_normal"];
        
        _baseView = [[ZGSettingViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        [_baseView.logoutBtn addTarget:self action:@selector(logoutBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    
    self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(menuBtnClicked:) spacing:-15];

    
    if(!(userInfoEntity))
    {
        _baseView.logoutBtn.hidden = YES;
    }
    else
    {
        _baseView.logoutBtn.hidden = NO;
    }
}
#pragma mark - logout btn clicked
- (void)logoutBtnClicked:(UIButton *)button
{
    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    
    [ZGUtility showAlertWithText:@"退出登录成功!" parentView:nil];
    
    _baseView.logoutBtn.hidden = YES;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SettingListCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = CELL_SELECTED_COLOR;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    
    ZGBaseView *line = [[ZGBaseView alloc]initWithFrame:CGRectMake(0, SettingListCellHeight - 0.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = SettingListSeparatorColor;
    [cell.contentView addSubview:line];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"修改密码";
            break;
        case 1:
            cell.textLabel.text = @"隐私设置";
            break;
        case 2:
            cell.textLabel.text = @"版本更新";
            break;
        case 3:
            cell.textLabel.text = @"关于我们";
            break;
        case 4:
            cell.textLabel.text = @"法律申明";
            break;
        case 5:
            cell.textLabel.text = @"邀请好友";
            break;
        case 6:
            cell.textLabel.text = @"意见反馈";
            break;
            
        default:
            break;
    }

    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SettingListCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    switch (indexPath.row) {
        case 0:
        {
            if(userInfoEntity)
            {
                ZGChangePasswordController *changePwdController = [[ZGChangePasswordController alloc]init];
                [self.navigationController pushViewController:changePwdController animated:YES];
            }
            else
            {
                ZGLoginController *loginController = [[ZGLoginController alloc]init];
                ZGBaseNavigationController *loginNav = [[ZGBaseNavigationController alloc] initWithRootViewController:loginController];
                [self presentViewController:loginNav animated:YES completion:^{
                    
                    [self.navigationController popViewControllerAnimated:NO];
                }];
            }
        }
            break;
        case 1:
        {
            if(!userInfoEntity)
            {
                
                ZGLoginController *loginController = [[ZGLoginController alloc]init];
                ZGBaseNavigationController *loginNav = [[ZGBaseNavigationController alloc] initWithRootViewController:loginController];
                [self presentViewController:loginNav animated:YES completion:^{
                    
                    [self.navigationController popViewControllerAnimated:NO];
                }];
                
            }
            else
            {
                getProvacyParam = [[ZGGetProvacyParam alloc]init];
                getProvacyParam.userId = userInfoEntity.identity;
                getProvacyParam.mobile = userInfoEntity.mobile;
                getProvacyParam.pwd = userInfoEntity.password;
                    
                [[ZGProvacySettingProcess shareInstance]getProvacyWithParam:[getProvacyParam getDictionary] parentView:nil progressText:@"加载中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    if([[responseObject objectForKey:@"code"]intValue] == 200)
                    {
                        NSArray *data = [responseObject objectForKey:@"data"];
                        provacyEntity = [[ZGProvacyEntity alloc]initWithAttributes:[data objectAtIndex:0]];
                        
                        ZGPrivcySettingController *privacySettingController = [[ZGPrivcySettingController alloc]init];
                        if(provacyEntity.openToSchoolmate)
                            privacySettingController.isOn = YES;
                        else
                            privacySettingController.isOn = NO;
                        [self.navigationController pushViewController:privacySettingController animated:YES];
                        
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
            break;
        case 2:
        {
            [[ZGLoginProcess shareInstance]getUpdateInfoWithParentView:nil text:@"检测中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    NSArray *data = [responseObject objectForKey:@"data"];
                    entity = [[ZGUpdateInfoEntity alloc]initWithAttributes:[data objectAtIndex:0]];
                    ZGBaseEntity *baseEntity = [[ZGBaseEntity alloc]init];
                    
                    if(entity.versionNo > baseEntity.cversion)
                    {
                        alertView = [ZGUtility showUpdateAlertWithEntity:entity parentView:self.view];
                        [alertView.cancelBtn addTarget:self action:@selector(updatePaneCancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                        [alertView.updateBtn addTarget:self action:@selector(updatePaneUpdateBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    else
                    {
                        [ZGUtility showAlertWithText:@"没有发现新版本！" parentView:nil];
                    }
                }
                else
                {
                    [ZGUtility showAlertWithText:@"没有发现新版本！" parentView:nil];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
            }];
        }
            break;
        case 3:
        {
            ZGAboutUsController *aboutUsController = [[ZGAboutUsController alloc]init];
            [self.navigationController pushViewController:aboutUsController animated:YES];
        }
            break;
        case 4:
        {
            ZGStatementOfLawController *statementOfLawController = [[ZGStatementOfLawController alloc]init];
            [self.navigationController pushViewController:statementOfLawController animated:YES];
        }
            break;
        case 5:
        {
            if(shareActivity && shareActivity.hidden == NO)
                [shareActivity dismissed];
            else
            {
                shareActivity = [[ZGActionSheet alloc]initWithTitle:@"分享兼职" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArr withShareButtonImagesName:shareButtonImgArr frame:CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight)];
                
                [shareActivity showInView:self.view];
            }
        }
            break;
        case 6:
        {
            ZGAdviceController *adviceController = [[ZGAdviceController alloc]init];
            [self.navigationController pushViewController:adviceController animated:YES];
        }
            break;
        default:
            break;
    }

}
#pragma mark - ZGActionSheetDelegate
- (void)didClickOnImageIndex:(long int)imageIndex
{
    if (imageIndex == 0) {
        [self sendLinkContentWithScrean:WXSceneTimeline];
        
    }
    else if (imageIndex == 1) {
        [self sendLinkContentWithScrean:WXSceneSession];
        
    }
    
}

#pragma mark - View lifecycle
- (void)sendLinkContentWithScrean:(int)screanType
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"兼职兔，咱大学生自己的兼职平台";
        message.description = @"我在兼职兔找兼职，小伙伴们也一起来吧";
        [message setThumbImage:[UIImage imageNamed:@"logo_108X108"]];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = @"http://download.jianzhitoo.com/default.html";
        
        message.mediaObject = ext;
        message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = screanType;
        [WXApi sendReq:req];
        
    }else{
        [ZGUtility showAlertWithText:@"您的手机上还没有安装微信！" parentView:nil];
        
    }
}
-(void) changeScene:(int)scene{
    _scene = scene;
}

#pragma  mark - updatePaneCancelBtnClicked
- (void)updatePaneCancelBtnClicked:(UIButton *)button
{
    alertView.hidden = YES;
}

#pragma  mark - updateBtnClicked
- (void)updatePaneUpdateBtnClicked:(UIButton *)button
{
    alertView.hidden = YES;
    
    if(entity)
    {
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:entity.url]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:entity.url]];
        }
    }
}

#pragma mark - menuBtnClicked
- (void)menuBtnClicked:(UIButton *)btn
{
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
