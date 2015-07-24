//
//  ZYUserSettingViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYUserSettingViewController.h"
#import "ZYRegisterViewController.h"
#import "ZYSystemSettingViewController.h"
#import "ZYMoreServiceViewController.h"


@interface ZYUserSettingViewController ()

@end

@implementation ZYUserSettingViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)registerAction:(id)sender {
    ZYRegisterViewController *registerVC = [[ZYRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)settingAction:(id)sender {
    ZYSystemSettingViewController *systemSettingVC = [[ZYSystemSettingViewController alloc] init];
    [self.navigationController pushViewController:systemSettingVC animated:YES];
}

- (IBAction)moreServiceAction:(id)sender {
    ZYMoreServiceViewController *moreServiceVC = [[ZYMoreServiceViewController alloc] init];
    [self.navigationController pushViewController:moreServiceVC animated:YES];
}
@end
