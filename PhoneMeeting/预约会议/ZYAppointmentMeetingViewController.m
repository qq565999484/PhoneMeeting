//
//  ZYAppointmentMeetingViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYAppointmentMeetingViewController.h"
#import "ZYAppointSettingViewController.h"
#import "ZYPersonObj.h"
@interface ZYAppointmentMeetingViewController (){
    NSString *meetingTheme;
    NSString *meetingPresenter;
    BOOL isEditing;

}
@property (retain, nonatomic) IBOutlet UIView *tfBgView;
@property (retain, nonatomic) IBOutlet UITableView *myTable;
@property (retain, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ZYAppointmentMeetingViewController

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
    self.titleLabel.text = @"预约会议";

    meetingTheme = @"";
    meetingPresenter = @"";
    if (!personArray) {
        personArray = [[NSMutableArray alloc] init];
    }

    
}
#pragma mark UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"====delete");
        [personArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return personArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentity] autorelease];
    }
    
    ZYPersonObj *p = [personArray objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = p.name;
    cell.detailTextLabel.text = p.phone;
    return cell;
}

#pragma mark ABPeoplePickerNavigationController
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    NSLog(@"shouldContinueAfterSelectingPerson");
    NSString *name = (NSString *)ABRecordCopyCompositeName(person);
    
    ABMultiValueRef multiValue = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSString *phoneNum = ABMultiValueCopyValueAtIndex(multiValue, 0);
    
    
    BOOL isContains = NO;
    
    for (int i = 0; i < personArray.count; i ++) {
        ZYPersonObj *p = [personArray objectAtIndex:i];
        
        if ([name isEqualToString:p.name]) {
            isContains = YES;
            break;
        }
    }
    
    
    if (isContains) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该号码已选择过,请选择其它号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }else{
        [peoplePicker dismissViewControllerAnimated:YES completion:^{
            ZYPersonObj *p = [[ZYPersonObj alloc] init];
            p.name = name;
            p.phone = phoneNum;
            
            [personArray addObject:p];
            [_myTable reloadData];
        }];
    }
    
    return NO;
}


- (void)keyboardWillShow:(NSNotification *)notification{
    
    NSLog(@"子类事件");
    [UIView animateWithDuration:0.32 animations:^{
        _tfBgView.frame = CGRectMake(0, 328, 1024, 88);
    }];
}
- (void)keyboardWillHide:(NSNotification *)notification{
    NSLog(@"子类事件");
    [UIView animateWithDuration:0.28 animations:^{
        _tfBgView.frame = CGRectMake(0, 680, 1024, 88);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tfBgView release];
    [_myTable release];
    [super dealloc];
}
- (IBAction)buttonAction:(id)sender {
    UIButton *clickedButton = (UIButton *)sender;
    if (clickedButton.tag == 1000) {
        
    }else if (clickedButton.tag == 1001){
        
        ZYAppointSettingViewController *vc = [[ZYAppointSettingViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
        
    }else if (clickedButton.tag == 1002){
        
        isEditing = !isEditing;
        [self.myTable setEditing:isEditing animated:YES];
        
    }else if (clickedButton.tag == 1003){
        [self popPeoplePickerViewController];
    }else{
        
    }
}

- (IBAction)enterAction:(id)sender {
    if ([ZYTools checkTel:self.tf.text]) {
        ZYPersonObj *p = [[ZYPersonObj alloc] init];
        
        p.name = @"匿名";
        p.phone = self.tf.text;
        [personArray addObject:p];
        
        [self.myTable reloadData];
        
        self.tf.text = @"";
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入的手机号码格式不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }

}
@end
