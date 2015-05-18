//
//  ZGSessionController.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/6.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGSessionController.h"
#import "ZGSessionCell.h"
#import "ZGSessionDetailController.h"

@interface ZGSessionController ()<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>
{
    ZGSessionViewBase *_baseView;
    
    int currentRow;
    
    NSMutableArray *arr;
}

@end

@implementation ZGSessionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[ZGSessionViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.dataSource = self;
        _baseView.baseTableView.delegate = self;
        
        currentRow = -1;
        
        arr = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",nil];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)closeAllCell
{
    if(currentRow != -1)
    {
        SWTableViewCell *cell = (SWTableViewCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentRow inSection:0]];
        [cell hideUtilityButtonsAnimated:YES];
        
        currentRow = -1;
    }
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SessionCell";
    ZGSessionCell *cell = (ZGSessionCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGSessionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
    }
    cell.tag = (indexPath.row + 1) * 1000;
    
    cell.userImg.image = [UIImage imageNamed:@"user_img_default_90px"];
    cell.userNameLab.text = @"李明伟";
    cell.descriptionLab.text = @"明天准时签到!";
    cell.timeLab.text = @"2014-12-12";
    return cell;
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SessionCellRowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGSessionCell *cell = (ZGSessionCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    ZGSessionDetailController *sessionDetailController = [[ZGSessionDetailController alloc]init];
    [self.navigationController pushViewController:sessionDetailController animated:YES];
   
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    
    return rightUtilityButtons;
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    int row = (int)[_baseView.baseTableView indexPathForCell:cell].row;
    switch (state) {
        case 0:
        {
            NSLog(@"utility buttons closed");
            if(row == currentRow)
            {
                [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
                currentRow = -1;
            }
        }
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
        {
            NSLog(@"right utility buttons open");
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            currentRow = row;
        }
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
//            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"删除" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
//            [alertTest show];
            
            NSIndexPath *cellIndexPath = [_baseView.baseTableView indexPathForCell:cell];
            [arr removeObjectAtIndex:cellIndexPath.row];
            [_baseView.baseTableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            [cell hideUtilityButtonsAnimated:YES];
            currentRow = -1;
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
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
