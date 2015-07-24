//
//  ZYUserTableObj.m
//  PhoneMeeting
//
//  Created by apple on 15/6/8.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYUserTableObj.h"

#import "ZYTools.h"

@implementation ZYUserTableObj


+ (BOOL)registerUserWithUserName:(NSString *)userName userPassWord:(NSString *)userPassWord phone:(NSString *)phone{
    FMDatabase *db = [ZYTools getDB];
    
    [db open];
    
    if (![db tableExists:@"User"]) {
        NSLog(@"表不存在,创建表");
        [db executeUpdate:@"CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT, passWord TEXT, phone TEXT)"];
    }
    
    BOOL isRegisterSuccess = [db executeUpdate:@"insert into user(userName,passWord,phone) values(?,?,?)",userName,userPassWord,phone];
    
    if (isRegisterSuccess) {
        NSLog(@"注册成功!");
    }else{
        NSLog(@"注册失败");
    }

    [db close];

    return isRegisterSuccess;
}

+ (BOOL)registerUserWithUserObj:(ZYUserTableObj *)obj{
    return YES;
}
+ (BOOL)selectUserName:(NSString *)userName{
    FMDatabase *db = [ZYTools getDB];
    
    [db open];
    
    if (![db tableExists:@"User"]) {
        NSLog(@"表不存在,创建表");
        [db executeUpdate:@"CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT, passWord TEXT, phone TEXT)"];
    }
    
    FMResultSet *set = [db executeQuery:@"select userName  from User where userName = ?",userName];
    
    while ([set next]) {
        return NO;
    }

    return YES;
}

+ (ZYUserTableObj *)getUserObjWithUserName:(NSString *)userName{
    FMDatabase *db = [ZYTools getDB];
    
    [db open];
     if (![db tableExists:@"User"]) {
         NSLog(@"表不存在");
         [db close];
         return nil;
     }
    FMResultSet *rs = [db executeQuery:@"select * from user where userName = ?",userName];
    
    ZYUserTableObj *obj = [[ZYUserTableObj alloc] init];
    while ([rs next]) {
        obj.ID = [rs intForColumnIndex:0];
        obj.userName = [rs stringForColumnIndex:1];
        obj.userPassWord = [rs stringForColumnIndex:2];
        obj.phone = [rs stringForColumnIndex:3];
    }
    [db close];
    return obj;
}
+(BOOL)changePassWordWithUserName:(NSString *)userName newPassWord:(NSString *)newPassWord{
    FMDatabase *db = [ZYTools getDB];
    
    [db open];
    if (![db tableExists:@"User"]) {
        NSLog(@"表不存在");
        [db close];
        return NO;
    }

    BOOL isSuccess = [db executeUpdate:@"update User set passWord = ? where userName = ?",newPassWord,userName];
    
    [db close];
    return isSuccess;
}

@end
