//
//  ZGSessionDetailController.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/12.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGSessionDetailController.h"

@interface ZGSessionDetailController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    ZGSessionDetailViewBase *_baseView;
    
    NSMutableArray *chatArr;
}

@end

@implementation ZGSessionDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[ZGSessionDetailViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        _baseView.chatTextField.delegate = self;
        
        [_baseView.baseTableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit:)]];
        
//        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
//        swipe.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
//        [_baseView.baseTableView addGestureRecognizer:swipe];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        [_baseView.sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
        
        chatArr = [NSMutableArray array];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for(int i = 0; i<15;++i)
    {
        ZGSessionDetailCellFrameModel *frameModel = [[ZGSessionDetailCellFrameModel alloc]init];
        NSDate *senddate=[NSDate date];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"HH:mm"];
        NSString *locationString=[dateformatter stringFromDate:senddate];
        frameModel.timeStr = locationString;
        if(i % 2 == 0)
        {
            frameModel.isMe = YES;
            frameModel.isShowTime = YES;
            frameModel.imgStr = nil;
            frameModel.message = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
        }
        else
        {
            frameModel.isMe = NO;
            frameModel.isShowTime = YES;
            frameModel.imgStr = nil;
            frameModel.message = @"有病";
        }
        [frameModel initValue];
        [chatArr addObject:frameModel];
    }
}

- (void)keyboardWillChange:(NSNotification *)note
{
    NSLog(@"%@", note.userInfo);
    NSDictionary *userInfo = note.userInfo;
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
}

- (void)endEdit:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

- (void)sendMessage
{
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    
    ZGSessionDetailCellFrameModel *frameModel = [[ZGSessionDetailCellFrameModel alloc]init];
    frameModel.timeStr = locationString;
    frameModel.isMe = YES;
    frameModel.isShowTime = YES;
    frameModel.imgStr = nil;
    frameModel.message = _baseView.chatTextField.text;
    [frameModel initValue];
    
    [chatArr addObject:frameModel];
    [_baseView.baseTableView reloadData];
    
    //5.自动滚到最后一行
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:chatArr.count - 1 inSection:0];
    [_baseView.baseTableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    _baseView.chatTextField.text = @"";
}

//- (void)swipe:(UISwipeGestureRecognizer *)tap
//{
//    [self.view endEditing:YES];
//}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return chatArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SessionDetailCell";
    ZGSessionDetailCell *cell = (ZGSessionDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGSessionDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ZGSessionDetailCellFrameModel *frameModel = [chatArr objectAtIndex:indexPath.row];
    cell.frameModel = frameModel;

    return cell;
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGSessionDetailCellFrameModel *frameModel = [chatArr objectAtIndex:indexPath.row];
    return frameModel.cellHeght;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGSessionDetailCell *cell = (ZGSessionDetailCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendMessage];
    
    return YES;
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
