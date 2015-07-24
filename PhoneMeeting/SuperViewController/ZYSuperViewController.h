//
//  ZYSuperViewController.h
//  PhoneMeeting
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYBaseViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ZYHistoryMeetingObj.h"
#import "ZYHistoryMeetingMemberObj.h"
#import "ZYTools.h"

@interface ZYSuperViewController : ZYBaseViewController<ABPeoplePickerNavigationControllerDelegate>{
    NSMutableArray *personArray;
}


@property(nonatomic,retain)UILabel *titleLabel;

- (void)popPeoplePickerViewController;

@end
