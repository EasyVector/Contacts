//
//  DBManager.m
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/17.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import "DBManager.h"
#import "Contacts.h"
#import "NameIndex.h"
static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"sqlitetest.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "create table if not exists contacts (firstName varchar(50) NOT NULL,lastName char(128) NOT NULL,phoneNum char(128) NOT NULL,address char(128),email char(128),wechat char(128),PRIMARY KEY(firstName, lastName, phoneNum));";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

- (BOOL) saveDataWithfirstName:(NSString*)firstName lastName:(NSString*)lastName
       phoneNum:(NSString*)phoneNum address:(NSString*)address email:(NSString*)email wechat:(NSString*)wechat
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into contacts (firstName,lastName,    phoneNum, address, email, wechat) values (\"%@\",\"%@\", \"%@\", \"%@\",\"%@\",\"%@\")",firstName, lastName, phoneNum, address, email, wechat];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
    }
    return NO;
}

- (BOOL) deleteDataWithfirstName:(NSString*)firstName lastName:(NSString*)lastName
                      phoneNum:(NSString*)phoneNum
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"delete from contacts Where firstName=\"%@\" and lastname=\"%@\" and phoneNum=\"%@\"",firstName, lastName, phoneNum];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
    }
    return NO;
}
                                
                                
- (NSMutableArray*) findByFirstName:(NSString*)firstName lastName:(NSString*)lastName phoneNum:(NSString*)phoneNum
{
     const char *dbpath = [databasePath UTF8String];
     if (sqlite3_open(dbpath, &database) == SQLITE_OK)
     {
         NSString *querySQL = [NSString stringWithFormat:
                               @"select firstName,lastName, phoneNum, address, email, wechat from contacts where firstName=\"%@\" and lastName=\"%@\" and phoneNum =\"%@\" ",firstName, lastName, phoneNum];
         const char *query_stmt = [querySQL UTF8String];
         NSMutableArray *resultArray = [[NSMutableArray alloc]init];
         if (sqlite3_prepare_v2(database,
                                query_stmt, -1, &statement, NULL) == SQLITE_OK)
         {
             while (sqlite3_step(statement) == SQLITE_ROW)
             {
                 NSString *firstName = [[NSString alloc] initWithUTF8String:
                                   (const char *) sqlite3_column_text(statement, 0)];
                 [resultArray addObject:firstName];
                 
                 NSString *lastName = [[NSString alloc] initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 1)];
                 [resultArray addObject:lastName];
                 
                 NSString *phoneNum = [[NSString alloc] initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 2)];
                 [resultArray addObject:phoneNum];
                 
                 NSString *address = [[NSString alloc] initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 3)];
                 [resultArray addObject:address];
                 
                 NSString *email = [[NSString alloc] initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 4)];
                 [resultArray addObject:email];
                 
                 NSString *wechat = [[NSString alloc]initWithUTF8String:
                                   (const char *) sqlite3_column_text(statement, 5)];
                 [resultArray addObject:wechat];
                 return resultArray;
             }
         }
     }
     return nil;
}

- (NSMutableArray*) findAll
{
    const char *dbpath = [databasePath UTF8String];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NameIndex *nameIndex = [[NameIndex alloc]init];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"select firstName,lastName, phoneNum, address, email, wechat from contacts"];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Contacts *contact  = [[Contacts alloc]init];
                NSString *firstName = [[NSString alloc] initWithUTF8String:
                                       (const char *) sqlite3_column_text(statement, 0)];
                [contact setFirstName:firstName];
                [resultArray addObject:firstName];
                [contact setIndex:[nameIndex getFirstName:firstName]];
                [contact setIndex:[nameIndex getFirstName:firstName]];
                NSString *lastName = [[NSString alloc] initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:lastName];
                [contact setLastName:lastName];
                NSString *phoneNum = [[NSString alloc] initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:phoneNum];
                [contact setPhone:phoneNum];
                NSString *address = [[NSString alloc] initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 3)];
                [resultArray addObject:address];
                [contact setAddress:address];
                NSString *email = [[NSString alloc] initWithUTF8String:
                                   (const char *) sqlite3_column_text(statement, 4)];
                [resultArray addObject:email];
                [contact setEmail:email];
                NSString *wechat = [[NSString alloc]initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 5)];
                [resultArray addObject:wechat];
                [contact setWechat:wechat];
                [array addObject:contact];
            }
        }
    }
    return array;
}


- (int)updateDataFromFirstName:(NSString*)firstName andLastName:(NSString*)lastName andPhone:(NSString*)phone toFirstName:(NSString*)newFirstName toLastName:(NSString*)newLastName toPhone:(NSString*)newPhone toAddress:(NSString*)newAddress toEmail:(NSString*)newEmail toWechat:(NSString*)newWechat{
    NSString * sql1 = @"update contacts set  ";
    NSString * sql2 = [NSString stringWithFormat:@"firstName=\"%@\",",newFirstName];
    NSString * sql3 = [NSString stringWithFormat:@"lastName=\"%@\",",newLastName];
    NSString * sql4 = [NSString stringWithFormat:@"phoneNum=\"%@\",",newPhone];
    NSString * sql5 = [NSString stringWithFormat:@"email=\"%@\" ,",newEmail];
    NSString * sql6 = [NSString stringWithFormat:@"wechat=\"%@\",",newWechat];
    NSString * sql7 = [NSString stringWithFormat:@"address=\"%@\",",newAddress];
    NSString * sql8 = [NSString stringWithFormat:@"  Where firstName=\"%@\" and lastname=\"%@\" and phoneNum=\"%@\" ",firstName,lastName,phone];
    NSString *result =@"";
    if(![newFirstName isEqualToString:@""])
        result = [result stringByAppendingString:sql2];
    if(![newLastName isEqualToString:@""])
        result = [result stringByAppendingString:sql3];
    if(![newPhone isEqualToString:@""])
        result = [result stringByAppendingString:sql4];
    if(![newAddress isEqualToString:@""])
        result = [result stringByAppendingString:sql5];
    if(![newWechat isEqualToString:@""])
        result = [result stringByAppendingString:sql6];
    if(![newEmail isEqualToString:@""])
        result = [result stringByAppendingString:sql7];
    int temp = (int)[result length];
    result = [result substringToIndex:temp-1];
    result = [sql1 stringByAppendingString:result];
    result = [result stringByAppendingString:sql8];
    const char *query_stmt = [result UTF8String];
    sqlite3_stmt * stmt;
    int finalResult =  sqlite3_exec(database, query_stmt, NULL, NULL, NULL);
    if (finalResult == SQLITE_OK) {
        NSLog(@"更改成功");
        return 1;
    } else {
        NSLog(@"更改失败");
        return -1;
    }
}

@end
