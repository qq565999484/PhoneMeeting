//
//  ZYMoreServiceViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/8.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYMoreServiceViewController.h"

@interface ZYMoreServiceViewController ()
@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation ZYMoreServiceViewController

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

- (IBAction)segmentClicked:(id)sender {
    
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSLog(@"===%ld",segment.selectedSegmentIndex);
    switch (segment.selectedSegmentIndex) {
        case 0:
            self.textView.text = @"UMeeting电话会议以系统外呼式为主的新型电话会议平台，针对IPHONE,IPAD尊贵用户定制开发，所有参会方均可以作为被叫方，最大限度提高会议便利性。系统采用电信级线路，多人参议会议语音自然清晰、话路稳定。客服热线4006901066";
            break;
        case 1:
            self.textView.text = @"24小时客服4006901066，咨询仅收取正常通话费（话费由通讯服务商收取，本服务不收取任何费用）";
            break;
        case 2:
            self.textView.text = @"";
            [self startAnimation];
            break;
        default:
            break;
    }
}

- (void)startAnimation{
    [self.indicator startAnimating];
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:3];
}
- (void)stopAnimation{
    [self.indicator stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经是最新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
- (void)dealloc {
    [_textView release];
    [_indicator release];
    [super dealloc];
}
@end
