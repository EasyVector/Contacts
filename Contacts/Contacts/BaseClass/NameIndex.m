//
//  NameIndex.m
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/11.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NameIndex.h"
#import "LookForInitialPinyinLetter.h"
@implementation NameIndex
@synthesize _firstName, _lastName;
@synthesize _sectionNum, _originIndex;
- (NSString *) getFirstName:(NSString *)firstName {
    if ([firstName canBeConvertedToEncoding: NSASCIIStringEncoding]) {//如果是英文
        return [self toUpper:[firstName substringToIndex:1]];
    }
    else { //如果是非英文
        NSString*temp=[NSString stringWithFormat:@"%c",pinyinFirstLetter([firstName characterAtIndex:0])];
        if([temp canBeConvertedToEncoding: NSASCIIStringEncoding])
        {
            return [self toUpper: temp];
        }else
        {
            return @"#";
        }
    }
}


- (NSString *) getLastName {
    if ([_lastName canBeConvertedToEncoding:NSASCIIStringEncoding]) {
        return _lastName;
    }
    else {
        return [NSString stringWithFormat:@"%c",pinyinFirstLetter([_lastName characterAtIndex:0])];
    }
}

-(NSString *)toLower:(NSString *)str{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='A'&[str characterAtIndex:i]<='Z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]+32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}

-(NSString *)toUpper:(NSString *)str{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='a'&[str characterAtIndex:i]<='z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]-32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}
@end
