//
//  ZYUserBaseViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/8.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYUserBaseViewController.h"

@interface ZYUserBaseViewController ()

@end

@implementation ZYUserBaseViewController

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
    // Do any additional setup after loading the view.
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImgView.image = [UIImage imageNamed:@"window"];
    [self.view addSubview:bgImgView];
    
    UIImageView *navImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    navImgView.image = [UIImage imageNamed:@"biaotop"];
    [self.view addSubview:navImgView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 5, 70, 34);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"t2"] forState:UIControlStateNormal];
    [self.view addSubview:button];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
