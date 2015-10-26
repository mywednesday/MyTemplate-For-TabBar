//
//  TextSizeCaculateViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/10/23.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "TextSizeCaculateViewController.h"
#import "Masonry.h"




@interface TextSizeCaculateViewController ()


@property (nonatomic, strong) UITextView *myTextView;
@property (nonatomic, strong) UIButton *myButton;
@property (nonatomic, strong) UILabel *myLabel;


@end






@implementation TextSizeCaculateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加隐藏键盘操作
    UITapGestureRecognizer *myHideKeyboardGestureRecgnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    myHideKeyboardGestureRecgnizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:myHideKeyboardGestureRecgnizer];
    
    
    
    //添加控件
    if(!_myTextView)
        _myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [_myTextView setFont:[UIFont systemFontOfSize:17.0]];
    [self.view addSubview:_myTextView];
    [_myTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH * 0.9);
        make.top.equalTo(self.view).offset(10);
        make.height.mas_equalTo(170);
        make.centerX.equalTo(self.view);
    }];
    
    
    if(!_myButton)
        _myButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [_myButton setTitle:@"计算" forState:UIControlStateNormal];
    [_myButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_myButton setBackgroundColor:[UIColor orangeColor]];
    [_myButton addTarget:self action:@selector(myBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myButton];
    [_myButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 40));
        make.right.equalTo(_myTextView);
        make.top.equalTo(_myTextView.mas_bottom).offset(20);
    }];
    
    
    if(!_myLabel)
        _myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    _myLabel.textColor = [UIColor blackColor];
    _myLabel.font = [UIFont systemFontOfSize:15];   //字体一定要设置
    _myLabel.numberOfLines = 0;                     //无限换行一定要设置
    _myLabel.text = @"要显示的信息";
    _myLabel.textAlignment = NSTextAlignmentLeft;
//    _myLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _myLabel.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_myLabel];
    [_myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH * 0.9);
        make.top.equalTo(_myButton.mas_bottom).offset(30);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.view);
    }];
}





- (void) myBtnClickAction {
    
    _myLabel.text = _myTextView.text;
    CGSize newSize = [self caculateUILabelHeight:_myLabel];
    
    
    [_myLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myButton.mas_bottom).offset(30);
        make.height.mas_equalTo(newSize.height);
        make.width.mas_equalTo(newSize.width);
        make.centerX.equalTo(self.view);
    }];
    
    
}



- (CGSize) caculateUILabelHeight:(UILabel *) label {
    CGSize newSize = CGSizeZero;
    
    label.numberOfLines = 0;
    NSDictionary *attribute = @{NSFontAttributeName: label.font};
    
    newSize = [label.text boundingRectWithSize:CGSizeMake(label.bounds.size.width, 0)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attribute
                                       context:nil].size;
    
    

  
    
    
    
    return newSize;
}








/**
    隐藏键盘
 */
- (void) hideKeyboard {
    [_myTextView resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
