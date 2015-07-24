//
//  ZYHistoryMeetingObj.m
//  PhoneMeeting
//
//  Created by apple on 15/6/9.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYHistoryMeetingObj.h"
#import "ZYTools.h"
@implementation ZYHistoryMeetingObj



+ (BOOL)insertIntoAMeeting:(ZYHistoryMeetingObj *)obj{
    FMDatabase *db = [ZYTools getDB];
    
    [db open];
    if (![db tableExists:@"HistoryMeeting"]) {
        NSLog(@"表不存在,创建表");
        [db executeUpdate:@"CREATE TABLE HistoryMeeting (id INTEGER PRIMARY KEY AUTOINCREMENT, theme TEXT, date TEXT,presenter TEXT)"];
    }
    
    
    BOOL isSuccess = [db executeUpdate:@"insert into HistoryMeeting(theme,date,presenter) values (?,?,?)",obj.theme,obj.date,obj.presenter];
    [db close];
    
    return isSuccess;
}

+ (int)getLastID{
    
    FMDatabase *db = [ZYTools getDB];
    
    [db open];
    if (![db tableExists:@"HistoryMeeting"]) {
        NSLog(@"表不存在,创建表");
        return 0;
    }
    
    
    FMResultSet *rs = [db executeQuery:@"select max(id) from HistoryMeeting"];
    int maxID = 0;
    while ([rs next]) {
        maxID = [rs intForColumnIndex:0];
    }
    [db close];
    
    return maxID;
    
}
@end
