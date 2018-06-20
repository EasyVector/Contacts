//
//  AddPeopleViewController.m
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/12.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import "AddPeopleViewController.h"
#import "BaseClass/TextCell.h"
#import "BaseClass/IndexPath.h"
#import "DBManager.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface AddPeopleViewController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverControllerDelegate>

@property (nonatomic , strong)NSArray *titleArray;
@property (nonatomic , strong)NSMutableArray *arrayDataSouce;
@property (nonatomic , strong)UITableView *tableView;
@end

@implementation AddPeopleViewController
{
    NSMutableArray *text;
    DBManager *dbManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dbManager = [[DBManager alloc] init];
    [dbManager createDB];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    text = _arrayDataSouce;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES]; //实现该方法是需要注意view需要是继承UIControl而来的
    [self.tableView endEditing:YES];
}

#pragma mark - notification

- (void)textFieldDidChanged:(NSNotification *)noti{
    // 数据源赋值
    UITextField *textField=noti.object;
    [text addObject:textField];
    NSIndexPath *indexPath = textField.indexPath;
    [self.arrayDataSouce replaceObjectAtIndex:indexPath.row withObject:textField.text];
    
}

#pragma marks - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayDataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Id = @"HTextViewCell";
    TextCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[TextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    // 核心方法
    [cell setTitleString:self.titleArray[indexPath.row] andDataString:self.arrayDataSouce[indexPath.row] andIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - private

- (void)scrollTap:(id)sender {
    
    [self.view endEditing:YES];
    
}

#pragma marks- lazy

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];

    }
    return _tableView;
}

- (NSMutableArray *)arrayDataSouce{
    if (!_arrayDataSouce) {
        _arrayDataSouce = [NSMutableArray array];
        [_arrayDataSouce addObject:@""];
        [_arrayDataSouce addObject:@""];
        [_arrayDataSouce addObject:@""];
        [_arrayDataSouce addObject:@""];
        [_arrayDataSouce addObject:@""];
        [_arrayDataSouce addObject:@""];
    }
    return _arrayDataSouce;
}

- (void)submitClick:(id)sender
{
    NSString *firstName =[text objectAtIndex:0];
    NSString *lastName = [text objectAtIndex:1];
    NSString *phone = [text objectAtIndex:2];
    NSString *address = [text objectAtIndex:3];
    NSString *wechat = [text objectAtIndex:4];
    NSString *email = [text objectAtIndex:5];
   if([firstName isEqualToString:@""]&&[lastName isEqualToString:@""]&&[phone isEqualToString:@""])
   {
       UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"失败" message:@"信息不完整，请完整输入姓名和号码" preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            //响应事件
                                                            //得到文本信息
                                                            for(UITextField *text in alert.textFields){
                                                                NSLog(@"text = %@", text.text);
                                                            }
                                                        }];
       [alert addAction:okAction];
       [self presentViewController:alert animated:YES completion:nil];
   }else{
       [dbManager saveDataWithfirstName:firstName lastName:lastName phoneNum:phone address:address email:email wechat:wechat];
       int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
       [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -1)] animated:YES];
   }
}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"姓：",@"名：", @"号码：", @"住址：",@"微信号：", @"邮箱："];
    }
    return _titleArray;
}


@end
