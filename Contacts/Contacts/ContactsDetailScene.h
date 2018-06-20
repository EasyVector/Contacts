//
//  ContactsDetailScene.h
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/12.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacts.h"
@interface ContactsDetailScene : UIViewController
@property (strong, nonatomic) NSString * detailString;
@property (weak, nonatomic) IBOutlet UITextField *firstNameText;
@property (weak, nonatomic) IBOutlet UITextField *lastNameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UINavigationItem *back;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *wechatText;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
-(IBAction)editButtonClick:(id)sender;
-(IBAction)deleteButtonClick:(id)sender;
-(IBAction)shareButtonClick:(id)sender;
-(IBAction)confirmButtonClick:(id)sender;
-(IBAction)backClick:(id)sender;
-(IBAction)unWindToViewController:(UIStoryboardSegue *)segue;
-(void)setContact:(Contacts*)temp;
-(Contacts*)getContact;
@end
