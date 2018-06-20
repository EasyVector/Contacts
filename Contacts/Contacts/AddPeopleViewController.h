//
//  AddPeopleViewController.h
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/12.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPeopleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *submit;
-(IBAction)submitClick:(id)sender;
@end
