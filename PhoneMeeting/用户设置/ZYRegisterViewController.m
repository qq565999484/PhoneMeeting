//
//  ZYRegisterViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/8.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYRegisterViewController.h"
#import "ZYTools.h"
#import "ZYUserTableObj.h"

@interface ZYRegisterViewController ()
@property (retain, nonatomic) IBOutlet UITextField *userNameTF;
@property (retain, nonatomic) IBOutlet UITextField *passWordTF;
@property (retain, nonatomic) IBOutlet UITextField *confirmPassWordTF;
@property (retain, nonatomic) IBOutlet UITextField *phoneNumberTF;


@end

@implementation ZYRegisterViewController

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

- (void)dealloc {
    [_userNameTF release];
    [_passWordTF release];
    [_confirmPassWordTF release];
    [_phoneNumberTF release];
    [super dealloc];
}
- (IBAction)commitRegisterAction:(id)sender {
    if (![self.userNameTF.text isEqualToString:@""] && ![self.passWordTF.text isEqualToString:@""] && ![self.confirmPassWordTF.text isEqualToString:@""] && ![self.phoneNumberTF.text isEqualToString:@""] && [self.passWordTF.text isEqualToString:self.confirmPassWordTF.text]) {
        
        
        //判断用户名是否唯一
        BOOL isUniqueness = [ZYUserTableObj selectUserName:self.userNameTF.text];
        if (!isUniqueness) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名重复,请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return;
        }
        
        //判断输入的手机号码格式是否正确
        BOOL isPhone = [ZYTools checkTel:self.phoneNumberTF.text];
        if (!isPhone) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入的手机号码格式不正确,请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return;
        }
        
        
        BOOL isRegister = [ZYUserTableObj registerUserWithUserName:self.userNameTF.text userPassWord:self.passWordTF.text phone:self.phoneNumberTF.text];
        if (isRegister) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
}

- (BOOL)userNameisUniqueness{
    return YES;
}

- (IBAction)helpAction:(id)sender {
}
@end
