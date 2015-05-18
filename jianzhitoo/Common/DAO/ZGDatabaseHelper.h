//
//  ZGDatabaseHelper.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/28/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "ZGBrowseRecordEntity.h"
#import "ZGSearchRecordEntity.h"


@interface ZGDatabaseHelper : NSObject

+ (ZGDatabaseHelper *)shareHelper;

- (NSMutableArray *)getListOnJobTable;

- (ZGBrowseRecordEntity *)searchOnJobTableWithJobId:(long int)jobId;

- (void)insertOnJobTableWithEntity:(ZGBrowseRecordEntity *)entity;

- (void)deleteOnJobTable;

- (void)updateObJobTableWithEntity:(ZGBrowseRecordEntity *)entity;



- (NSMutableArray *)getListOnSearchHistoryTable;

- (ZGSearchRecordEntity *)searchOnSearchHistoryTableWithKeyWord:(NSString *)keyWord condition:(NSString *)condition;

- (void)insertOnSearchHistoryTableWithEntity:(ZGSearchRecordEntity *)entity;

- (void)deleteOnSearchHistoryTable;

- (void)updateObSearchHistoryTableWithEntity:(ZGSearchRecordEntity *)entity;

@end
