//
//  ViewController.m
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/10.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNeedsStatusBarAppearanceUpdate];
    self.title = @"Phone";
    [self.navigationController.navigationBar setBarTintColor:[UIColor lightGrayColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    //创建一个高20的假状态栏
         UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
         //设置成绿色
         statusBarView.backgroundColor=[UIColor greenColor];
         // 添加到 navigationBar 上
         [self.navigationController.navigationBar addSubview:statusBarView];
    // Do any additional setup after loading the view, typically from a nib.
}

//-(UIStatusBarStyle)preferredStatusBarStyle{
//
//    return UIStatusBarStyleLightContent;
//
//}

-(void)buttonClicked:(id)sender
{
    NSInteger *name = ((UIButton*)sender).tag;
    _text.text=[_text.text stringByAppendingString:[NSString stringWithFormat:@"%ld",name]];
}

- (void)starClicked:(id)sender
{
    _text.text=[_text.text stringByAppendingString:@"*"];
}

- (void)sharoClicked:(id)sender
{
    _text.text=[_text.text stringByAppendingString:@"#"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dialClicked:(id)sender
{
    _text.text=@"";
}


@end
