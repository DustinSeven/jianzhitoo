//
//  ZGBrowseRecordController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/10/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBrowseRecordController.h"
#import "ZGBrowseRecordViewIphone.h"
#import "ZGJobsListCell.h"
#import "ZGJobDetailController.h"
#import "ZGDatabaseHelper.h"
#import "UIImageView+AFNetworking.h"

@interface ZGBrowseRecordController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    ZGBrowseRecordViewBase *_baseView;
    
    NSMutableArray *jobArr;
    
    ZGFailImgAlertViewIphone *recordFail;
}

@end

@implementation ZGBrowseRecordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.title = @"浏览记录";
        
        jobArr = [[ZGDatabaseHelper shareHelper]getListOnJobTable];
        
        _baseView = [[ZGBrowseRecordViewIphone alloc]init];
        self.view = _baseView;
        
        self.navigationItem.rightBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"delete_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"delete_btn_icon_pressed"] text:@"" target:self action:@selector(deleteBtnClicked:) spacing:-15];
        
        _baseView.baseTableView.dataSource = self;
        _baseView.baseTableView.delegate = self;
        
        if(!jobArr.count)
            recordFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"no_record_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:nil parentView:_baseView.baseTableView];
    }
}

#pragma mark - delete btn clicked
- (void)deleteBtnClicked:(UIButton *)btn
{
//    ZGCommonAlertViewIphone *alert = [ZGUtility showAlertWithText:@"您确定要删除浏览记录吗？" parentView:nil];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除记录" message:@"您确定要删除浏览记录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)deleteRecord:(UIButton *)button
{
    [[ZGDatabaseHelper shareHelper]deleteOnJobTable];
    [jobArr removeAllObjects];
    [_baseView.baseTableView reloadData];
    
    if(!recordFail)
        recordFail = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"no_record_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:nil parentView:_baseView.baseTableView];
    else
        recordFail.hidden = NO;
}

#pragma  mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self deleteRecord:nil];
    }
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return jobArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"JobsListCell";
    ZGJobsListCell *cell = (ZGJobsListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGJobsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ZGBrowseRecordEntity *tmpEntity = [jobArr objectAtIndex:indexPath.row];
    if(tmpEntity.jobEntity.jobImg)
       [cell.jobImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,tmpEntity.jobEntity.jobImg]] placeholderImage:[UIImage imageNamed:@"job_default_img_small"]];
    else
        cell.jobImg.image = [UIImage imageNamed:@"job_default_img_small"];
    if(tmpEntity.jobEntity.title)
        cell.jobNamelab.text = tmpEntity.jobEntity.title;
    if(tmpEntity.jobEntity.money)
    {
        NSMutableAttributedString *money = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%0.2f/天",tmpEntity.jobEntity.money]];
        NSRange range1 = NSMakeRange(0, money.string.length - 2);
        NSRange range2 = NSMakeRange(money.string.length - 2, 2);
        [money addAttribute:NSForegroundColorAttributeName value:BrowseRecordPageMoneyColor range:range1];
        [money addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL] range:range2];
        cell.rmbLab.attributedText = money;
    }
    if(tmpEntity.jobEntity.address)
        cell.locLab.text = tmpEntity.jobEntity.address;
    cell.isJobNewImg.hidden = YES;
    
    if(tmpEntity.jobEntity.jobTypeCode)
        cell.typeImg.image = [[ZGUtility shareUtility] getJobTypeImg:[[ZGUtility shareUtility] reflectJobType:[NSString stringWithFormat:@"%ld",tmpEntity.jobEntity.jobTypeCode]]];
    
    if(!tmpEntity.jobEntity.remaining)
        cell.statusImg.hidden = NO;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return BrowseRecordPageListRowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGJobsListCell *cell = (ZGJobsListCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    ZGBrowseRecordEntity *tmpEntity = [jobArr objectAtIndex:indexPath.row];
    
    ZGJobDetailParam *param = [[ZGJobDetailParam alloc]init];
    param.jobId = tmpEntity.jobEntity.identity;
    
    ZGJobDetailController *detailController = [[ZGJobDetailController alloc]init];
    detailController.param = param;
    [self.navigationController pushViewController:detailController animated:YES];
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
