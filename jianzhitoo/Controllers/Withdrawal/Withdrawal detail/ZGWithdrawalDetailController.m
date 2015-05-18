//
//  ZGWithdrawalDetailController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/11/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGWithdrawalDetailController.h"
#import "ZGWithdrawalDetailCell.h"
#import "ZGWithdrawToAlipayParam.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGWithdrawalDetailProcess.h"
#import "ZGBankController.h"
#import "ZGBankEntity.h"
#import "ZGWithdrawalToBankParam.h"

@interface ZGWithdrawalDetailController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ZGBankDelegate>
{
    ZGWithdrawalDetailViewBase *_baseView;
    
    NSMutableAttributedString *balanceStr;
    
    ZGUserInfoEntity *userInfoEntity;
    
    ZGCommonAlertViewIphone *alert;
    
    ZGBankController *bankController;
    
    ZGBankEntity *bankEntity;
}

@end

@implementation ZGWithdrawalDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
        
        _baseView = [[ZGWithdrawalDetailViewIphone alloc]init];
        if(self.controllerType == WithdrawalDetailType_Alipay)
            _baseView.viewType = WithdrawalDetailViewType_Alipay;
        else
            _baseView.viewType = WithdrawalDetailViewType_Bank;
        self.view = _baseView;
        
        [_baseView.headView.backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        balanceStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"可用提现金额：%0.2f元",self.enableMoney]];
        NSRange range = NSMakeRange(7, balanceStr.string.length - 8);
        [balanceStr addAttribute:NSForegroundColorAttributeName value:WithdrawalDetailMoneyColor range:range];
        _baseView.balanceLab.attributedText = balanceStr;
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        [_baseView.submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

#pragma mark - submit btn clicked
- (void)submitBtnClicked:(UIButton *)button
{
    if(self.controllerType == WithdrawalDetailType_Alipay)
    {
        NSIndexPath *alipayPath = [NSIndexPath indexPathForRow:0 inSection:0];
        ZGWithdrawalDetailCell *alipayCell = (ZGWithdrawalDetailCell *)[_baseView.baseTableView cellForRowAtIndexPath:alipayPath];
        NSString *alipayAccount = alipayCell.contentText.text;
        
        NSIndexPath *accountPath = [NSIndexPath indexPathForRow:1 inSection:0];
        ZGWithdrawalDetailCell *accountCell = (ZGWithdrawalDetailCell *)[_baseView.baseTableView cellForRowAtIndexPath:accountPath];
        NSString *account = accountCell.contentText.text;
        
        NSIndexPath *moneyPath = [NSIndexPath indexPathForRow:2 inSection:0];
        ZGWithdrawalDetailCell *moneyCell = (ZGWithdrawalDetailCell *)[_baseView.baseTableView cellForRowAtIndexPath:moneyPath];
        NSString *money = moneyCell.contentText.text;
        
        if([alipayAccount isEqualToString:@""])
        {
            [ZGUtility showAlertWithText:@"请输入支付宝账号!" parentView:nil];
            return;
        }
        if([account isEqualToString:@""])
        {
            [ZGUtility showAlertWithText:@"请输入开户姓名!" parentView:nil];
            return;
        }
        if([money isEqualToString:@""])
        {
            [ZGUtility showAlertWithText:@"请输入提取金额!" parentView:nil];
            return;
        }
        
        ZGWithdrawToAlipayParam *param = [[ZGWithdrawToAlipayParam alloc]init];
        if(userInfoEntity)
        {
            param.userId = userInfoEntity.identity;
            param.account = account;
            param.pwd = userInfoEntity.password;
            param.alipayAccount = alipayAccount;
            param.money = [money doubleValue];
            param.mobile = userInfoEntity.mobile;
        }
        
        if([money doubleValue] > self.enableMoney)
        {
            [ZGUtility showAlertWithText:@"输入金额大于可用金额!" parentView:nil];
        }
        else
        {
            [[ZGWithdrawalDetailProcess shareInstance]withdrawalToAlipayWithParam:[param getDictionary] parentView:nil progressText:@"提交中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    alert = [ZGUtility showAlertWithText:@"取现成功，预计24小时内到账！" parentView:nil];
                    [alert.btn addTarget:self action:@selector(alertBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
        NSIndexPath *bankPath = [NSIndexPath indexPathForRow:0 inSection:0];
        ZGWithdrawalDetailCell *bankCell = (ZGWithdrawalDetailCell *)[_baseView.baseTableView cellForRowAtIndexPath:bankPath];
        NSString *bankName = bankCell.contentText.text;
        
        NSIndexPath *bankAccountPath = [NSIndexPath indexPathForRow:1 inSection:0];
        ZGWithdrawalDetailCell *accountCell = (ZGWithdrawalDetailCell *)[_baseView.baseTableView cellForRowAtIndexPath:bankAccountPath];
        NSString *account = accountCell.contentText.text;
        
        NSIndexPath *bankOPath = [NSIndexPath indexPathForRow:2 inSection:0];
        ZGWithdrawalDetailCell *bankOCell = (ZGWithdrawalDetailCell *)[_baseView.baseTableView cellForRowAtIndexPath:bankOPath];
        NSString *bankO = bankOCell.contentText.text;
        
        NSIndexPath *namePath = [NSIndexPath indexPathForRow:3 inSection:0];
        ZGWithdrawalDetailCell *nameCell = (ZGWithdrawalDetailCell *)[_baseView.baseTableView cellForRowAtIndexPath:namePath];
        NSString *name = nameCell.contentText.text;
        
        NSIndexPath *moneyPath = [NSIndexPath indexPathForRow:4 inSection:0];
        ZGWithdrawalDetailCell *moneyCell = (ZGWithdrawalDetailCell *)[_baseView.baseTableView cellForRowAtIndexPath:moneyPath];
        NSString *money = moneyCell.contentText.text;
        
        if([bankName isEqualToString:@""])
        {
            [ZGUtility showAlertWithText:@"请选择银行!" parentView:nil];
            return;
        }
        if([account isEqualToString:@""])
        {
            [ZGUtility showAlertWithText:@"请输入银行卡号!" parentView:nil];
            return;
        }
        if([bankO isEqualToString:@""])
        {
            [ZGUtility showAlertWithText:@"请输入开户支行!" parentView:nil];
            return;
        }
        if([name isEqualToString:@""])
        {
            [ZGUtility showAlertWithText:@"请输入开户姓名!" parentView:nil];
            return;
        }
        if([money isEqualToString:@""])
        {
            [ZGUtility showAlertWithText:@"请输入提取金额!" parentView:nil];
            return;
        }
        
        ZGWithdrawalToBankParam *param = [[ZGWithdrawalToBankParam alloc]init];
        if(userInfoEntity)
        {
            param.userId = userInfoEntity.identity;
            param.account = account;
            param.pwd = userInfoEntity.password;
            param.bankCardNum = account;
            param.accountBankPath = bankO;
            param.bankCode = bankEntity.bankCode;
            param.money = [money doubleValue];
            param.mobile = userInfoEntity.mobile;
        }
        if([money doubleValue] > self.enableMoney)
        {
            [ZGUtility showAlertWithText:@"输入金额大于可用金额!" parentView:nil];
        }
        else
        {
            [[ZGWithdrawalDetailProcess shareInstance]withdrawalToBankWithParam:[param getDictionary] parentView:nil progressText:@"提交中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if([[responseObject objectForKey:@"code"]intValue] == 200)
                {
                    alert = [ZGUtility showAlertWithText:@"取现成功，预计24小时内到账！" parentView:nil];
                    [alert.btn addTarget:self action:@selector(alertBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - alert btn clicked
- (void)alertBtnClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.controllerType == WithdrawalDetailType_Alipay)
        return 3;
    else
        return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"WithdrawalDetailCell";
    ZGWithdrawalDetailCell *cell = (ZGWithdrawalDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGWithdrawalDetailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    if(self.controllerType == WithdrawalDetailType_Alipay)
    {
        if(indexPath.row == 0)
        {
            cell.titleLab.text = @"支付账号";
            cell.contentText.placeholder = @"XXXXXXXXX";
        }
        if(indexPath.row == 1)
        {
            cell.titleLab.text = @"开户姓名";
            cell.contentText.text = userInfoEntity.account;
            cell.contentText.enabled = NO;
        }
        if(indexPath.row == 2)
        {
            cell.titleLab.text = @"提取金额";
            cell.contentText.placeholder = @"0.00";
            cell.contentText.keyboardType = UIKeyboardTypeNumberPad;
            cell.contentText.delegate = self;
        }
    }
    
    if(self.controllerType == WithdrawalDetailType_Bank)
    {
        if(indexPath.row == 0)
        {
            cell.titleLab.text = @"银行名称";
            cell.contentText.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 1)
        {
            cell.titleLab.text = @"银行卡号";
            cell.contentText.placeholder = @"提款储蓄卡号";
            cell.contentText.keyboardType = UIKeyboardTypeNumberPad;
            cell.rightImg.hidden = NO;
            cell.contentText.delegate = self;
        }
        if(indexPath.row == 2)
        {
            cell.titleLab.text = @"开户支行";
            cell.contentText.placeholder = @"XXXXXXXXX";
        }
        if(indexPath.row == 3)
        {
            cell.titleLab.text = @"开户姓名";
            cell.contentText.text = userInfoEntity.account;
            cell.contentText.enabled = NO;
        }
        if(indexPath.row == 4)
        {
            cell.titleLab.text = @"提取金额";
            cell.contentText.placeholder = @"0.00";
            cell.contentText.keyboardType = UIKeyboardTypeNumberPad;
            cell.contentText.delegate = self;
        }
    }
     
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WithdrawalDetailCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if(self.controllerType == WithdrawalDetailType_Bank && indexPath.row == 0)
    {
        bankController = [[ZGBankController alloc]init];
        bankController.delegate = self;
        [self.navigationController pushViewController:bankController animated:YES];
    }
    else
        [self resignTextFirstResponder];
}

#pragma mark - ZGBankDelegate
-(void)gainTheBank:(ZGBankEntity *)entity
{
    bankEntity = entity;
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    ZGWithdrawalDetailCell *cell = (ZGWithdrawalDetailCell *)[_baseView.baseTableView cellForRowAtIndexPath:path];
    cell.contentText.hidden = NO;
    if(entity.bankName)
        cell.contentText.text = entity.bankName;
    cell.contentText.userInteractionEnabled = NO;
}


#pragma mark - back button clicked
- (void)backBtnClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)resignTextFirstResponder
{
    int num;
    if(self.controllerType == WithdrawalDetailType_Alipay)
        num = 3;
    else
        num = 5;
    
    for(int i = 0;i<num;++i)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        ZGWithdrawalDetailCell *tmpCell = (ZGWithdrawalDetailCell *)[_baseView.baseTableView cellForRowAtIndexPath:path];
        [tmpCell.contentText resignFirstResponder];
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
