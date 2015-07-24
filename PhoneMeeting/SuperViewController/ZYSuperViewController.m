//
//  ZYSuperViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYSuperViewController.h"

@interface ZYSuperViewController (){
    
}

@end

@implementation ZYSuperViewController

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
    
    //注册键盘弹出和隐藏事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.view.userInteractionEnabled = YES;
    
    UIImageView *navImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 64)];
    navImgView.image = [UIImage imageNamed:@"biaotop"];
    [self.view addSubview:navImgView];
    [navImgView release];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 24, 100, 40);
    [backButton setBackgroundImage:[UIImage imageNamed:@"logo"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(162, 20, 700, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:28];
    
    [self.view addSubview:_titleLabel];
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
//    self.navigationController.navigationItem.leftBarButtonItem = leftItem;
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//模态弹出通讯录界面
- (void)popPeoplePickerViewController{
    ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    peoplePicker.peoplePickerDelegate = self;
    [self presentViewController:peoplePicker animated:YES completion:nil];
}
#pragma mark ABPeoplePickerViewControllerDelegate
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    NSLog(@"shouldContinueAfterSelectingPerson");
    return YES;
}

/*
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    NSLog(@"shouldContinueAfterSelectingPerson2222");
    
    return YES;
}
*/
- (void)keyboardWillShow:(NSNotification *)notification{
    NSLog(@"键盘弹出");
}
- (void)keyboardWillHide:(NSNotification *)notification{
    NSLog(@"键盘隐藏");
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
