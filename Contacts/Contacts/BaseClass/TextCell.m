//
//  TextCell.m
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/12.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import "TextCell.h"
#import "IndexPath.h"

@interface TextCell ()

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TextCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitleString:(NSString *)string andDataString:(NSString *)dataString andIndexPath:(NSIndexPath *)indexPath{
    // 核心代码
    self.textField.indexPath = indexPath;
    self.textField.text = dataString;
    self.titleLabel.text = string;
}


- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(120, 5, 160, 30)];// 这些坐标我随便写死了，可在layoutsubViews自己改
        _textField.layer.borderColor = [UIColor cyanColor].CGColor;
        _textField.layer.borderWidth = 0;
    }
    return _textField;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 40)];
    }
    return _titleLabel;
}
@end
