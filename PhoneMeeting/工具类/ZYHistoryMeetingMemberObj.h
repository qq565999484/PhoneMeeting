//
//  ZYHistoryMeetingMemberObj.h
//  PhoneMeeting
//
//  Created by apple on 15/6/9.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHistoryMeetingMemberObj : NSObject


@property(nonatomic,assign)int ID;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *phone;
@property(nonatomic,assign)int meetingID;

+ (BOOL)insertIntoAMeetingMember:(ZYHistoryMeetingMemberObj *)obj;
@end
