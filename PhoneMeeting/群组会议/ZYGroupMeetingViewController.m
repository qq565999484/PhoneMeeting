//
//  ZYGroupMeetingViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYGroupMeetingViewController.h"

@interface ZYGroupMeetingViewController ()

@end

@implementation ZYGroupMeetingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        self.titleLabel.text = @"群组会议";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
