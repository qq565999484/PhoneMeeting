//
//  ZYHomeViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYHomeViewController.h"

#import "ZYImmediatelyMeetingViewController.h"
#import "ZYAppointmentMeetingViewController.h"
#import "ZYGroupMeetingViewController.h"
#import "ZYHistoryMeetingViewController.h"
#import "ZYUserHelpViewController.h"
#import "ZYUserSettingViewController.h"

@interface ZYHomeViewController (){
    UIButton *logoBtn;
    BOOL isLogoBtnCenter;
    UINavigationController *nav;
}
@property (retain, nonatomic) IBOutlet UIImageView *coveredImgView;
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet UIView *settingView;


@end

@implementation ZYHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"");
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

    
    logoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoBtn.frame = CGRectMake(349, 324, 326, 120);
    logoBtn.userInteractionEnabled = NO;
    [logoBtn setBackgroundImage:[UIImage imageNamed:@"logo2"] forState:UIControlStateNormal];
    [logoBtn addTarget:self action:@selector(logoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoBtn];
    
    [self loadTheSettingView];
    
    [self performSelector:@selector(beginAnimations) withObject:nil afterDelay:2];
}
- (void)loadTheSettingView{
    ZYUserSettingViewController *userSettingVC = [[ZYUserSettingViewController alloc] init];
    
    nav = [[UINavigationController alloc] initWithRootViewController:userSettingVC];
    
    nav.view.frame = CGRectMake(312, -500, 400, 500);
    nav.navigationBarHidden = YES;
    [self.view addSubview:nav.view];
    
}
- (void)beginAnimations{
   
    [UIView animateWithDuration:3 animations:^{
        _topView.frame = CGRectMake(0, 0, 1024, 407);
        _coveredImgView.alpha = 0;
        logoBtn.frame = CGRectMake(349, 80, 326, 120);
    }];

}
- (IBAction)buttonAction:(id)sender {
    UIButton *clickedButton = (UIButton *)sender;
    
    if (clickedButton.tag == 1000) {
        ZYImmediatelyMeetingViewController *vc = [[ZYImmediatelyMeetingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }else if (clickedButton.tag == 1001){
        ZYAppointmentMeetingViewController *vc = [[ZYAppointmentMeetingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }else if (clickedButton.tag == 1002){
        ZYGroupMeetingViewController *vc = [[ZYGroupMeetingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }else if (clickedButton.tag == 1003){
        ZYHistoryMeetingViewController *vc = [[ZYHistoryMeetingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }else if(clickedButton.tag == 1004){
        ZYUserHelpViewController *vc = [[ZYUserHelpViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }else{
        
        
        
        [UIView animateWithDuration:3 animations:^{
            logoBtn.frame = CGRectMake(10, 20, 100,35);
            _topView.frame = CGRectMake(0, -407, 1024, 407);
            nav.view.frame = CGRectMake(312, 84, 400, 500);
        }completion:^(BOOL finished){
            logoBtn.userInteractionEnabled = YES;
        }];
    }
}

- (void)logoButtonAction{
//    if (isLogoBtnCenter) {
    [UIView animateWithDuration:3 animations:^{
        logoBtn.frame = CGRectMake(349, 80, 326, 120);
        _topView.frame = CGRectMake(0, 0, 1024, 407);
        nav.view.frame = CGRectMake(312, 768, 400, 500);

    }completion:^(BOOL finished){
        logoBtn.userInteractionEnabled = NO;
        nav.view.frame = CGRectMake(312, -500, 400, 500);
    }];
}

- (void)logoButtonGoToTheCorner{
    [UIView animateWithDuration:3 animations:^{
        logoBtn.frame = CGRectMake(10, 20, 100,35);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_coveredImgView release];
    [_topView release];
    [_settingView release];
    [super dealloc];
}
@end
