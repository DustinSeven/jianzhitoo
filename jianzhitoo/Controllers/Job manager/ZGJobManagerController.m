//
//  ZGJobManagerController.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/4.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGJobManagerController.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGLoginController.h"
#import "ZGBrowseRecordController.h"
#import "ZGZbarView.h"
#import "ZGUserCenterProcess.h"
#import "ZGSignInParam.h"

@interface ZGJobManagerController ()<UITableViewDataSource,UITableViewDelegate,ZBarReaderDelegate,UIImagePickerControllerDelegate>
{
    ZGJobManagerViewBase *_baseView;
    
    ZGUserInfoEntity *userInfoEntity;
    
    ZBarReaderViewController * reader;
}

@end

@implementation ZGJobManagerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.title = @"兼职管理";
        
        _baseView = [[ZGJobManagerViewIphone alloc]init];
        self.view = _baseView;
        
        reader = [[ZBarReaderViewController alloc]init];
        reader.readerDelegate = self;
        ZBarImageScanner * scanner = reader.scanner;
        [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
        reader.showsZBarControls = NO;
        reader.showsHelpOnFail = NO;
        reader.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        reader.scanCrop = CGRectMake(0.1, 0.2, 0.8, 0.8);//扫描的感应框
        [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
        ZGZbarView *view = [[ZGZbarView alloc]init];
        [view.backBtn addTarget:self action:@selector(zbarBack:) forControlEvents:UIControlEventTouchUpInside];
        reader.cameraOverlayView = view;
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        [_baseView.signInBtn addTarget:self action:@selector(signInBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(menuBtnClicked:) spacing:-15];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    
    if(self.isSignIn)
    {
        [self signInBtnClicked:nil];
        self.isSignIn = NO;
    }
}

#pragma mark - signInBtnClicked
- (void)signInBtnClicked:(UIButton *)button
{
    if(userInfoEntity)
        [self presentViewController:reader animated:YES completion:nil];
    else
    {
        ZGLoginController *loginController = [[ZGLoginController alloc]init];
        ZGBaseNavigationController *loginNav = [[ZGBaseNavigationController alloc]initWithRootViewController:loginController];
        [self presentViewController:loginNav animated:YES completion:^{
            
        }];
    }
}

- (void)zbarBack:(UIButton *)button
{
    [reader dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        CGImageRef cgImageRef = image.CGImage;
        ZBarSymbol * symbol = nil;
        ZBarReaderController *read = [ZBarReaderController new];
        read.readerDelegate = self;
        id <NSFastEnumeration> results = [read scanImage:cgImageRef];
        for (symbol in results)
        {
            break;
        }
        NSString * result;
        if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
            
        {
            result = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        else
        {
            result = symbol.data;
        }
        
        ZGSignInParam *param = [[ZGSignInParam alloc]init];
        param.mobile = userInfoEntity.mobile;
        param.pwd = userInfoEntity.password;
        NSString *jobId = [ZGUtility TripleDES:result encryptOrDecrypt:kCCDecrypt encryptOrDecryptKey:DESKEY];
        param.jobId = jobId;
        param.userId = [NSString stringWithFormat:@"%ld",userInfoEntity.identity];
        [self signIn:param];

    }];
}

- (void) signIn:(ZGSignInParam *)param
{
    [[ZGUserCenterProcess shareInstance]signInWithParam:[param getDictionary] parentView:nil text:@"签到中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            [ZGUtility showAlertWithText:@"签到成功！" parentView:nil];
        }
        else
        {
            [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
    }];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
    
    ZGBaseView *line = [[ZGBaseView alloc]initWithFrame:CGRectMake(0, JobManagerListCellHeight - 0.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = JobManagerListSeparatorColor;
    [cell.contentView addSubview:line];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"已报兼职";
            break;
        case 1:
            cell.textLabel.text = @"浏览记录";
            break;
        case 2:
            cell.textLabel.text = @"已完成";
            break;
            
        default:
            break;
    }
    
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JobManagerListCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if(indexPath.row == 0)
    {
        if(userInfoEntity)
        {
            ZGMyRegistrationController *myRegisterController = [[ZGMyRegistrationController alloc]init];
            [self.navigationController pushViewController:myRegisterController animated:YES];
        }
        else
        {
            ZGLoginController *loginController = [[ZGLoginController alloc]init];
            ZGBaseNavigationController *navigation = [[ZGBaseNavigationController alloc]initWithRootViewController:loginController];
            [self presentViewController:navigation animated:YES completion:^{
                
            }];

        }
    }
    if(indexPath.row == 1)
    {
        ZGBrowseRecordController *browseRecordController = [[ZGBrowseRecordController alloc]init];
        [self.navigationController pushViewController:browseRecordController animated:YES];
    }
}

#pragma mark - menuBtnClicked
- (void)menuBtnClicked:(UIButton *)btn
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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
