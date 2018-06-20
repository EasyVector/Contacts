//
//  TextCell.h
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/12.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextCell : UITableViewCell

/**
 *  设置cell、数据
 *  @param string        左边的标题
 *  @param dataString    textfield输入内容
 *  @param indexPath     indexPath。唯一绑定当前textfield
 */
- (void)setTitleString:(NSString *)string
         andDataString:(NSString *)dataString
          andIndexPath:(NSIndexPath *)indexPath;
@end
