//
//  ZYUserTableObj.h
//  PhoneMeeting
//
//  Created by apple on 15/6/8.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZYUserTableObj : NSObject

@property(nonatomic,assign)int  ID;
@property(nonatomic,retain)NSString *userName;
@property(nonatomic,retain)NSString *userPassWord;
@property(nonatomic,retain)NSString *phone;


+ (BOOL)registerUserWithUserName:(NSString *)userName userPassWord:(NSString *)userPassWord phone:(NSString *)phone;

//注册用户
+ (BOOL)registerUserWithUserObj:(ZYUserTableObj *)obj;
//查找用户名是否重复
+ (BOOL)selectUserName:(NSString *)userName;
//根据用户名查找数据
+ (ZYUserTableObj *)getUserObjWithUserName:(NSString *)userName;
//更改密码
+(BOOL)changePassWordWithUserName:(NSString *)userName newPassWord:(NSString *)newPassWord;

@end
