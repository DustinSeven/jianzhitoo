//
//  ZGUserInfoController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUserInfoController.h"
#import "ZGUserInfoCell.h"
#import "ZGUserInfoChangeController.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGUserGenderParam.h"
#import "ZGChangeUserInfoProcess.h"
#import "ZGSchoolYearParam.h"
#import "UIImageView+WebCache.h"
#import "ZGUploadUserImgParam.h"
#import "ZGLoginController.h"


@interface ZGUserInfoController ()<UITableViewDataSource,UITableViewDelegate,ZGActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    ZGUserInfoViewBase *_baseView;
    ZGUserInfoEntity *userInfoEntity;
    
    int selectedSchoolYear;
    
    UIImagePickerController *imgPicker;
}

@end

@implementation ZGUserInfoController
  
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.title = @"个人资料";
        
        imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate = self;
        imgPicker.allowsEditing = YES;//设置可编辑
        imgPicker.videoQuality=UIImagePickerControllerQualityTypeLow;
        
        _baseView = [[ZGUserInfoViewIphone alloc]init];
        self.view = _baseView;
        
        self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(menuBtnClicked:) spacing:-15];
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    
    if(!(userInfoEntity))
    {
        ZGLoginController *loginController = [[ZGLoginController alloc]init];
        loginController.loginReturnType = LoginReturnType_LeftMenu;
//        ZGBaseNavigationController *loginNav = [[ZGBaseNavigationController alloc]initWithRootViewController:loginController];
        [self.navigationController pushViewController:loginController animated:NO];
    }
    
    [_baseView.baseTableView reloadData];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 20;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    lab.textColor = APP_FONT_COLOR_THIN;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger year = [components year];
    lab.text = [NSString stringWithFormat:@"%ld",year - row ];
    
    return lab;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UILabel *lab = (UILabel *)[pickerView viewForRow:row forComponent:0];
    lab.textColor = APP_FONT_COLOR_NORMAL;
    lab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL + 5];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger year = [components year];
    lab.text = [NSString stringWithFormat:@"%ld  年",year - row ];
    
    selectedSchoolYear = (int)(year - row);
}
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return @"年";
//}

#pragma  mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 5;
    if(section == 1)
        return 3;
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UserInfoListCell";
    ZGUserInfoCell *cell = (ZGUserInfoCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGUserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            cell.leftLab.text = @"头像";
            if(userInfoEntity.userImg)
            {
                [cell.rightImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,userInfoEntity.userImg]]
                                     placeholderImage:[UIImage imageNamed:@"user_img_default_130px"]
                                  isScaleToCustomSize:NO];
            }
            else
                cell.rightImg.image = [UIImage imageNamed:@"user_img_default_130px"];
            cell.rightImg.hidden = NO;
            cell.rightLab.hidden = YES;
            [cell setImgCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 1)
        {
            cell.leftLab.text = @"姓名";
            if(userInfoEntity && userInfoEntity.account)
            {
                cell.rightLab.text = userInfoEntity.account;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 2)
        {
            cell.leftLab.text = @"性别";
            if(userInfoEntity && userInfoEntity.sex && userInfoEntity.sex != 0)
            {
                if(userInfoEntity.sex == 1)
                    cell.rightLab.text = @"男";
                else
                    cell.rightLab.text = @"女";
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 3)
        {
            cell.leftLab.text = @"手机";
            if(userInfoEntity && userInfoEntity.mobile)
            {
                cell.rightLab.text = userInfoEntity.mobile;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 4)
        {
            cell.leftLab.text = @"QQ";
            if(userInfoEntity && userInfoEntity.qq)
            {
                cell.rightLab.text = userInfoEntity.qq;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            cell.leftLab.text = @"省份";
            if(userInfoEntity && userInfoEntity.province)
            {
                cell.rightLab.text = userInfoEntity.province;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 1)
        {
            cell.leftLab.text = @"市/县";
            if(userInfoEntity && userInfoEntity.city)
            {
                cell.rightLab.text = userInfoEntity.city;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 2)
        {
            cell.leftLab.text = @"区";
            if(userInfoEntity && userInfoEntity.area)
            {
                cell.rightLab.text = userInfoEntity.area;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
    }
    if(indexPath.section == 2)
    {
        if(indexPath.row == 0)
        {
            cell.leftLab.text = @"入学年份";
            if(userInfoEntity && userInfoEntity.schoolYear)
            {
                cell.rightLab.text = [NSString stringWithFormat:@"%ld",userInfoEntity.schoolYear];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 1)
        {
            cell.leftLab.text = @"学校";
            if(userInfoEntity && userInfoEntity.college)
            {
                cell.rightLab.text = userInfoEntity.college;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 2)
        {
            cell.leftLab.text = @"院系";
            if(userInfoEntity && userInfoEntity.depatment)
            {
                cell.rightLab.text = userInfoEntity.depatment;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 3)
        {
            cell.leftLab.text = @"专业";
            if(userInfoEntity && userInfoEntity.specialty)
            {
                cell.rightLab.text = userInfoEntity.specialty;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }

    
    return cell;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 && indexPath.section == 0)
        return UserInfoCellUserImgHeight;
    return UserInfoCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZGBaseView *view = [[ZGBaseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGUserInfoCell *cell = (ZGUserInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    ZGUserInfoChangeController *userInfoChangeController = [[ZGUserInfoChangeController alloc]init];
    
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        NSArray *shareButtonTitleArray = [[NSArray alloc] init];
        shareButtonTitleArray = @[@"拍照",@"从手机相册选择"];
        
        ZGActionSheet *activity = [[ZGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray frame:CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight) ];
        [activity showInView:self.view];
    }
    
    if(indexPath.section == 0 && indexPath.row == 1)
    {
        userInfoChangeController.changeType = UserInfoChangeType_Username;
        [self.navigationController pushViewController:userInfoChangeController animated:YES];
    }
    if(indexPath.section == 0 && indexPath.row == 2)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"设置性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        [actionSheet showInView:self.view];
    }
    if(indexPath.section == 0 && indexPath.row == 3)
    {
//        if(userInfoEntity.mobile)
//        userInfoChangeController.changeType = UserInfoChangeType_Mobile;
//        [self.navigationController pushViewController:userInfoChangeController animated:YES];
    }
    if(indexPath.section == 0 && indexPath.row == 4)
    {
        userInfoChangeController.changeType = UserInfoChangeType_QQ;
        [self.navigationController pushViewController:userInfoChangeController animated:YES];
    }
    if(indexPath.section == 1 && indexPath.row == 0)
    {
        userInfoChangeController.changeType = UserInfoChangeType_Province;
        [self.navigationController pushViewController:userInfoChangeController animated:YES];
    }
    
    if(indexPath.section == 2 && indexPath.row == 0)
    {
        ZGActionSheet *activity = [[ZGActionSheet alloc] initPikerTypeWithDelegate:self frame:CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight) ];
        activity.tag = 300;
        activity.pickView.dataSource = self;
        activity.pickView.delegate = self;
        [activity.enterBtn addTarget:self action:@selector(schoolYearEnterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [activity.pickView selectRow:2 inComponent:0 animated:YES];
        UILabel *lab = (UILabel *)[activity.pickView viewForRow:2 forComponent:0];
        lab.textColor = APP_FONT_COLOR_NORMAL;
        lab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL + 5];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger year = [components year];
        lab.text = [NSString stringWithFormat:@"%ld  年",year - 2 ];
        [activity showInView:self.view];
    }
    if(indexPath.section == 2 && indexPath.row == 1)
    {
        userInfoChangeController.changeType = UserInfoChangeType_College;
        [self.navigationController pushViewController:userInfoChangeController animated:YES];
    }
    if(indexPath.section == 2 && indexPath.row == 3)
    {
        userInfoChangeController.changeType = UserInfoChangeType_Specialty;
        [self.navigationController pushViewController:userInfoChangeController animated:YES];
    }
}

#pragma mark - schoolYearEnterBtnClicked
- (void)schoolYearEnterBtnClicked:(UIButton *)button
{
    ZGSchoolYearParam *param = [[ZGSchoolYearParam alloc]init];
    param.userId = userInfoEntity.identity;
    param.mobile = userInfoEntity.mobile;
    param.password = userInfoEntity.password;
    if(selectedSchoolYear)
        param.schoolYear = selectedSchoolYear;
    else
    {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger year = [components year];
        param.schoolYear = (int)year - 2;
    }
    
    [[ZGChangeUserInfoProcess shareInstance]updateUserInfoWithParam:[param getDictionary] ParentView:_baseView.baseTableView progressText:@"更新中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            userInfoEntity.schoolYear = param.schoolYear;
            [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
            [ZGUtility saveUserDefaults:userInfoEntity key:USERDEFAULTS_USER_INFO_KEY];
            
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

#pragma mark - ZGActionSheet delegate
- (void)didClickOnImageIndex:(long int)imageIndex
{
    if(imageIndex == 0)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imgPicker animated:YES completion:^{
                
            }];
        }
    }
    
    if(imageIndex == 1)
    {
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imgPicker animated:YES completion:^{
            
        }];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];

    if (image != nil)
    {
        ZGUploadUserImgParam *param = [[ZGUploadUserImgParam alloc]init];
        param.mobile = userInfoEntity.mobile;
        param.password = userInfoEntity.password;
        
        [[ZGChangeUserInfoProcess shareInstance] uploadUserImgWithParam:[param getDictionary] ParentView:nil progressText:@"修改中..." img:[ZGUtility imageWithImage:image scaledToSize:CGSizeMake(400, 400)] success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            
            if([[responseObject objectForKey:@"code"]intValue] == 200)
            {
                NSArray *data = [responseObject objectForKey:@"data"];
                NSString *userImg = [[data objectAtIndex:0] objectForKey:@"userimage"];
                if(userImg)
                {
                    userInfoEntity.userImg = userImg;
                    
                    [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
                    [ZGUtility saveUserDefaults:userInfoEntity key:USERDEFAULTS_USER_INFO_KEY];
                                        
                    [_baseView.baseTableView reloadData];
                }
                [ZGUtility showAlertWithText:@"头像修改成功！" parentView:nil];
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
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}



#pragma  mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0 || buttonIndex == 1)
    {
        ZGUserGenderParam *genderParam = [[ZGUserGenderParam alloc]init];
        genderParam.userId = userInfoEntity.identity;
        genderParam.mobile = userInfoEntity.mobile;
        genderParam.password = userInfoEntity.password;
        
        if(buttonIndex == 0)
        {
            genderParam.sex = 1;
        }
        else
        {
            genderParam.sex = 2;
        }
        
        [[ZGChangeUserInfoProcess shareInstance]updateUserInfoWithParam:[genderParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if([[responseObject objectForKey:@"code"]intValue] == 200)
            {
                userInfoEntity.sex = genderParam.sex;
                userInfoEntity.sex = genderParam.sex;
                [ZGUtility removeUserDefaults:USERDEFAULTS_USER_INFO_KEY];
                [ZGUtility saveUserDefaults:userInfoEntity key:USERDEFAULTS_USER_INFO_KEY];
                
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
