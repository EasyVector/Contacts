//
//  ContactsViewController.m
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/11.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import "ContactsViewController.h"
#import "UITableView+ZYXIndexTip.h"
#import "ContactsDetailScene.h"
#import "DBManager.h"
#import "Contacts.h"
@interface ContactsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, UISearchBarDelegate, UISearchDisplayDelegate,UISearchResultsUpdating>
{
    NSArray *sectionTitlesTemp; // 每个分区的标题
    NSMutableArray *sectionTitles; // 每个分区的标题
    NSMutableArray *contentsArray; // 每行的内容
    UITableViewController *tableController;
    NSMutableArray *contacts;
    DBManager *dbManager;
    Boolean status;
    
}
@end

@implementation ContactsViewController
@synthesize add;
@synthesize tableView;
- (void)viewDidLoad {
    status = true;
    [super viewDidLoad];
    dbManager = [[DBManager alloc]init];
    [dbManager createDB];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.userInteractionEnabled = YES;
    self.tableView.tableHeaderView = [[UIView alloc]init];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionIndexColor = [UIColor colorWithRed:25/225.0 green:129/255.0 blue:251/255.0 alpha:1];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableViewController *subVC1 = [[UITableViewController alloc]init];
    [self addChildViewController:subVC1];
    [subVC1 setTableView:self.tableView];
    [self.view addSubview:self.tableView];
    tableController = subVC1;
    self.navigationItem.leftBarButtonItem =add;
    _isSearch = NO;
    self.searchBar.backgroundColor=[UIColor whiteColor];
    
    
//    [self.searchBar sizeToFit];
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return self.searchController.searchBar;
//}

- (void)viewDidAppear:(BOOL)animated
{
//    sectionTitles=NULL;
//    contentsArray=NULL;
//    [self.tableView reloadData];
    if(_isSearch)
    {
        self.searchBar.text=@"";
        [self.searchBar resignFirstResponder];
    }
    contacts = [dbManager findAll];
    self.title = @"Contacts";
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f,0.0f, 0.0f);
    sectionTitles = [[NSMutableArray alloc]init];
    contentsArray = [[NSMutableArray alloc]init];
    sectionTitlesTemp       = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"#", nil];
    for (int i = 0; i<[sectionTitlesTemp count]; i++) {
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        for(int j = 0; j<[contacts count]; j++)
        {
            Contacts * person = (Contacts *)[contacts objectAtIndex:j];
            if([[person index] isEqualToString:[sectionTitlesTemp objectAtIndex:i]])
            {
                [temp addObject:person];
            }
        }
        if([temp count]>0)
        {
            [sectionTitles addObject:[sectionTitlesTemp objectAtIndex:i]];
            [contentsArray addObject:temp];
        }
    }
    [self.tableView reloadData];
    [self.tableView addIndexTip];

//    [self.searchBar sizeToFit];
}



// 开始搜索时向上移动searchBar
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    [UIView animateWithDuration:0.25 animations:^{
        controller.searchBar.frame = CGRectMake(0.f, 20.f, 375, 44);
    }];
    _isSearch = YES;
}
// 结束搜索时向下移动searchBar
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{
    [UIView animateWithDuration:0.25 animations:^{
        controller.searchBar.frame = CGRectMake(0.f, 64.f, 375, 44);
    }];
    [self viewDidAppear:YES];
    _isSearch=NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ShowContactDetail"])
    {
        NSIndexPath *path =  [self.tableView indexPathForSelectedRow];
        Contacts *title= contentsArray[path.section][path.row];
        [[segue destinationViewController] setContact:title];
        [segue destinationViewController].hidesBottomBarWhenPushed = YES;
    }
    if([[segue identifier] isEqualToString:@"AddContact"])
    {
        [segue destinationViewController].hidesBottomBarWhenPushed = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[[contentsArray[indexPath.section][indexPath.row] firstName] stringByAppendingString:@" "] stringByAppendingString:[contentsArray[indexPath.section][indexPath.row] lastName]];
    return cell;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(_isSearch==NO)
        return sectionTitles;
    else
        return nil;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionTitles[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [contentsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contentsArray[section] count];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *tstring = searchBar.text;
    sectionTitles = [[NSMutableArray alloc]init];
    contentsArray = [[NSMutableArray alloc]init];
    if([tstring length]>0)
    {
        sectionTitlesTemp = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#", nil];
        for (int i = 0; i<[sectionTitlesTemp count]; i++) {
            NSMutableArray *temp = [[NSMutableArray alloc]init];
            for(int j = 0; j<[contacts count]; j++)
            {
                Contacts * person = (Contacts *)[contacts objectAtIndex:j];
                if([[person index] isEqualToString:[sectionTitlesTemp objectAtIndex:i]]&&[[[person firstName] stringByAppendingString:[person lastName]] containsString:tstring])
                {
                    [temp addObject:person];
                }
            }
            if([temp count]>0)
            {
                [sectionTitles addObject:[sectionTitlesTemp objectAtIndex:i]];
                [contentsArray addObject:temp];
            }
        }
        [self.tableView reloadData];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_isSearch)
    {
        Contacts *title= contentsArray[indexPath.section][indexPath.row];
        ContactsDetailScene *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"purposeDestination"];
        [detail setContact:title];
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

//- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
//{
//    if([identifier isEqualToString:@"ShowChecklist"])
//    {
//
//    }
//}



@end
