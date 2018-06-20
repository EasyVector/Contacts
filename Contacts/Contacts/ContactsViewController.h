//
//  ContactsViewController.h
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/11.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)   IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *add;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *names;
@property (nonatomic, strong) NSMutableArray *itemNumber;
@property (nonatomic, strong) UISearchController *searchController;
@property(assign,nonatomic)BOOL isSearch; 
@end
