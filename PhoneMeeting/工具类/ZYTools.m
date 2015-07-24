//
//  ZYTools.m
//  PhoneMeeting
//
//  Created by apple on 15/6/5.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYTools.h"
#import <AddressBook/AddressBook.h>


@implementation ZYTools

static FMDatabase *db = nil;

//数字与字母组合字符串正则表达式
+ (BOOL)validatePassWord: (NSString *) candidate{
    
    NSString *emailRegex = @"^(?![^0-9]+$)(?![^a-zA-Z]+$).+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

//手机号码正则表达式
+ (BOOL)checkTel:(NSString *)str{
    NSString *regex = @"^13\\d{9}||14\\d{9}||15[0,1,2,3,5,6,7,8,9]\\d{8}||18[0,1,2,3,5,6,7,8,9]\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:str];
}



+ (void)copyDataBaseToSandBox{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    if (![fileManager fileExistsAtPath:[self getDBFilePath]]) {
        
        NSError *error = nil;
        NSString *localPath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
        BOOL isCopySuccess = [fileManager copyItemAtPath:localPath toPath:[self getDBFilePath] error:&error];
        if (isCopySuccess) {
            NSLog(@"文件复制成功");
        }else{
            NSLog(@"文件复制失败");
            return;
        }
    }else{
        NSLog(@"数据库文件已存在");
    }
}

+ (NSString *)getDBFilePath{
    NSString *dbFilePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/dateBase.sqlite"];
    return dbFilePath;
}
//单例模式
+ (FMDatabase *)getDB{
    
    if (!db) {
        db = [[FMDatabase alloc] initWithPath:[self getDBFilePath]];
    }
    return db;
}




+ (NSString *)chineseToSpelling:(NSString *)chinseStr{
    NSMutableString *tempStr = [chinseStr copy];
    
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)tempStr,NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)tempStr,NULL, kCFStringTransformStripDiacritics,NO);
    
    return tempStr;
}
//取得联系人的原始数据
+ (NSArray *)getAddressBookPersonDataInArray{
    ABAddressBookRef addRessBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addRessBook, ^(bool granted,CFErrorRef error){
        
    });
    NSArray *array = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(addRessBook));
    
    return array;
}
//取得联系人的名字，如果是汉字，转为拼音，然后以 pinyin:联系人 的格式保存到字典中
+ (NSDictionary *)getAddressBookPersonDataInDic{

    NSArray *array = [self getAddressBookPersonDataInArray];
    
    NSMutableDictionary *addressDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (int i = 0; i < array.count; i ++) {
        ABRecordRef record = (__bridge ABRecordRef)([array objectAtIndex:i]);
        NSString *name = (__bridge NSString *)(ABRecordCopyCompositeName(record));
        NSString *spellName = [ZYTools chineseToSpelling:name];
        [addressDic setObject:(__bridge id)record forKey:spellName];
    }
    return addressDic;
}
//取出以字典方式保存的联系人，按key进行顺序排序,返回排序后的key的数组
+ (NSArray *)getAddressBookPersonNameInSortedArray{
    NSArray *array = [self getAddressBookPersonDataInArray];
    
    NSMutableDictionary *addressDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    for (int i = 0; i < array.count; i ++) {
        ABRecordRef record = (__bridge ABRecordRef)([array objectAtIndex:i]);
        NSString *name = (__bridge NSString *)(ABRecordCopyCompositeName(record));
        NSString *spellName = [self chineseToSpelling:name];
        
        [addressDic setObject:(__bridge id)record forKey:spellName];
    }
    NSArray *sortedAddressArray = [addressDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    return sortedAddressArray;
    
}
@end
