//
//  DBManager.h
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/17.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;

-(BOOL)createDB;

- (BOOL) saveDataWithfirstName:(NSString*)firstName lastName:(NSString*)lastName
                      phoneNum:(NSString*)phoneNum address:(NSString*)address email:(NSString*)email wechat:(NSString*)wechat;

- (BOOL) deleteDataWithfirstName:(NSString*)firstName lastName:(NSString*)lastName
                        phoneNum:(NSString*)phoneNum;


- (NSMutableArray*) findByFirstName:(NSString*)firstName lastName:(NSString*)lastName phoneNum:(NSString*)phoneNum;

- (NSMutableArray*) findAll;

- (int)updateDataFromFirstName:(NSString*)firstName andLastName:(NSString*)lastName andPhone:(NSString*)phone toFirstName:(NSString*)newFirstName toLastName:(NSString*)newLastName toPhone:(NSString*)newPhone toAddress:(NSString*)newAddress toEmail:(NSString*)newEmail toWechat:(NSString*)newWechat;
@end
