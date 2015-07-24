//
//  ZYImmediatelyMeetingViewController.m
//  PhoneMeeting
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 ZhiYou. All rights reserved.
//

#import "ZYImmediatelyMeetingViewController.h"
#import "ZYPersonObj.h"

@interface ZYImmediatelyMeetingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    NSString *meetingTheme;
    NSString *meetingPresenter;
    BOOL isEditing;
}
@property (retain, nonatomic) IBOutlet UIView *tfBgView;
@property (retain, nonatomic) IBOutlet UITextField *tf;
@property (retain, nonatomic) IBOutlet UITableView *myTable;

@end

@implementation ZYImmediatelyMeetingViewController

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
    
    self.titleLabel.text = @"即时会议";
    
    meetingTheme = @"";
    meetingPresenter = @"";
    if (!personArray) {
        personArray = [[NSMutableArray alloc] init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//IPAD键盘高度:
//
//portrait  264
//
//landscape  352.
//
//iPhone键盘高度:
//Portrait  216
//Landscape  140

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
- (void)dealloc {
    [_tfBgView release];
    [_tf release];
    [_myTable release];
    [super dealloc];
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
#pragma mark ABPeoplePickerViewControllerDelegate
//- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
//    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//}
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
/*
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    int ID = ABRecordGetRecordID(person);
    
    NSLog(@"shouldContinueAfterSelectingPerson2222");
    NSLog(@"ID=====%d",ID);
    
    return NO;
}
*/


#pragma mark 按钮事件
- (IBAction)buttonAction:(id)sender {
    
    UIButton *clickedBtn = (UIButton *)sender;
    
    if (clickedBtn.tag == 1000) {
        if (personArray.count > 0) {
            NSDate *date = [NSDate date];
            //精确到秒
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"YYYYMMDDHHmmss"];
            NSString *dateStr = [formatter stringFromDate:date];
            
            ZYHistoryMeetingObj *obj = [[ZYHistoryMeetingObj alloc] init];

            obj.theme = meetingTheme;
            obj.presenter = meetingPresenter;
            obj.date = dateStr;
            
            
            
            
            BOOL isSuccess = [ZYHistoryMeetingObj insertIntoAMeeting:obj];
            
            
            
            
            
            if (isSuccess) {
                
                int ID = [ZYHistoryMeetingObj getLastID];
                for (ZYPersonObj *p in personArray) {
                    ZYHistoryMeetingMemberObj *obj = [[ZYHistoryMeetingMemberObj alloc] init];
                    obj.name = p.name;
                    obj.phone = p.phone;
                    obj.meetingID = ID;
                    [ZYHistoryMeetingMemberObj insertIntoAMeetingMember:obj];
                }
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"会议开始成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"会议开始失败,请稍后重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先输入参会号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        

        
    }else if (clickedBtn.tag == 1001){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请设置会议主题" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        //设置提示框为带输入框的格式
        [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        [alert show];
        [alert release];
        
        
        //设置输入框属性
        
        UITextField *presenterTF = [alert textFieldAtIndex:0];
        presenterTF.placeholder = @"主持人号码";
        presenterTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        if (meetingTheme) {
            presenterTF.text = meetingPresenter;
        }
        
        UITextField *themeTF = [alert textFieldAtIndex:1];
        themeTF.placeholder = @"会议主题";
        themeTF.secureTextEntry = NO;
        themeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        if (meetingTheme) {
            themeTF.text = meetingTheme;
        }
        
      

        
    }else if(clickedBtn.tag == 1002){
        
        isEditing = !isEditing;

        
        [self.myTable setEditing:isEditing animated:YES];
        
    }else if (clickedBtn.tag == 1003) {
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
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        UITextField *presenterTF = [alertView textFieldAtIndex:0];
        meetingPresenter = [presenterTF.text copy];
        
        
        
        UITextField *themeTF = [alertView textFieldAtIndex:1];
        meetingTheme = [themeTF.text copy];
        
//        NSLog(@"=====%@",meetingPresenter);
//         NSLog(@"=====%@",meetingTheme);
    }
}
@end
