//
//  ProDelegateSecondViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/10/21.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "ProDelegateSecondViewController.h"
#import "Masonry.h"
#import "ProDelegateSingleton.h"

@class ProDelegateFirstViewController;






@interface ProDelegateSecondViewController ()

@property (nonatomic,strong) UITextField *myTextField;


@end








@implementation ProDelegateSecondViewController


- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _Page_1_To_2_DataPassWay = DataPassWayByProperty;
    }
    
    
    return self;
}



- (id) initwithBlock:(StrBlock) str
{
    if (self) {
        self.myBlock = str;
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"委托协议_2";
    
    //点击空白区域，收起键盘
    UITapGestureRecognizer *hidekeyBoardGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    hidekeyBoardGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:hidekeyBoardGestureRecognizer];
    
    
    //设置委托对象
    
    
    _myTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    _myTextField.placeholder = @"第一个页面传递过来的数据是...";
    _myTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_myTextField];
    [_myTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.8);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    
    
    //      1.   委托delegate方式;
    UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [myButton setTitle:@"将数据返回给上一个页面(delegate)" forState:UIControlStateNormal];
    [myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myButton setBackgroundColor:[UIColor redColor]];
    [myButton addTarget:self action:@selector(jumpTolastVC) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:myButton];
    [myButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myTextField.mas_bottom).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.8);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    
    //      2.   通知notification方式;
    UIButton *myButtonForNotify = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [myButtonForNotify setTitle:@"将数据返回给上一个页面(Notification)" forState:UIControlStateNormal];
    [myButtonForNotify setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myButtonForNotify setBackgroundColor:[UIColor redColor]];
    [myButtonForNotify addTarget:self action:@selector(sendNotify) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:myButtonForNotify];
    [myButtonForNotify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myButton.mas_bottom).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.8);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    
    
    //      3.   block方式;
    UIButton *myButtonForBlock = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [myButtonForBlock setTitle:@"将数据返回给上一个页面(block)" forState:UIControlStateNormal];
    [myButtonForBlock setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myButtonForBlock setBackgroundColor:[UIColor redColor]];
    [myButtonForBlock addTarget:self action:@selector(sendDataByBlock:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:myButtonForBlock];
    [myButtonForBlock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myButtonForNotify.mas_bottom).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.8);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    
    
    
}




- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //页面间   属性传值
    if(_Page_1_To_2_DataPassWay == DataPassWayByProperty)
        _myTextField.text = _myFirstVCString;
    
    
    
    //页面间   NSUserDefaults传值
    if (_Page_1_To_2_DataPassWay == DataPassWayByNSUserDefault) {
        NSString *tmpStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"_myTextField"];
        if ([tmpStr length] > 0) {
            _myTextField.text = tmpStr;
        }
    }
    
    
    //页面间   Singleton传值
    if (_Page_1_To_2_DataPassWay == DataPassWayBySingleton) {
       
        //此处的并不能实现，按现在单例类的设计是不可以实现数据传递的
        
//        NSString *tmpStr = [ProDelegateSingleton shareProDelegateSingleton].shareString;
//        if ([tmpStr length] > 0) {
//            _myTextField.text = tmpStr;
//        }
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}





/**
 跳转到上一个页面
 */
- (void) jumpTolastVC {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendDataFrom_2_To_1:)]) {
        [self.delegate sendDataFrom_2_To_1:_myTextField.text];
    }
    
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        CustomLog(@"self.navigationController  跳转失败");
    }
}



/**
    通过“通知”将数据发送到另一个页面
 */
- (void) sendNotify {
    [[NSNotificationCenter defaultCenter] postNotificationName:MyNotification_PassValue
                                                        object:self
                                                      userInfo:@{@"myValue":_myTextField.text}];
//    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        CustomLog(@"self.navigationController  跳转失败");
    }
}



/**
    通过 block 将数据发送到另一个页面
 */
- (void) sendDataByBlock:(StrBlock)strBlock {
    if(self.myBlock)
        self.myBlock(_myTextField.text);
    
    if(self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}






























/**
 收起键盘
 */
- (void) hideKeyBoard {
    [_myTextField resignFirstResponder];
}




















@end
