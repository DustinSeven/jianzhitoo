//
//  ZGRegistrationSuccessController.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegistrationSuccessController.h"

@interface ZGRegistrationSuccessController ()<ZGActionSheetDelegate,sendMsgToWeChatViewDelegate>
{
    ZGRegistrationSuccessViewBase *_baseView;
    
    ZGActionSheet *shareActivity;
    NSArray *shareButtonTitleArr;
    NSArray *shareButtonImgArr;
}

@end

@implementation ZGRegistrationSuccessController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        shareButtonTitleArr = @[@"微信朋友圈",@"微信好友"];
        shareButtonImgArr = @[@"share_btn_timeline_icon_normal",@"share_btn_session_icon_normal"];
        
        _baseView = [[ZGRegistrationSuccessViewIphone alloc]init];
        self.view = _baseView;
        
        self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"down_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"down_btn_icon_pressed"] text:@"" target:self action:@selector(backBtnClick:) spacing:-15];
        
        [_baseView.connectServerBtn addTarget:self action:@selector(connectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
}

#pragma mark - share btn clicked
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

#pragma mark - View lifecycle

- (void)sendLinkContentWithScrean:(int)screanType
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = self.jobName;
        message.description = @"我在兼职兔平台报名了一个兼职，一起来参与吧~";
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = self.shareUrl;
        
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

#pragma mark - connect btn clicked
- (void)connectBtnClicked:(UIButton *)button
{
    if(self.mobile)
    {
         NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"telprompt://%@",self.mobile]];
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
        else
        {
            NSLog(@"no");
        }
    }
}

#pragma mark - back button clicked
- (void)backBtnClick:(UIButton *)button
{
    if(self.jobDetailController)
        self.jobDetailController.isDataChanged = YES;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
