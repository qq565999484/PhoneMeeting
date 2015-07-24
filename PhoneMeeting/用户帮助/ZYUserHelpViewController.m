//
//  ZYUserHelpViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYUserHelpViewController.h"

@interface ZYUserHelpViewController ()

@end

@implementation ZYUserHelpViewController

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
        self.titleLabel.text = @"用户帮助";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
