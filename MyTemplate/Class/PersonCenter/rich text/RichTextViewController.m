//
//  RichTextViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/11/22.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "RichTextViewController.h"
#import <Masonry.h>

@interface RichTextViewController ()
@property (nonatomic, strong) UILabel *myRichTextLabel;
@end

@implementation RichTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"富文本";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self.view addSubview:self.myRichTextLabel];
    [self.myRichTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    
    
    
    //设置富文本特性
    NSString *showText = @"15589664.123";
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont systemFontOfSize:32.0], NSFontAttributeName, nil];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:showText attributes:attributeDict];
    [AttributedStr setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0], NSFontAttributeName, nil]
                           range:NSMakeRange([showText rangeOfString:@"."].location + 1, 3)];

    self.myRichTextLabel.attributedText = AttributedStr;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





- (UILabel *) myRichTextLabel {
    if(!_myRichTextLabel){
        _myRichTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _myRichTextLabel.text  = @"152.02";
        _myRichTextLabel.textAlignment = NSTextAlignmentCenter;
        _myRichTextLabel.font = [UIFont systemFontOfSize: 32.0];
    }
    
    return _myRichTextLabel;
}














@end
