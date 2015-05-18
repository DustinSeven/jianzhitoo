//
//  ZGContactController.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/6.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGContactController.h"
#import "ZGContactCell.h"
#import "ZGContactEntity.h"

@interface ZGContactController ()<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>
{
    ZGContactViewBase *_baseView;
    
    UILocalizedIndexedCollation *collation;
    NSMutableArray *sectionsArray;
    NSMutableArray *sectionsTitle;
    
    NSIndexPath *currentRow;
}

@end

@implementation ZGContactController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[ZGContactViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.dataSource = self;
        _baseView.baseTableView.delegate = self;
        
        [self initSortArr];
        
        currentRow = nil;
    }
}

- (void)initSortArr
{
    collation = [UILocalizedIndexedCollation currentCollation];
    sectionsTitle = [[NSMutableArray alloc]initWithArray:[collation sectionTitles]];
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    
    NSArray *srcArray = @[@"林荣", @"林丹", @"周董", @"周树人", @"周杰伦", @"阿华"];
    sectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    for (NSInteger index = 0; index < sectionTitlesCount; index++)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [sectionsArray addObject:array];
    }
    
    for (int i = 0;i<srcArray.count;++i)
    {
        ZGContactEntity *contact = [[ZGContactEntity alloc]init];
        contact.name = [srcArray objectAtIndex:i];
        NSInteger sectionNumber = [collation sectionForObject:contact collationStringSelector:@selector(name)];
        NSMutableArray *sectionNames = sectionsArray[sectionNumber];
        [sectionNames addObject:contact];
    }
    
    for (int i = 0; i < sectionTitlesCount; i++)
    {
        NSMutableArray *personArrayForSection = sectionsArray[i];
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(name)];
        sectionsArray[i] = sortedPersonArrayForSection;
    }
    
    for(int i = 0;i<sectionsArray.count;++i)
    {
        if([[sectionsArray objectAtIndex:i]count] == 0)
        {
            [sectionsTitle removeObjectAtIndex:i];
            [sectionsArray removeObjectAtIndex:i];
            i--;
        }
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)closeAllCell
{
    if(currentRow)
    {
        SWTableViewCell *cell = (SWTableViewCell *)[_baseView.baseTableView cellForRowAtIndexPath:currentRow];
        [cell hideUtilityButtonsAnimated:YES];
        
        currentRow = nil;
    }
}

#pragma mark  - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionsArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sectionsArray objectAtIndex:section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SessionCell";
    ZGContactCell *cell = (ZGContactCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ZGContactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
    }

    ZGContactEntity *entity = [[sectionsArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.userImg.image = [UIImage imageNamed:@"user_img_default_90px"];
    cell.userNameLab.text = entity.name;
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [sectionsTitle objectAtIndex:section];
//}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    headView.backgroundColor = VIEW_BACKGROUND;
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 20)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    titleLab.textColor = APP_FONT_COLOR_THIN;
    titleLab.text = [sectionsTitle objectAtIndex:section];
    [headView addSubview:titleLab];
    
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ContactCellRowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGContactCell *cell = (ZGContactCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return sectionsTitle;
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
    NSIndexPath *row = [_baseView.baseTableView indexPathForCell:cell];
    switch (state) {
        case 0:
        {
            NSLog(@"utility buttons closed");
            if(currentRow)
            {
                if(row.section == currentRow.section && row.row == currentRow.row)
                {
                    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
                    currentRow = nil;
                }
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
            
//            NSIndexPath *cellIndexPath = [_baseView.baseTableView indexPathForCell:cell];
//            [arr removeObjectAtIndex:cellIndexPath.row];
//            [_baseView.baseTableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
//            
//            [cell hideUtilityButtonsAnimated:YES];
            currentRow = nil;
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
