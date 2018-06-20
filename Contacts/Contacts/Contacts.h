//
//  Contacts.h
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/17.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Contacts : NSObject
@property NSString *firstName;
@property NSString *lastName;
@property NSString *phone;
@property NSString *address;
@property NSString *wechat;
@property NSString *email;
@property NSString *index;
@end
