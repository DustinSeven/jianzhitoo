//
//  ZGUserCenterController.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUserCenterController.h"
#import "ZGLoginController.h"
#import "ZGSettingController.h"
#import "ZGAdviceController.h"
#import "ZGMonryDetailController.h"
#import "ZGBrowseRecordController.h"
#import "ZGChangePasswordController.h"
#import "ZGWithdrawalController.h"
#import "ZGUserInfoController.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGUtility.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "ZGMoneyInfoParam.h"
#import "ZGUserCenterProcess.h"
#import "ZGTotalMoneyEntity.h"
#import "ZGEnableMoneyEntity.h"
#import "ZGZbarView.h"
#import "ZGSignInParam.h"

@interface ZGUserCenterController()<ZBarReaderDelegate,UIImagePickerControllerDelegate>
{
    ZGUserCenterViewBase *_baseView;
    UITapGestureRecognizer *loginTapGesture;
    UITapGestureRecognizer *userInfoTapGesture;
    
    ZGUserInfoEntity *userInfoEntity;
    
    ZGTotalMoneyEntity *totalMoneyEntity;
    ZGEnableMoneyEntity *enableMoneyEntity;
    
    ZBarReaderViewController * reader;
}

@end

@implementation ZGUserCenterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        [self setRestorationIdentifier:@"MMExampleLeftSideDrawerController"];
        
        _baseView = [[ZGUserCenterViewIphone alloc]init];
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
        
        [_baseView.headView.backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.headView.rightBtn addTarget:self action:@selector(headRightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        loginTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginAction:)];
        [_baseView.userNameBackImg addGestureRecognizer:loginTapGesture];
        userInfoTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userInfoAction:)];
        [_baseView.userInfoBackImg addGestureRecognizer:userInfoTapGesture];
        
        [_baseView.mySignUpBtn.btn addTarget:self action:@selector(myCenterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.mySettingBtn.btn addTarget:self action:@selector(myCenterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.myAdviceBtn.btn addTarget:self action:@selector(myCenterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.myMoneyDetailBtn.btn addTarget:self action:@selector(myCenterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.myReadRecordBtn.btn addTarget:self action:@selector(myCenterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.myChangePwdBtn.btn addTarget:self action:@selector(myCenterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.takeNowBtn addTarget:self action:@selector(myCenterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)updateMoneyInfo
{
    [_baseView.activityIndicatorView startAnimating];
    
    ZGMoneyInfoParam *moneyInfoParam = nil;
    moneyInfoParam = [[ZGMoneyInfoParam alloc]init];
    moneyInfoParam.userId = userInfoEntity.identity;
    moneyInfoParam.mobile = userInfoEntity.mobile;
    moneyInfoParam.pwd = userInfoEntity.password;
    
    if(moneyInfoParam)
    {
        [[ZGUserCenterProcess shareInstance]getTotalMoneyInfoWithParam:[moneyInfoParam getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if([[responseObject objectForKey:@"code"]intValue] == 200)
            {
                NSArray *data = [responseObject objectForKey:@"data"];
                NSDictionary *dic = [data objectAtIndex:0];
                totalMoneyEntity = [[ZGTotalMoneyEntity alloc]initWithAttributes:dic];
                
                if(userInfoEntity)
                    _baseView.keepedMoneyNumLab.text = [NSString stringWithFormat:@"￥%0.2f",totalMoneyEntity.money];
                else
                    _baseView.keepedMoneyNumLab.text = @"登录可见";
                
                [[ZGUserCenterProcess shareInstance]getEnableMoneyInfoWithParam:[moneyInfoParam getDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    if([[responseObject objectForKey:@"code"]intValue] == 200)
                    {
                        NSArray *data = [responseObject objectForKey:@"data"];
                        NSDictionary *dic = [data objectAtIndex:0];
                        enableMoneyEntity = [[ZGEnableMoneyEntity alloc]initWithAttributes:dic];
                        
                        if(userInfoEntity)
                            _baseView.dealingMoneyNumLab.text = [NSString stringWithFormat:@"￥%0.2f",totalMoneyEntity.money - enableMoneyEntity.money];
                        else
                            _baseView.dealingMoneyNumLab.text = @"登录可见";
                    }
                    else
                    {
                        [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                    }
                    
                    [_baseView.activityIndicatorView stopAnimating];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
                    [_baseView.activityIndicatorView stopAnimating];
                }];
            }
            else
            {
                [ZGUtility showAlertWithText:[responseObject objectForKey:@"message"] parentView:nil];
                [_baseView.activityIndicatorView stopAnimating];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [ZGUtility showAlertWithText:@"网络错误，请检查您的网络连接！" parentView:nil];
            [_baseView.activityIndicatorView stopAnimating];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    
    if(userInfoEntity)
    {
        _baseView.userGenderImg.hidden = NO;
         _baseView.userNameBackImg.userInteractionEnabled = NO;
//        _baseView.userInfoBackImg.userInteractionEnabled = YES;
        if(userInfoEntity.college)
            _baseView.schoolNameLab.text = userInfoEntity.college;
        else
            _baseView.schoolNameLab.text = @"";
        if(userInfoEntity.account && ![userInfoEntity.account isEqualToString:@""])
        {
            _baseView.usernameLab.text = userInfoEntity.account;
        }

        if(userInfoEntity.userImg)
        {
            [_baseView.userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,userInfoEntity.userImg]]
                             placeholderImage:[UIImage imageNamed:@"user_img_default_120px"]
                          isScaleToCustomSize:NO];
        }
        else
            _baseView.userImg.image = [UIImage imageNamed:@"user_img_default_120px"];
        if(userInfoEntity.sex == 1)
            _baseView.userGenderImg.image = [UIImage imageNamed:@"user_center_user_gender_icon_male"];
        else if(userInfoEntity.sex == 2)
            _baseView.userGenderImg.image = [UIImage imageNamed:@"user_center_user_gender_icon_female"];
        
        _baseView.takeNowBtn.enabled = YES;
        
        [self updateMoneyInfo];
    }
    else
    {
//        _baseView.userInfoBackImg.userInteractionEnabled = NO;
        _baseView.schoolNameLab.text = @"";
        _baseView.usernameLab.text = @"登录/注册";
        _baseView.userNameBackImg.userInteractionEnabled = YES;
        _baseView.userGenderImg.hidden = YES;
        _baseView.userImg.image = [UIImage imageNamed:@"user_img_default_120px"];
        _baseView.takeNowBtn.enabled = NO;
        _baseView.keepedMoneyNumLab.text = @"登录后可见";
        _baseView.dealingMoneyNumLab.text = @"登录后可见";
    }
}

#pragma mark - to login
- (void)loginAction:(UITapGestureRecognizer *)recognize
{
    ZGLoginController *loginController = [[ZGLoginController alloc]init];
    loginController.userCenterController = self;
//    [self presentationController:loginController];
    
    ZGBaseNavigationController *navigation = [[ZGBaseNavigationController alloc]initWithRootViewController:loginController];
    [self presentViewController:navigation animated:YES completion:^{
        
    }];
}

#pragma mark - user img clicked
- (void)userInfoAction:(UITapGestureRecognizer *)recognize
{
    if(userInfoEntity)
    {
        ZGUserInfoController *userInfoController = [[ZGUserInfoController alloc]init];
        [self.navigationController pushViewController:userInfoController animated:YES];
    }
    else
        [self loginAction:nil];
    
}

#pragma  mark - my center btn clicked
- (void)myCenterBtnClicked:(UIButton *)button
{
    if(button.tag == 100)
    {
        ZGWithdrawalController *withdrawalController = [[ZGWithdrawalController alloc]init];
        withdrawalController.enableMoney = enableMoneyEntity.money;
        [self.navigationController pushViewController:withdrawalController animated:YES];
    }
    if(button.tag == 101)
    {
        if(userInfoEntity)
        {
            ZGMyRegistrationController *myRegisterController = [[ZGMyRegistrationController alloc]init];
            [self.navigationController pushViewController:myRegisterController animated:YES];
        }
        else
            [self loginAction:nil];
        
    }
    if(button.tag == 102)
    {
        ZGBrowseRecordController *browseRecordController = [[ZGBrowseRecordController alloc]init];
        [self.navigationController pushViewController:browseRecordController animated:YES];
    }
    if(button.tag == 103)
    {
        if(userInfoEntity)
        {
            ZGChangePasswordController *changePwdController = [[ZGChangePasswordController alloc]init];
            //        [self.navigationController pushViewController:changePwdController animated:YES];
            [self.navigationController pushViewController:changePwdController animated:YES];
        }
        else
            [self loginAction:nil];
        
    }
    if(button.tag == 104)
    {
        ZGSettingController *settingController = [[ZGSettingController alloc]init];
        [self.navigationController pushViewController:settingController animated:YES];
    }
    if(button.tag == 105)
    {
        if(userInfoEntity)
        {
            ZGMonryDetailController *moneyDetailController = [[ZGMonryDetailController alloc]init];
            [self.navigationController pushViewController:moneyDetailController animated:YES];
        }
        else
            [self loginAction:nil];
        
    }
    if(button.tag == 106)
    {
        ZGAdviceController *adviceController = [[ZGAdviceController alloc]init];
        [self.navigationController pushViewController:adviceController animated:YES];
    }
}

#pragma mark - back button clicked
- (void)backBtnClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - right btn clicked
- (void)headRightBtnClicked:(UIButton *)button
{
    if(userInfoEntity)
        [self presentViewController:reader animated:YES completion:nil];
    else
    {
        ZGLoginController *loginController = [[ZGLoginController alloc]init];
        [self presentViewController:loginController animated:YES completion:^{
            
        }];
    }
}

- (void)zbarBack:(UIButton *)button
{
    [reader dismissViewControllerAnimated:YES completion:^{
        
    }];
}

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
        
        ZGSignInParam *param = [ZGUtility signInParamWithStr:result];
        if(param)
        {
            param.mobile = userInfoEntity.mobile;
            param.pwd = userInfoEntity.password;
            [self signIn:param];
        }
        else
        {
            [ZGUtility showAlertWithText:@"请扫描正确的二维码！" parentView:nil];
        }
    }];
}

- (void) signIn:(ZGSignInParam *)param
{
    [[ZGUserCenterProcess shareInstance]signInWithParam:[param getDictionary] parentView:nil text:@"签到中" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

@end
