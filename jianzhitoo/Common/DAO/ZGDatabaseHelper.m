//
//  ZGDatabaseHelper.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGDatabaseHelper.h"

static ZGDatabaseHelper *helper;

@interface ZGDatabaseHelper(){
    FMDatabase *db;
}

@end


@implementation ZGDatabaseHelper

+ (ZGDatabaseHelper *)shareHelper;
{
    @synchronized([ZGDatabaseHelper class]){
        if(!helper){
            helper = [[self alloc]init];
        }
        return  helper;
    }
    return nil;
}

- (id)init{
    self = [super init];
    if(self){
        db = [FMDatabase databaseWithPath:[self databasePath]];
        [self createTableIfNotExist];
    }
    return self;
}

- (NSString *)databasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"jianzhitoo.db"];
    
    return path;
}

- (BOOL)createTableIfNotExist
{
    if ([db open]) {
        
        NSString *sql1 = @"CREATE TABLE IF NOT EXISTS job_tab (jobId long,title text,money double,address text,countType text,moneyType text,jobImg text,timeType int,jobType text,remaining int,jobTypeCode long,isJobNew int,browseDate date)";
        NSString *sql2 = @"CREATE TABLE IF NOT EXISTS search_history_tab (id INTEGER PRIMARY KEY AUTOINCREMENT,keyWord text,condition text,searchDate date,sex int,typeId text,locationId long)";
    
        [db executeUpdate:sql1];
        [db executeUpdate:sql2];
        
        [db close];
    }
    return YES;
}

- (NSMutableArray *)getListOnJobTable
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM job_tab Order by browseDate desc"];
        
        while ([rs next]){
            ZGBrowseRecordEntity *entity = [[ZGBrowseRecordEntity alloc] init];
            entity.jobEntity = [[ZGJobEntity alloc]init];
            
            entity.date = [rs dateForColumn:@"browseDate"];
            entity.jobEntity.identity = [rs longForColumn:@"jobId"];
            entity.jobEntity.title = [rs stringForColumn:@"title"];
            entity.jobEntity.money = [rs doubleForColumn:@"money"];
            entity.jobEntity.address = [rs stringForColumn:@"address"];
            entity.jobEntity.countType = [rs stringForColumn:@"countType"];
            entity.jobEntity.moneyType = [rs stringForColumn:@"moneyType"];
            entity.jobEntity.jobImg = [rs stringForColumn:@"jobImg"];
            entity.jobEntity.timeType = [rs intForColumn:@"timeType"];
            entity.jobEntity.jobType = [rs stringForColumn:@"jobType"];
            entity.jobEntity.remaining = [rs intForColumn:@"remaining"];
            entity.jobEntity.jobTypeCode = [rs longForColumn:@"jobTypeCode"];
            entity.jobEntity.isJobNew = [rs intForColumn:@"isJobNew"];
            
            [array addObject:entity];
        }
        
        [rs close];
        [db close];
    }
    
    return array;
}


- (ZGBrowseRecordEntity *)searchOnJobTableWithJobId:(long int)jobId
{
    ZGBrowseRecordEntity *entity = nil;
    if (jobId == 0) {
        return nil;
    }
    
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM job_tab WHERE jobId = ?",[NSNumber numberWithLong:jobId]];
        while ([rs next]) {
            entity = [[ZGBrowseRecordEntity alloc] init];
            
            entity.date = [rs dateForColumn:@"browseDate"];
            entity.jobEntity.identity = [rs longForColumn:@"jobId"];
            entity.jobEntity.title = [rs stringForColumn:@"title"];
            entity.jobEntity.money = [rs doubleForColumn:@"money"];
            entity.jobEntity.address = [rs stringForColumn:@"address"];
            entity.jobEntity.countType = [rs stringForColumn:@"countType"];
            entity.jobEntity.moneyType = [rs stringForColumn:@"moneyType"];
            entity.jobEntity.jobImg = [rs stringForColumn:@"jobImg"];
            entity.jobEntity.timeType = [rs intForColumn:@"timeType"];
            entity.jobEntity.jobType = [rs stringForColumn:@"jobType"];
            entity.jobEntity.remaining = [rs intForColumn:@"remaining"];
            entity.jobEntity.jobTypeCode = [rs longForColumn:@"jobTypeCode"];
            entity.jobEntity.isJobNew = [rs intForColumn:@"isJobNew"];
        }
        
        [rs close];
        [db close];
    }
    return entity;
}

- (void)insertOnJobTableWithEntity:(ZGBrowseRecordEntity *)entity
{
    if([self searchOnJobTableWithJobId:entity.jobEntity.identity])
    {
        [self updateObJobTableWithEntity:entity];
    }
    else
    {
        if ([db open]) {
            [db executeUpdate:@"INSERT INTO job_tab (jobId,title,money,address,countType,moneyType,jobImg,timeType,jobType,remaining,jobTypeCode,isJobNew,browseDate) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
             [NSNumber numberWithLong:entity.jobEntity.identity],
             entity.jobEntity.title,
             [NSNumber numberWithDouble:entity.jobEntity.money],
             entity.jobEntity.address,
             entity.jobEntity.countType,
             entity.jobEntity.moneyType,
             entity.jobEntity.jobImg,
             [NSNumber numberWithInt:entity.jobEntity.timeType],
             entity.jobEntity.jobType,
             [NSNumber numberWithInt:entity.jobEntity.remaining],
             [NSNumber numberWithLong:entity.jobEntity.jobTypeCode],
             [NSNumber numberWithInt:entity.jobEntity.isJobNew],
             entity.date];
            
            [db close];
        }
    }
}

- (void)deleteOnJobTable
{
    if ([db open]) {
            [db executeUpdate:@"DELETE FROM job_tab"];
        
        [db close];
    }
}

- (void)updateObJobTableWithEntity:(ZGBrowseRecordEntity *)entity
{
    if ([db open]) {
        [db executeUpdate:@"UPDATE job_tab SET title = ?,money = ?,address = ?,countType = ?,moneyType = ?,jobImg = ?,timeType = ?,jobType = ?,remaining = ?,jobTypeCode = ?,isJobNew = ?,browseDate = ? WHERE jobId = ?",
         entity.jobEntity.title,
         [NSNumber numberWithDouble:entity.jobEntity.money],
         entity.jobEntity.address,
         entity.jobEntity.countType,
         entity.jobEntity.moneyType,
         entity.jobEntity.jobImg,
         [NSNumber numberWithInt:entity.jobEntity.timeType],
         entity.jobEntity.jobType,
         [NSNumber numberWithInt:entity.jobEntity.remaining],
         [NSNumber numberWithInt:entity.jobEntity.jobTypeCode],
         [NSNumber numberWithInt:entity.jobEntity.isJobNew],
         entity.date,
         [NSNumber numberWithLong:entity.jobEntity.identity]];
        
        [db close];
    }
}






- (NSMutableArray *)getListOnSearchHistoryTable
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM search_history_tab Order by searchDate desc"];
        
        while ([rs next]){
            ZGSearchRecordEntity *entity = [[ZGSearchRecordEntity alloc] init];
            entity.identity = [rs intForColumn:@"id"];
            entity.keyWord = [rs stringForColumn:@"keyWord"];
            entity.condition = [rs stringForColumn:@"condition"];
            entity.sex = [rs intForColumn:@"sex"];
            entity.typeId = [rs stringForColumn:@"typeId"];
            entity.locationId = [rs longForColumn:@"locationId"];
            entity.searchDate = [rs dateForColumn:@"searchDate"];
            [array addObject:entity];
        }
        
        [rs close];
        [db close];
    }
    
    return array;
}

- (ZGSearchRecordEntity *)searchOnSearchHistoryTableWithKeyWord:(NSString *)keyWord condition:(NSString *)condition
{
    ZGSearchRecordEntity *entity = nil;
    if([[keyWord stringByReplacingOccurrencesOfString:@"" withString:@" "] isEqualToString:@""] && [[condition stringByReplacingOccurrencesOfString:@"" withString:@" "] isEqualToString:@""])
        return nil;
    
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM search_history_tab WHERE keyWord = ? and condition = ?",keyWord,condition];
        while ([rs next])
        {
            entity = [[ZGSearchRecordEntity alloc] init];
            entity.identity = [rs intForColumn:@"id"];
            entity.keyWord = [rs stringForColumn:@"keyWord"];
            entity.condition = [rs stringForColumn:@"condition"];
            entity.sex = [rs intForColumn:@"sex"];
            entity.typeId = [rs stringForColumn:@"typeId"];
            entity.locationId = [rs longForColumn:@"locationId"];
            entity.searchDate = [rs dateForColumn:@"searchDate"];
        }
        
        [rs close];
        [db close];
    }
    return entity;
}

- (void)insertOnSearchHistoryTableWithEntity:(ZGSearchRecordEntity *)entity
{
    if([self searchOnSearchHistoryTableWithKeyWord:entity.keyWord condition:entity.condition])
    {
        [self updateObSearchHistoryTableWithEntity:entity];
    }
    else
    {
        if ([db open]) {
            [db executeUpdate:@"INSERT INTO search_history_tab (sex,searchDate,condition,keyWord,typeId,locationId) VALUES (?,?,?,?,?,?)",
             [NSNumber numberWithInt:entity.sex],
             entity.searchDate,
             entity.condition,
             entity.keyWord,
             entity.typeId,
             [NSNumber numberWithLong:entity.locationId]
             ];
            
            [db close];
        }
    }
}

- (void)updateObSearchHistoryTableWithEntity:(ZGSearchRecordEntity *)entity
{
    if ([db open]) {
        [db executeUpdate:@"UPDATE search_history_tab SET searchDate = ? where keyWord = ? and condition = ?",
         entity.searchDate,
         entity.keyWord,
         entity.condition];
        
        [db close];
    }
}

- (void)deleteOnSearchHistoryTable
{
    if ([db open]) {
        [db executeUpdate:@"DELETE FROM search_history_tab"];
        
        [db close];
    }
}
@end
