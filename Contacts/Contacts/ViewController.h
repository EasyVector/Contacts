//
//  ViewController.h
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/10.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *zero;
@property (weak, nonatomic) IBOutlet UIButton *dial;
@property (weak, nonatomic) IBOutlet UIButton *star;
@property (weak, nonatomic) IBOutlet UIButton *sharo;
@property (weak, nonatomic) IBOutlet UIButton *one;
@property (weak, nonatomic) IBOutlet UIButton *two;
@property (weak, nonatomic) IBOutlet UIButton *three;
@property (weak, nonatomic) IBOutlet UIButton *four;
@property (weak, nonatomic) IBOutlet UIButton *five;
@property (weak, nonatomic) IBOutlet UIButton *six;
@property (weak, nonatomic) IBOutlet UIButton *seven;
@property (weak, nonatomic) IBOutlet UIButton *eight;
@property (weak, nonatomic) IBOutlet UIButton *nine;
-(IBAction)buttonClicked:(id)sender;
-(IBAction)starClicked:(id)sender;
-(IBAction)sharoClicked:(id)sender;
-(IBAction)dialClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *text;



@end

