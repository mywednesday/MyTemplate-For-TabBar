//
//  MyTableViewCell.m
//  MyTemplate
//
//  Created by qnsoft on 15/10/19.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyTableViewCell.h"
#import "Masonry.h"



@interface MyTableViewCell ()
@property (nonatomic, strong) UIView *separatorLine;
@end





@implementation MyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


/**
    添加Cell底部的分割线
 */
- (void) addSeparatorLine{
    if (!_separatorLine) {
        _separatorLine = [[UIView alloc] init];
        [self.contentView addSubview: _separatorLine];
        _separatorLine.backgroundColor = CELL_LIGHT_SEPARATOR_COLOR;
    }
    
    __weak typeof(self) weakSelf = self;
    [_separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(0);
        make.right.equalTo(weakSelf.contentView).with.offset(0);
        make.bottom.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(1.0);
    }];
}





/**
    删除Cell底部的分割线
 */
- (void)removeSepartor{
    if(_separatorLine){
        [_separatorLine removeFromSuperview];
        _separatorLine = nil;
    }
}

@end
