//
//  ZYTools.h
//  PhoneMeeting
//
//  Created by apple on 15/6/5.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface ZYTools : NSObject

+ (BOOL)validatePassWord: (NSString *) candidate;
+ (BOOL)checkTel:(NSString *)str;

+ (void)copyDataBaseToSandBox;
+ (NSString *)getDBFilePath;
+ (FMDatabase *)getDB;

//汉字转化为拼音
+ (NSString *)chineseToSpelling:(NSString *)chinseStr;
//取得联系人的原始数据
+ (NSArray *)getAddressBookPersonDataInArray;
//取得联系人的名字，如果是汉字，转为拼音，然后以 pinyin:联系人 的格式保存到字典中
+ (NSDictionary *)getAddressBookPersonDataInDic;
//取出以字典方式保存的联系人，按key进行顺序排序,返回排序后的key的数组
+ (NSArray *)getAddressBookPersonNameInSortedArray;

@end
