//
//  ContactsDetailScene.m
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/12.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import "ContactsDetailScene.h"
#import "DBManager.h"
#import <Social/Social.h>
@interface ContactsDetailScene ()
{
    Contacts *contact;
    Boolean status;
    DBManager *dbManager;
}
@end

@implementation ContactsDetailScene
@synthesize detailString;

-(void)setContact:(Contacts*)temp{
    if(contact==NULL)
    {
        contact = temp;
    }
}

-(Contacts*)getContact
{
    return contact;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    dbManager = [[DBManager alloc]init];
    [dbManager createDB];
    status = false;
    self.hidesBottomBarWhenPushed=YES;
    self.title = [[contact firstName] stringByAppendingString:[contact lastName]];
    _firstNameText.text =[contact firstName];
    _firstNameText.delegate=self;
    _lastNameText.text=[contact lastName];
    _lastNameText.delegate=self;
    _phoneText.text=[contact phone];
    _phoneText.delegate=self;
    _addressText.text=[contact address];
    _addressText.delegate=self;
    _wechatText.text=[contact wechat];
    _wechatText.delegate=self;
    _emailText.text=[contact email];
    _emailText.delegate=self;
    _firstNameText.enabled=NO;
    _lastNameText.enabled=NO;
    _phoneText.enabled=NO;
    _addressText.enabled=NO;
    _wechatText.enabled=NO;
    _emailText.enabled=NO;
    _confirmButton.hidden=YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editButtonClick:(id)sender
{
    if(status==false)
    {
        _confirmButton.hidden=NO;
        status=true;
        _firstNameText.enabled=YES;
        _lastNameText.enabled=YES;
        _phoneText.enabled=YES;
        _addressText.enabled=YES;
        _wechatText.enabled=YES;
        _emailText.enabled=YES;
    }
}



- (void)deleteButtonClick:(id)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"是否要删除" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         [self->dbManager deleteDataWithfirstName:[self->contact firstName] lastName:[self->contact lastName] phoneNum:[self->contact phone]];
                                                         int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                                                         [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -1)] animated:YES];
                                                     }];
    UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"CANCLE" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                         }];
    [alert addAction:okAction];
    [alert addAction:cancleAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)shareButtonClick:(id)sender
{
    //分享的标题
    NSString *textToShare = [NSString stringWithFormat:@"姓名:%@%@,电话:%@,地址:%@,邮箱:%@,微信号:%@,",[contact firstName],[contact lastName],[contact phone],[contact address],[contact email],[contact wechat]];
    //分享的图片
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare,urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
}

- (void)confirmButtonClick:(id)sender
{

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"是否要修改" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                                 if(self->status==true)
                                                                 {
                                                                     self->status=false;
                                                                     self->_firstNameText.enabled=NO;
                                                                     self->_lastNameText.enabled=NO;
                                                                     self->_phoneText.enabled=NO;
                                                                     self->_addressText.enabled=NO;
                                                                     self->_wechatText.enabled=NO;
                                                                     self->_emailText.enabled=NO;
                                                                 }
                                                             [self->dbManager  updateDataFromFirstName:[self->contact firstName] andLastName:[self->contact lastName] andPhone:[self->contact phone] toFirstName:self->_firstNameText.text toLastName:self->_lastNameText.text toPhone:self->_phoneText.text toAddress:self->_addressText.text toEmail:self->_emailText.text toWechat:self->_wechatText.text];
                                                             int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                                                             [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -1)] animated:YES];
                                                         }];
    UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"CANCLE" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         self->_firstNameText.text =[self->contact firstName];
                                                         self->_lastNameText.text=[self->contact lastName];
                                                         self->_phoneText.text=[self->contact phone];
                                                         self->_addressText.text=[self->contact address];
                                                         self->_wechatText.text=[self->contact wechat];
                                                         self->_emailText.text=[self->contact email];
                                                         if(self->status==true)
                                                         {
                                                             self->status=false;
                                                             self->_firstNameText.enabled=NO;
                                                             self->_lastNameText.enabled=NO;
                                                             self->_phoneText.enabled=NO;
                                                             self->_addressText.enabled=NO;
                                                             self->_wechatText.enabled=NO;
                                                             self->_emailText.enabled=NO;
                                                         }
                                                     }];
    [alert addAction:okAction];
    [alert addAction:cancleAction];
    [self presentViewController:alert animated:YES completion:nil];

}

@end
