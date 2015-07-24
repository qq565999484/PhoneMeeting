//
//  ZYAppointSettingViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/9.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYAppointSettingViewController.h"

@interface ZYAppointSettingViewController ()
@property (retain, nonatomic) IBOutlet UITextField *presenterTF;
@property (retain, nonatomic) IBOutlet UITextField *themeTF;
@property (retain, nonatomic) IBOutlet UIDatePicker *datePicker;//378 286 274 216
@property (retain, nonatomic) IBOutlet UIDatePicker *timePicker;

@end

@implementation ZYAppointSettingViewController

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

- (IBAction)dateAction:(id)sender {
    [UIView animateWithDuration:0.1 animations:^{
        self.timePicker.frame = CGRectMake(1298, 286, 274, 216);
    }];
    
    [UIView animateWithDuration:1 animations:^{
        
        self.datePicker.frame = CGRectMake(378, 286, 274, 216);
    }];
    
}

- (IBAction)timeAction:(id)sender {
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.datePicker.frame = CGRectMake(-274, 286, 274, 216);
    }];
    [UIView animateWithDuration:1 animations:^{
        self.timePicker.frame = CGRectMake(378, 286, 274, 216);
    }];
    
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirmAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc {
    [_presenterTF release];
    [_themeTF release];
    [_datePicker release];
    [_timePicker release];
    [super dealloc];
}
@end
