//
//  ZYSystemSettingViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/8.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYSystemSettingViewController.h"
#import "ZYUserTableObj.h"

@interface ZYSystemSettingViewController (){
    
    UIButton *lastCiickedButton;
    UIView *lastAddView;
}

@property (retain, nonatomic) IBOutlet UIView *rightView;


@property (retain, nonatomic) IBOutlet UIView *loginView;
@property (retain, nonatomic) IBOutlet UIView *findPswView;
@property (retain, nonatomic) IBOutlet UIView *changePswView;
@property (retain, nonatomic) IBOutlet UIView *setPresenterView;
@property (retain, nonatomic) IBOutlet UIView *helpView;

//登陆视图
@property (retain, nonatomic) IBOutlet UITextField *userNameTF;
@property (retain, nonatomic) IBOutlet UITextField *passWordTf;
//找回密码视图
@property (retain, nonatomic) IBOutlet UITextField *userNameTF2;
@property (retain, nonatomic) IBOutlet UITextField *phoneTF2;
//更改密码
@property (retain, nonatomic) IBOutlet UITextField *userNameTF3;
@property (retain, nonatomic) IBOutlet UITextField *passWordTF3;
@property (retain, nonatomic) IBOutlet UITextField *newPassWordTF3;
@property (retain, nonatomic) IBOutlet UITextField *repeatNewPswTF3;



//设置主持人
@property (retain, nonatomic) IBOutlet UITextField *presenterTF;
@property (retain, nonatomic) IBOutlet UISwitch *recordSwitch;

//帮助
@property (retain, nonatomic) IBOutlet UITextView *helpTextView;

@end

@implementation ZYSystemSettingViewController

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
    
    [self.rightView addSubview:self.loginView];
    
    
    //如果可以去到账户密码的值，直接显示登陆后的界面
    
    //没有取到账户密码
    lastAddView = self.loginView;
    lastCiickedButton = (UIButton *)[self.view viewWithTag:1000];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_loginView release];
    [_findPswView release];
    [_changePswView release];
    [_setPresenterView release];
    [_helpView release];
    [_rightView release];
    [_userNameTF release];
    [_passWordTf release];
    [_userNameTF2 release];
    [_phoneTF2 release];
    [_userNameTF3 release];
    [_passWordTF3 release];
    [_newPassWordTF3 release];
    [_repeatNewPswTF3 release];
    [_presenterTF release];
    [_recordSwitch release];
    [_helpTextView release];
    [super dealloc];
}
- (IBAction)buttonAction:(id)sender {
    
    UIButton *clickedButton = (UIButton *)sender;
    
    if (lastCiickedButton.tag == clickedButton.tag) {
        return;
    }
    lastCiickedButton = clickedButton;

    [lastAddView removeFromSuperview];
    if (clickedButton.tag == 1000) {
        lastAddView = self.loginView;
    }else if (clickedButton.tag == 1001){
        lastAddView = self.findPswView;
    }else if (clickedButton.tag == 1002){
        lastAddView = self.changePswView;
    }else if (clickedButton.tag == 1003){
        lastAddView = self.setPresenterView;
    }else{
        lastAddView = self.helpView;
    }
    [self.rightView addSubview:lastAddView];
}

- (IBAction)loginAction:(id)sender {
    
//    zyus[];
    ZYUserTableObj *obj = [ZYUserTableObj getUserObjWithUserName:self.userNameTF.text];
    if (obj && [obj.userPassWord isEqualToString:self.passWordTf.text]) {
        
        //这里就是登陆成功了。
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        
        [defaults setObject:self.userNameTF.text forKey:@"userName"];
        [defaults setObject:self.passWordTf.text forKey:@"passWord"];
        
        
    }
}

- (IBAction)findPassWordAction:(id)sender {
    ZYUserTableObj *obj = [ZYUserTableObj getUserObjWithUserName:self.userNameTF2.text];
    if (obj && [obj.phone isEqualToString:self.phoneTF2.text]) {
        
        //这里就是登陆成功了。
        NSString *message = [NSString stringWithFormat:@"找回密码成功!\n你的密码为%@",obj.userPassWord];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

- (IBAction)changePassWordAction:(id)sender {
    //先判断两个新密码是否一致
    if ([self.newPassWordTF3.text isEqualToString:self.repeatNewPswTF3.text]) {
        ZYUserTableObj *obj = [ZYUserTableObj getUserObjWithUserName:self.userNameTF3.text];

        //判断旧密码是否正确
        if (obj && [obj.userPassWord isEqualToString:self.passWordTF3.text]) {
            BOOL isSuccess = [ZYUserTableObj changePassWordWithUserName:self.userNameTF3.text newPassWord:self.newPassWordTF3.text];
            if (isSuccess) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码更改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];

            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"旧密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次输入的新密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];

    }
    
    
}

- (IBAction)setPresenterAction:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.presenterTF.text  forKey:@"presenter"];
    [defaults setObject:[NSNumber numberWithBool:self.recordSwitch.isOn] forKey:@"record"];
}
@end
