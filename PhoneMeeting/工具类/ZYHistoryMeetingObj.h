//
//  ZYHistoryMeetingObj.h
//  PhoneMeeting
//
//  Created by apple on 15/6/9.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHistoryMeetingObj : NSObject


@property(nonatomic,assign)int  ID;
@property(nonatomic,copy)NSString *theme;
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *presenter;

+ (BOOL)insertIntoAMeeting:(ZYHistoryMeetingObj *)obj;
+ (int)getLastID;
@end
