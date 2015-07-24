//
//  ZYHistoryMeetingMemberObj.m
//  PhoneMeeting
//
//  Created by apple on 15/6/9.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYHistoryMeetingMemberObj.h"
#import "ZYTools.h"
@implementation ZYHistoryMeetingMemberObj

+ (BOOL)insertIntoAMeetingMember:(ZYHistoryMeetingMemberObj *)obj{
    
    FMDatabase *db = [ZYTools getDB];
    
    [db open];
    if (![db tableExists:@"HistoryMeeting"]) {
        NSLog(@"表不存在,创建表");
        [db executeUpdate:@"CREATE TABLE HistoryMeetingMember (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT,meetingID INTEGER)"];
    }
    
    
    BOOL isSuccess = [db executeUpdate:@"insert into HistoryMeetingMember(name,phone,meetingID) values (?,?,?)",obj.name,obj.phone,[NSNumber numberWithInt:obj.meetingID]];
    [db close];
    
    return isSuccess;
    

}

@end
