//
//  NameIndex.h
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/11.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#ifndef NameIndex_h
#define NameIndex_h
@interface NameIndex : NSObject {
    NSString *_lastName;
    NSString *_firstName;
    NSInteger _sectionNum;
    NSInteger _originIndex;
}
@property (nonatomic, retain) NSString *_lastName;
@property (nonatomic, retain) NSString *_firstName;
@property (nonatomic) NSInteger _sectionNum;
@property (nonatomic) NSInteger _originIndex;
- (NSString *) getFirstName:(NSString *)firstName;
- (NSString *) getLastName;
@end

#endif /* NameIndex_h */
