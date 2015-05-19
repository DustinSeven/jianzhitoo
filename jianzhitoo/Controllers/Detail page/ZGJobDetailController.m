//
//  ZGJobDetailController.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/6/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGJobDetailController.h"
#import "ZGJobDetailViewIphone.h"
#import "ZGJobDetailCell.h"
#import "ZGRegistrationController.h"
#import "ZGJobDetailProcess.h"
#import "UIImageView+WebCache.h"
#import "ZGSchoolmateEntity.h"
#import "ZGSchoolmateParam.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"
#import "ZGLoginController.h"
#import "ZGUserInfoController.h"
#import "ZGSchoolmateController.h"


@interface ZGJobDetailController()<UITableViewDataSource,UITableViewDelegate,ZGFailImgAlertViewIphoneDelegate,ZGActionSheetDelegate>
{
    ZGJobDetailViewBase *_baseView;
    
    NSString *jobName;
    NSMutableAttributedString *company;
    NSMutableAttributedString *money;
    NSMutableAttributedString *time;
    NSMutableAttributedString *deadline;
    NSMutableAttributedString *location;
    NSMutableAttributedString *numAndGender;
    NSMutableAttributedString *heightAndHealth;
    NSMutableAttributedString *detail;
    NSMutableAttributedString *remark;
    
    NSMutableParagraphStyle *paragraphStyle;
    
    ZGJobDetailEntity *jobDetailEntity;

    int numOfRows;
    
    ZGUserInfoEntity *userInfoEntity;
    
    ZGActionSheet *shareActivity;
    NSArray *shareButtonTitleArr;
    NSArray *shareButtonImgArr;
    
    NSMutableArray *schoolmatesArr;
    
    int cuurentSchoolmateIndex;
    
    ZGFailImgAlertViewIphone *loadDetailFailAlert;
    
    NSString *urlOfSource;
    NSString *title;
    NSString *content;
    NSString *coordType;
    NSString *baiduAppStr;
    NSURL *baiduAppUrl;
    NSString *gaodeAppStr;
    NSURL *gaodeAppUrl;
    NSString *baiduWebStr;
    NSURL *baiduWebUrl;
    
    UIImage *jobImg;
}
@end

@implementation ZGJobDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"兼职详情";
    
    if(IS_PHONE)
    {
        shareButtonTitleArr = @[@"微信朋友圈",@"微信好友"];
        shareButtonImgArr = @[@"share_btn_timeline_icon_normal",@"share_btn_session_icon_normal"];
        
        self.navigationItem.rightBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"job_detail_share_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"job_detail_share_btn_icon_pressed"] text:@"" target:self action:@selector(shareBtnClicked:) spacing:-15];
//        self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(backBtnClicked:) spacing:-15];
        
        self.isDataChanged = YES;
        
        schoolmatesArr = [NSMutableArray array];
        
        numOfRows = 0;
        
        _baseView = [[ZGJobDetailViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.dataSource = self;
        _baseView.baseTableView.delegate = self;
        
        paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:JobDetailLineSpacing];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    if(self.isDataChanged)
    {
        [self sendRequest];
        self.isDataChanged = NO;
    }
}

- (void)sendRequest
{
    ZGSchoolmateParam *schoolmateParam = [[ZGSchoolmateParam alloc]init];
    NSDictionary *schoolmateParamDict = nil;
    if(userInfoEntity)
    {
        schoolmateParam.userId = userInfoEntity.identity;
        schoolmateParam.mobile = userInfoEntity.mobile;
        schoolmateParam.password = userInfoEntity.password;
        schoolmateParam.jobId = self.param.jobId;
        schoolmateParam.page = 1;
        schoolmateParam.pageSize = 10;
        
        self.param.userId = userInfoEntity.identity;
        
        schoolmateParamDict = [schoolmateParam getDictionary];
        
        
        
    }

    
    [[ZGJobDetailProcess shareInstance]getJobDetailWithJobParam:[self.param getDictionary] schoolmateParam:schoolmateParamDict parentView:_baseView jobSuccess:^(AFHTTPRequestOperation *jobOperation, id jobResponseObject) {
        if([[jobResponseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [jobResponseObject objectForKey:@"data"];
            jobDetailEntity= [[ZGJobDetailEntity alloc]initWithAttributes:[data objectAtIndex:0]];
            
            urlOfSource = [@"兼职兔" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            title = [jobDetailEntity.jobName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            content = [jobDetailEntity.address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            coordType = [@"gcj02" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            baiduAppStr = [NSString stringWithFormat:@"baidumap://map/marker?location=%@,%@&title=%@&content=%@&src=%@&coord_type=%@",jobDetailEntity.latitude , jobDetailEntity.longitude,title,content,urlOfSource,coordType];
            baiduAppUrl = [[NSURL alloc]initWithString:baiduAppStr];
            gaodeAppStr = [NSString stringWithFormat:@"iosamap://viewMap?sourceApplication=%@&poiname=%@&backScheme=wx0fa13deb7fc51d43&lat=%@&lon=%@",urlOfSource,title,jobDetailEntity.latitude , jobDetailEntity.longitude];
            gaodeAppUrl = [[NSURL alloc]initWithString:gaodeAppStr];
            baiduWebStr = [NSString stringWithFormat:@"http://api.map.baidu.com/marker?location=%@,%@&title=%@&content=%@&output=html&src=%@&coord_type=%@",jobDetailEntity.latitude , jobDetailEntity.longitude,title,content,urlOfSource,coordType];
            baiduWebUrl = [[NSURL alloc]initWithString:baiduWebStr];
            
            if(jobDetailEntity.jobName)
                jobName = jobDetailEntity.jobName;
            if(jobDetailEntity.company)
                company = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"招聘单位：%@",jobDetailEntity.company]];
            if(jobDetailEntity.money)
                money = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%0.2f元/%@",jobDetailEntity.money,jobDetailEntity.payUnit]];
            NSRange range1 = NSMakeRange(0, money.string.length - 2);
            NSRange range2 = NSMakeRange(money.string.length - 2, 2);
            [money addAttribute:NSForegroundColorAttributeName value:JobDetailMoneyColor range:range1];
            [money addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL] range:range2];
            if(jobDetailEntity.time)
            {
                time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"工作时间：%@",jobDetailEntity.time ]];
                [time addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [time.string length])];
            }
            if(jobDetailEntity.deadline)
            {
//                NSString *str = [NSString stringWithFormat:@"%@",jobDetailEntity.deadline];
//                NSString *dateStr = [[[str substringToIndex:9] stringByAppendingString:@" "]stringByAppendingString:[str substringFromIndex:11]];
                
                deadline = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"截止时间：%@",jobDetailEntity.deadline ]];
            }
            if(jobDetailEntity.address)
            {
                location = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"工作地点：%@",[jobDetailEntity.address stringByReplacingOccurrencesOfString:@"\n" withString:@""]]];
                [location addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [location.string length])];
            }
            
            NSString *num;
            NSString *sex;
            int remaining = 0;
            if(jobDetailEntity.jobNum)
                num = [NSString stringWithFormat:@"%d",jobDetailEntity.jobNum];
            if(jobDetailEntity.sex)
            {
                if(jobDetailEntity.sex == 0)
                    sex = @"不限男女";
                if(jobDetailEntity.sex == 1)
                    sex = @"男";
                if(jobDetailEntity.sex == 2)
                    sex = @"女";
            }
            if(jobDetailEntity.remaining)
                remaining = jobDetailEntity.remaining;
            
            numAndGender = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已报/总人数：%d/%@人次\n性别：%@",([num intValue] - remaining),num,sex]];
            [numAndGender addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [numAndGender.string length])];
            NSString *height = @"";
            NSString *health = @"";
            if(jobDetailEntity.height)
                height = [NSString stringWithFormat:@"%0.0fcm",jobDetailEntity.height];
            if(jobDetailEntity.health)
            {
                if(jobDetailEntity.health == 0)
                    health = @"不需要";
                else
                    health = @"需要";
            }
            heightAndHealth = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"身高：%@\n健康证：%@",height,health]];
            [heightAndHealth addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [heightAndHealth.string length])];
            NSString *jobContent = @"";
            NSString *interview = @"";
            NSString *interviewAddr = @"";
            NSString *interviewTime = @"";
            if(jobDetailEntity.jobContent)
                jobContent = jobDetailEntity.jobContent;
            if(jobDetailEntity.interview)
            {
                if(jobDetailEntity.interview == 0)
                    interview = @"不需要面试";
                else
                    interview = @"需要面试";
            }
            if(jobDetailEntity.interviewAddr)
                interviewAddr = jobDetailEntity.interviewAddr;
            if(jobDetailEntity.interviewTime)
                interviewTime = jobDetailEntity.interviewTime;
            
            if(jobDetailEntity.interview)
            {
                if(jobDetailEntity.interview == 0)
                {
                    detail = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"详情：\n是否面试：%@\n工作内容：%@",interview,jobContent]];
                }
                else
                {
                    detail = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"详情：\n是否面试：%@\n面试地点：%@\n面试时间：%@\n工作内容：%@",interview,interviewAddr,interviewTime,jobContent]];
                }
            }
            [detail addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [detail.string length])];
            if(jobDetailEntity.remark)
            {
                remark = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"备注：%@",jobDetailEntity.remark]];
                [remark addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [remark.string length])];
            }
        }
        else
        {
            [ZGUtility showAlertWithText:[jobResponseObject objectForKey:@"message"] parentView:nil];
        }
        
    } jobFailure:^(AFHTTPRequestOperation *jobOperation, NSError *jobError) {
        
        loadDetailFailAlert = [ZGUtility showImgAlertWithImg:[UIImage imageNamed:@"load_fail_img"] frame:CGRectMake((SCREEN_WIDTH - 149.5) / 2,50, 149.5, 138.5) delegate:self parentView:_baseView.baseTableView];
        
    } schoolmateSuccess:^(AFHTTPRequestOperation *schoolmateOperation, id schoolmateResponseObject) {
        
        if(schoolmateParamDict)
        {
            if([[schoolmateResponseObject objectForKey:@"code"]intValue] == 200 || [[schoolmateResponseObject objectForKey:@"code"]intValue] == 300)
            {
                NSArray *data = [schoolmateResponseObject objectForKey:@"data"];
                [schoolmatesArr removeAllObjects];
                if([[schoolmateResponseObject objectForKey:@"code"]intValue] == 200)
                {
                    for(int i = 0; i < data.count ; ++i)
                    {
                        ZGSchoolmateEntity *schoolmateEntity = [[ZGSchoolmateEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                        [schoolmatesArr addObject:schoolmateEntity];
                    }
                }
            }
            else
            {
                [ZGUtility showAlertWithText:[schoolmateResponseObject objectForKey:@"message"] parentView:nil];
            }
        }
        
        numOfRows = 12;
        [_baseView.baseTableView reloadData];
        
        
    } schoolmateFailure:^(AFHTTPRequestOperation *schoolmateOperation, NSError *schoolmateError) {
        
        
    }];

}

#pragma mark - shareBtnClicked
- (void)shareBtnClicked:(UIButton *)button
{
    if(shareActivity && shareActivity.hidden == NO)
        [shareActivity dismissed];
    else
    {
        shareActivity = [[ZGActionSheet alloc]initWithTitle:@"分享兼职" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArr withShareButtonImagesName:shareButtonImgArr frame:CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight)];
        
        [shareActivity showInView:self.view];
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

- (CGSize)countWordSize:(NSString *)words attributeStr:(NSMutableAttributedString *)str mostSize:(CGSize)mostSize WordSize:(int)wordSize
{
    UILabel *lab = [[UILabel alloc]init];
    if(words)
    {
        lab.text = words;
    }
    else
    {
        lab.attributedText = str;
    }
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    lab.numberOfLines = 0;
    lab.font = [UIFont systemFontOfSize:wordSize];
    CGSize wordsSize = [lab sizeThatFits:mostSize];
    
    return wordsSize;
}

#pragma mark - back button clicked
- (void)backBtnClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numOfRows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"JobsDetailListCell";
    ZGJobDetailCell *cell = (ZGJobDetailCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGJobDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    switch (indexPath.row)
    {
        case JobDetailCellType_JobImg:
        {
            [cell updateUI:JobDetailCellType_JobImg];
            
            cell.jobImg.image = [UIImage imageNamed:@"job_default_img_large"];
            if(jobDetailEntity.jobImg)
                [cell.jobImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,jobDetailEntity.jobImg]] placeholderImage:[UIImage imageNamed:@"job_default_img_large"] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    jobImg = cell.jobImg.image;
                } isScaleToCustomSize:NO];
            if(jobDetailEntity.jobTypeCode)
                 cell.jobTypeImg.image = [[ZGUtility shareUtility] getJobTypeImg:[[ZGUtility shareUtility] reflectJobType:[NSString stringWithFormat:@"%ld",jobDetailEntity.jobTypeCode]]];
        }
            break;
        case JobDetailCellType_JobName:
        {
            [cell updateUI:JobDetailCellType_JobName];
            cell.jobNameLab.frame = CGRectMake(JobDetailMainSpacing, JobDetailUpDownSpacing, SCREEN_WIDTH - 2 * JobDetailMainSpacing,[self countWordSize:jobName attributeStr:nil mostSize:CGSizeMake(SCREEN_WIDTH - 2 * JobDetailMainSpacing, 0) WordSize:JobDetailJobNameSize].height);
            cell.jobNameLab.text = jobName;
        }
            break;
        case JobDetailCellType_Company:
        {
            [cell updateUI:JobDetailCellType_Company];
            
            cell.leftIcon.frame = CGRectMake(JobDetailMainSpacing, 9, 30.5, 30.5);
            cell.leftIcon.image = [UIImage imageNamed:@"job_detail_company_icon"];
            
            cell.contentLab.frame = CGRectMake(JobDetailWordToLeftSpacing, JobDetailUpDownSpacing, SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, [self countWordSize:nil attributeStr:company mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height);
            cell.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
            cell.contentLab.textColor = APP_FONT_COLOR_NORMAL;
            cell.contentLab.attributedText = company;
        }
            break;
        case JobDetailCellType_Money:
        {
            [cell updateUI:JobDetailCellType_Money];
            
            cell.leftIcon.frame = CGRectMake(JobDetailMainSpacing + 3.5, 11, 23.5, 23.5);
            cell.leftIcon.image = [UIImage imageNamed:@"job_detail_money_icon"];
            
            
            if(money)
                cell.contentLab.attributedText = money;
            CGSize moneyLabSize = [cell.contentLab sizeThatFits:CGSizeMake(0, 15)];
            cell.contentLab.frame = CGRectMake(JobDetailWordToLeftSpacing, JobDetailUpDownSpacing, moneyLabSize.width, 15) ;
            cell.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
//            cell.contentLab.textColor = APP_FONT_COLOR_NORMAL;
            
            cell.moneyIcon.frame = CGRectMake(CGRectGetMaxX(cell.contentLab.frame) + 30, 14, 43, 17.5);
            cell.moneyIcon.image = [ZGUtility getMoneyType:jobDetailEntity.countType];
        }
            break;
        
        case JobDetailCellType_Time:
        {
                        
            [cell updateUI:JobDetailCellType_Time];
            
            cell.leftIcon.frame = CGRectMake(JobDetailMainSpacing, 8, 30.5, 30.5);
            cell.leftIcon.image = [UIImage imageNamed:@"job_detail_time_icon"];
            
            cell.contentLab.frame = CGRectMake(JobDetailWordToLeftSpacing, JobDetailUpDownSpacing, SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, [self countWordSize:nil attributeStr:time mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height);
            cell.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
            cell.contentLab.textColor = APP_FONT_COLOR_NORMAL;
            
            if(time)
                cell.contentLab.attributedText = time;
        }
            break;
        case JobDetailCellType_Deadline:
        {
            
            
            [cell updateUI:JobDetailCellType_Time];
            
            cell.leftIcon.frame = CGRectMake(JobDetailMainSpacing + 3.5, 12, 23.5, 23.5);
            cell.leftIcon.image = [UIImage imageNamed:@"job_detail_deadline_icon"];
            
            cell.contentLab.frame = CGRectMake(JobDetailWordToLeftSpacing, JobDetailUpDownSpacing, SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, [self countWordSize:nil attributeStr:deadline mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height);
            cell.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
            cell.contentLab.textColor = APP_FONT_COLOR_NORMAL;
            
            if(deadline)
            {
                cell.contentLab.attributedText = deadline;
            }
        }
            break;
        case JobDetailCellType_Location:
        {
            
            
            [cell updateUI:JobDetailCellType_Location];
            
            cell.leftIcon.frame = CGRectMake(JobDetailMainSpacing, 8, 30.5, 30.5);
            cell.leftIcon.image = [UIImage imageNamed:@"job_detail_location_icon"];
            
            if(jobDetailEntity.latitude && jobDetailEntity.longitude)
            {
                cell.contentLab.frame = CGRectMake(JobDetailWordToLeftSpacing, JobDetailUpDownSpacing, SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing - JobDetailMapBtnWidth - 10, [self countWordSize:nil attributeStr:location mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing - JobDetailMapBtnWidth - 10, 0) WordSize:APP_FONT_SIZE_NORMAL].height);
                cell.mapBtn.hidden = NO;
            }
            else
            {
                cell.contentLab.frame = CGRectMake(JobDetailWordToLeftSpacing, JobDetailUpDownSpacing, SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, [self countWordSize:nil attributeStr:location mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height);
                cell.mapBtn.hidden = YES;
            }
            cell.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
            cell.contentLab.textColor = APP_FONT_COLOR_NORMAL;
            
            if(location)
                cell.contentLab.attributedText = location;
            
            
        }
            break;
        case JobDetailCellType_NumAndGender:
        {
            [cell updateUI:JobDetailCellType_NumAndGender];
            
            cell.contentLab.frame = CGRectMake(JobDetailWordToLeftSpacing, JobDetailUpDownSpacing, SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, [self countWordSize:nil attributeStr:numAndGender mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height);
            cell.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
            cell.contentLab.textColor = APP_FONT_COLOR_NORMAL;
            
            if(numAndGender)
                cell.contentLab.attributedText = numAndGender;
        }
            break;
        case JobDetailCellType_HeightAndHealth:
        {
            [cell updateUI:JobDetailCellType_HeightAndHealth];
            
            cell.contentLab.frame = CGRectMake(JobDetailWordToLeftSpacing, JobDetailUpDownSpacing, SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, [self countWordSize:nil attributeStr:heightAndHealth mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height);
            cell.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
            cell.contentLab.textColor = APP_FONT_COLOR_NORMAL;
            if(heightAndHealth)
                cell.contentLab.attributedText = heightAndHealth;
        }
            break;
        case JobDetailCellType_Detail:
        {
            [cell updateUI:JobDetailCellType_Detail];
            
            cell.leftIcon.frame = CGRectMake(JobDetailMainSpacing, 8, 30.5, 30.5);
            cell.leftIcon.image = [UIImage imageNamed:@"job_detail_detail_icon"];
            
            cell.contentLab.frame = CGRectMake(JobDetailWordToLeftSpacing, JobDetailUpDownSpacing, SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, [self countWordSize:nil attributeStr:detail mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height);
            cell.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
            cell.contentLab.textColor = APP_FONT_COLOR_NORMAL;
            
            if(detail)
                cell.contentLab.attributedText = detail;
        }
            break;
        case JobDetailCellType_Remark:
        {
            [cell updateUI:JobDetailCellType_Remark];
            
            cell.leftIcon.frame = CGRectMake(JobDetailMainSpacing, 8, 30.5, 30.5);
            cell.leftIcon.image = [UIImage imageNamed:@"job_detail_remark_icon"];
            
            cell.contentLab.frame = CGRectMake(JobDetailWordToLeftSpacing, JobDetailUpDownSpacing, SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, [self countWordSize:nil attributeStr:remark mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height);
            cell.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
            cell.contentLab.textColor = APP_FONT_COLOR_NORMAL;
            
            if(remark)
                cell.contentLab.attributedText = remark;
        }
            break;
        case JobDetailCellType_Schoolmate:
        {
            [cell updateUI:JobDetailCellType_Schoolmate];
            
            
            if(userInfoEntity)
            {
                for(int i = 0;i<schoolmatesArr.count;++i)
                {
                    switch (i) {
                        case 0:
                        {
                            cell.schoolmateImg1.frame = CGRectMake(JobDetailMainSpacing + 15, 45, JobDetailSchoolMateWidth, JobDetailSchoolMateWidth);
                            cell.schoolmateImg1.layer.cornerRadius = JobDetailSchoolMateWidth / 2;
                            ZGSchoolmateEntity *tmpEntity = [schoolmatesArr objectAtIndex:i];
                            if(tmpEntity.userImg)
                               [cell.schoolmateImg1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,tmpEntity.userImg]] placeholderImage:[UIImage imageNamed:@"user_img_default_90px"] isScaleToCustomSize:NO];
                            else
                               cell.schoolmateImg1.image = [UIImage imageNamed:@"user_img_default_90px"];
                            cell.schoolmateImg1.hidden = NO;
                            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSchoolmateAlert:)];
                            [cell.schoolmateImg1 addGestureRecognizer:tap];
                        }
                            break;
                        case 1:
                        {
                            ZGSchoolmateEntity *tmpEntity = [schoolmatesArr objectAtIndex:i];
                            if(tmpEntity.userImg)
                                [cell.schoolmateImg2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,tmpEntity.userImg]] placeholderImage:[UIImage imageNamed:@"user_img_default_90px"] isScaleToCustomSize:NO];
                            else
                                cell.schoolmateImg2.image = [UIImage imageNamed:@"user_img_default_90px"];
                            cell.schoolmateImg2.hidden = NO;
                            if(tmpEntity.ota)
                            {
                                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSchoolmateAlert:)];
                                [cell.schoolmateImg2 addGestureRecognizer:tap];
                            }
                        }
                            break;
                        case 2:
                        {
                            ZGSchoolmateEntity *tmpEntity = [schoolmatesArr objectAtIndex:i];
                            if(tmpEntity.userImg)
                                [cell.schoolmateImg3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,tmpEntity.userImg]] placeholderImage:[UIImage imageNamed:@"user_img_default_90px"] isScaleToCustomSize:NO];
                            else
                                cell.schoolmateImg3.image = [UIImage imageNamed:@"user_img_default_90px"];
                            cell.schoolmateImg3.hidden = NO;
                            if(tmpEntity.ota)
                            {
                                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSchoolmateAlert:)];
                                [cell.schoolmateImg3 addGestureRecognizer:tap];
                            }
                        }
                            break;
                        case 3:
                        {
                            ZGSchoolmateEntity *tmpEntity = [schoolmatesArr objectAtIndex:i];
                            if(tmpEntity.userImg)
                                [cell.schoolmateImg4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,tmpEntity.userImg]] placeholderImage:[UIImage imageNamed:@"user_img_default_90px"] isScaleToCustomSize:NO];
                            else
                                cell.schoolmateImg4.image = [UIImage imageNamed:@"user_img_default_90px"];
                            cell.schoolmateImg4.hidden = NO;
                            if(tmpEntity.ota)
                            {
                                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSchoolmateAlert:)];
                                [cell.schoolmateImg4 addGestureRecognizer:tap];
                            }
                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                    
                }
                
                if(schoolmatesArr.count == 0)
                {
                    cell.schoolmateImg1.frame = CGRectMake((SCREEN_WIDTH - 320) / 2, 45, 320, JobDetailSchoolMateWidth);
                    cell.schoolmateImg1.layer.cornerRadius = 0;
                    cell.schoolmateImg1.image = [UIImage imageNamed:@"job_detail_share_icon"];
                    cell.schoolmateImg1.hidden = NO;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareBtnClicked:)];
                    [cell.schoolmateImg1 addGestureRecognizer:tap];
                }
                
                if(schoolmatesArr.count > 5)
                {
                    cell.schoolmateImg5.layer.cornerRadius = 0;
                    cell.schoolmateImg5.image = [UIImage imageNamed:@"job_detail_more_icon"];
                    cell.schoolmateImg5.hidden = NO;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreSchoolmateClicked:)];
                    [cell.schoolmateImg5 addGestureRecognizer:tap];
                }
                
                
                
                if(jobDetailEntity.enroll)
                {
                    [cell.joinBtn setTitle:@"已报名" forState:UIControlStateDisabled];
                    cell.joinBtn.enabled = NO;
                }
                else if(userInfoEntity.sex == 1 && jobDetailEntity.sex == 2)
                {
                    [cell.joinBtn setTitle:@"只限女生报名" forState:UIControlStateDisabled];
                    cell.joinBtn.enabled = NO;
                }
                else if(userInfoEntity.sex == 2 && jobDetailEntity.sex == 1)
                {
                    [cell.joinBtn setTitle:@"只限男生报名" forState:UIControlStateDisabled];
                    cell.joinBtn.enabled = NO;
                }
                else
                    cell.joinBtn.enabled = YES;
            }
            else
            {
                cell.schoolmateImg1.layer.cornerRadius = 0;
                cell.schoolmateImg1.frame = CGRectMake(0, 45, SCREEN_WIDTH, 45);
                cell.schoolmateImg1.image = [UIImage imageNamed:@"job_detail_login_notice_lab"];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginBtnClicked:)];
                [cell.schoolmateImg1 addGestureRecognizer:tap];
                cell.schoolmateImg1.hidden = NO;
            }
            
            if(jobDetailEntity.remaining <= 0)
            {
                [cell.joinBtn setTitle:@"报满了" forState:UIControlStateDisabled];
                cell.joinBtn.enabled = NO;
            }
            int deadLineNum = [[[NSString stringWithFormat:@"%@",jobDetailEntity.deadline] stringByReplacingOccurrencesOfString:@"-" withString:@""]intValue];
            if(![ZGUtility isBeforePressent:deadLineNum])
            {
                [cell.joinBtn setTitle:@"报名已结束" forState:UIControlStateDisabled];
                cell.joinBtn.enabled = NO;
            }
            
            [cell.joinBtn addTarget:self action:@selector(registrationBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;

            
    }
    
    if(indexPath.row % 2 == 0)
    {
        cell.contentView.backgroundColor = JobDetailSingularCellBackground;
    }
    else
    {
        cell.contentView.backgroundColor = JobDetailEvenCellBackground;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case JobDetailCellType_JobImg:
            return 160;
            break;
        case JobDetailCellType_JobName:
            return [self countWordSize:jobName attributeStr:nil mostSize:CGSizeMake(SCREEN_WIDTH - 2 * JobDetailMainSpacing, 0) WordSize:JobDetailJobNameSize].height + 2 * JobDetailUpDownSpacing;
            break;
        case JobDetailCellType_Company:
            return [self countWordSize:nil attributeStr:company mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height + 2 * JobDetailUpDownSpacing;
            break;
        case JobDetailCellType_Money:
            return [self countWordSize:nil attributeStr:money mostSize:CGSizeMake(0, 15) WordSize:14].height + 2 * JobDetailUpDownSpacing;
            break;
        case JobDetailCellType_Time:
            return [self countWordSize:nil attributeStr:time mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height + 2 * JobDetailUpDownSpacing;
            break;
        case JobDetailCellType_Deadline:
            return [self countWordSize:nil attributeStr:deadline mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height + 2 * JobDetailUpDownSpacing;
            break;
        case JobDetailCellType_Location:
            if(jobDetailEntity.latitude && jobDetailEntity.longitude)
                return [self countWordSize:nil attributeStr:location mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing - JobDetailMapBtnWidth - 10, 0) WordSize:APP_FONT_SIZE_NORMAL].height + 2 * JobDetailUpDownSpacing;
            else
                return [self countWordSize:nil attributeStr:location mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height + 2 * JobDetailUpDownSpacing;
            break;
        case JobDetailCellType_NumAndGender:
            return [self countWordSize:nil attributeStr:numAndGender mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height + 2 * JobDetailUpDownSpacing;
            break;
        case JobDetailCellType_HeightAndHealth:
            return [self countWordSize:nil attributeStr:heightAndHealth mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height + 2 * JobDetailUpDownSpacing;
            break;
        case JobDetailCellType_Detail:
            return [self countWordSize:nil attributeStr:detail mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height + 2 * JobDetailUpDownSpacing;
            break;
        case JobDetailCellType_Remark:
            return [self countWordSize:nil attributeStr:remark mostSize:CGSizeMake(SCREEN_WIDTH - JobDetailMainSpacing - JobDetailWordToLeftSpacing, 0) WordSize:APP_FONT_SIZE_NORMAL].height + 2 * JobDetailUpDownSpacing;
            break;
        case JobDetailCellType_Schoolmate:
            return 155;
            break;
        default:
            return 0;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 6)
    {
        if(jobDetailEntity.latitude && jobDetailEntity.longitude)
        {
            UIActionSheet *actionSheet;
            if ([[UIApplication sharedApplication] canOpenURL:baiduAppUrl] && [[UIApplication sharedApplication] canOpenURL:gaodeAppUrl])
            {
                actionSheet = [[UIActionSheet alloc]initWithTitle:@"打开地图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"百度网页地图",@"百度地图",@"高德地图",nil];
                actionSheet.tag = 1000;
            }
            if (![[UIApplication sharedApplication] canOpenURL:baiduAppUrl] && [[UIApplication sharedApplication] canOpenURL:gaodeAppUrl])
            {
                actionSheet = [[UIActionSheet alloc]initWithTitle:@"打开地图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"百度网页地图",@"高德地图",nil];
                actionSheet.tag = 2000;
            }
            if ([[UIApplication sharedApplication] canOpenURL:baiduAppUrl] && ![[UIApplication sharedApplication] canOpenURL:gaodeAppUrl])
            {
                actionSheet = [[UIActionSheet alloc]initWithTitle:@"打开地图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"百度网页地图",@"百度地图",nil];
                actionSheet.tag = 3000;
            }
            if (![[UIApplication sharedApplication] canOpenURL:baiduAppUrl] && ![[UIApplication sharedApplication] canOpenURL:gaodeAppUrl])
            {
                actionSheet = [[UIActionSheet alloc]initWithTitle:@"打开地图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"百度网页地图",nil];
                actionSheet.tag = 4000;
            }
            
            [actionSheet showInView:_baseView.baseTableView];
        }
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
        [[UIApplication sharedApplication] openURL:baiduWebUrl];
    if(actionSheet.tag == 1000)
    {
        if(buttonIndex ==1)
            [[UIApplication sharedApplication] openURL:baiduAppUrl];
        if(buttonIndex == 2)
            [[UIApplication sharedApplication] openURL:gaodeAppUrl];
        
    }
    if(actionSheet.tag == 2000)
    {
        if(buttonIndex == 1)
            [[UIApplication sharedApplication] openURL:gaodeAppUrl];
    }
    if(actionSheet.tag == 3000)
    {
        if(buttonIndex ==1)
            [[UIApplication sharedApplication] openURL:baiduAppUrl];
        
    }
}

- (void)loginBtnClicked:(UITapGestureRecognizer *)recognize
{
    if(!userInfoEntity)
    {
        ZGLoginController *loginController = [[ZGLoginController alloc]init];
        loginController.jobDetailController = self;
        [self presentViewController:loginController animated:YES completion:^{
            
        }];
    }
    
}

- (void)showSchoolmateAlert:(UITapGestureRecognizer *)recognize
{
    cuurentSchoolmateIndex = (int)recognize.view.tag - 700;
    ZGSchoolmateAlertViewIphone *schoolmateAlert = [ZGUtility showSchoolmateAlertWithEntity:[schoolmatesArr objectAtIndex:cuurentSchoolmateIndex] parentView:_baseView];
    [schoolmateAlert.callBtn addTarget:self action:@selector(callBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark call btn clicked
- (void)callBtnClicked:(UIButton *)button
{
    ZGSchoolmateEntity *tmpEntity = [schoolmatesArr objectAtIndex:cuurentSchoolmateIndex];
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"telprompt://%@",tmpEntity.mobile]];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        NSLog(@"no");
    }
}


#pragma mark - registration btn clicked
- (void)registrationBtnClicked:(UIButton *)button
{
    if(userInfoEntity)
    {
        if(![ZGUtility isInformationComplete])
        {
            ZGCommonAlertViewIphone *alertView = [ZGUtility showAlertWithText:@"您还没完善您的个人信息，请完善后再报名！" parentView:nil];
            [alertView.btn addTarget:self action:@selector(changeInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            ZGRegistrationController *registrationController = [[ZGRegistrationController alloc]init];
            registrationController.jobId = self.param.jobId;
            registrationController.workTimeType = jobDetailEntity.workTimeType;
            registrationController.jobDetailController = self;
            registrationController.jobName = jobDetailEntity.jobName;
            registrationController.shareUrl = jobDetailEntity.shareUrl;
            [self.navigationController pushViewController:registrationController animated:YES];
        }
    }
    else
    {
        ZGLoginController *loginController = [[ZGLoginController alloc]init];
        loginController.jobDetailController = self;
        [self presentViewController:loginController animated:YES completion:^{
            
        }];
    }
}

- (void)changeInfo:(UIButton *)button
{
    ZGUserInfoController *userInfoController = [[ZGUserInfoController alloc]init];
    [self.navigationController pushViewController:userInfoController animated:YES];
}

#pragma mark - ZGFailImgAlertViewIphoneDelegate
- (void)tapOnAlertView
{
    loadDetailFailAlert.hidden = YES;
    [self sendRequest];
}

#pragma mark - View lifecycle

- (void)sendLinkContentWithScrean:(int)screanType
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = jobDetailEntity.jobName;
        message.description = @"我在兼职兔平台报名了一个兼职，一起来参与吧~";
        if(jobImg)
        {
            UIImage *tmpImg = [ZGUtility imageWithImage:jobImg scaledToSize:CGSizeMake(50, 50)];
            [message setThumbImage:tmpImg];
        }
        else
            [message setThumbImage:[UIImage imageNamed:@"logo_108X108"]];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = jobDetailEntity.shareUrl;
        
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


- (void)moreSchoolmateClicked:(UITapGestureRecognizer *)tap
{
    ZGSchoolmateParam *schoolmateParam = [[ZGSchoolmateParam alloc]init];
    schoolmateParam.userId = userInfoEntity.identity;
    schoolmateParam.mobile = userInfoEntity.mobile;
    schoolmateParam.password = userInfoEntity.password;
    schoolmateParam.jobId = self.param.jobId;
    schoolmateParam.page = 1;
    schoolmateParam.pageSize = 10;
    
    ZGSchoolmateController *schoolmateController = [[ZGSchoolmateController alloc]init];
    schoolmateController.param = schoolmateParam;
    [self.navigationController pushViewController:schoolmateController animated:YES];
}

@end
