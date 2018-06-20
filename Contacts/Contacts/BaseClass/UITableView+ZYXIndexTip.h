//
//  UITableView+ZYXIndexTip.h
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/12.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ZYXIndexTip)
//显示索引字符悬浮提示;在点击或滑动索引时，在UITableView中间显示一个Label显示当前的索引字符
-(void)addIndexTip;
@end
