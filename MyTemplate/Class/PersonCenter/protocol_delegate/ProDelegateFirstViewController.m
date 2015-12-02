//
//  ProDelegateFirstViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/10/21.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "ProDelegateFirstViewController.h"
#import "Masonry.h"
#import "ProDelegateSecondViewController.h"
#import "ProDelegateSingleton.h"








@interface ProDelegateFirstViewController ()<ProDelegateSecondVCDelegate>

@property (nonatomic,strong) UITextField *myTextField;
@property (nonatomic,strong) UILabel *myFetchLabel;     // 接收第二个页面返回数据的 UILabel

@end

@implementation ProDelegateFirstViewController



- (void) dealloc {
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MyNotification_PassValue object:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getPassedValue:)
                                                     name:MyNotification_PassValue
                                                   object:nil];
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"委托协议_1";
    
    
    //点击空白区域，收起键盘
    UITapGestureRecognizer *hidekeyBoardGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    hidekeyBoardGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:hidekeyBoardGestureRecognizer];
    
    
    
    _myTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    _myTextField.placeholder = @"输入一段文字传递到第二页面";
    _myTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_myTextField];
    [_myTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.8);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    
    
    
    
    
    UILabel *myDiscriptionLabel = [[UILabel alloc] init];
    myDiscriptionLabel.text = @"第二页面返回的数据:";
    [myDiscriptionLabel sizeToFit];
    [self.view addSubview:myDiscriptionLabel];
    [myDiscriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myTextField.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(20);
    }];
    



    
    _myFetchLabel = [[UILabel alloc] init];
    _myFetchLabel.text = @"接收第二页面返回的数据....";
    [_myFetchLabel sizeToFit];
    [self.view addSubview:_myFetchLabel];
    [_myFetchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myDiscriptionLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.8);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];

    
    
    
    //    6. 通过设置属性，实现页面间传值
    UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [myButton setTitle:@"传递数据第二个页面(设置属性)" forState:UIControlStateNormal];
    [myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myButton setBackgroundColor:[UIColor redColor]];
    [myButton addTarget:self action:@selector(jumpToSecondVC) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:myButton];
    [myButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myFetchLabel.mas_bottom).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.8);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    
    //      3.   block方式;
    UIButton *myButtonForBlock = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [myButtonForBlock setTitle:@"传递数据第二个页面(block)" forState:UIControlStateNormal];
    [myButtonForBlock setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myButtonForBlock setBackgroundColor:[UIColor redColor]];
    [myButtonForBlock addTarget:self action:@selector(sendDataFrom_2_To_1_ByBlock:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:myButtonForBlock];
    [myButtonForBlock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myButton.mas_bottom).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.8);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    
    //      4.   UserDefault或者文件方式
    UIButton *myButtonForUserDefault = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [myButtonForUserDefault setTitle:@"传递数据第二个页面(UserDefault)" forState:UIControlStateNormal];
    [myButtonForUserDefault setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myButtonForUserDefault setBackgroundColor:[UIColor redColor]];
    [myButtonForUserDefault addTarget:self action:@selector(sendDataFrom_2_To_1_ByNSUserDefault) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:myButtonForUserDefault];
    [myButtonForUserDefault mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myButtonForBlock.mas_bottom).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.8);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    //      5.   单例(Singleton)模式方式
    UIButton *myButtonForSingleton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [myButtonForSingleton setTitle:@"传递数据第二个页面(Singleton)" forState:UIControlStateNormal];
    [myButtonForSingleton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myButtonForSingleton setBackgroundColor:[UIColor redColor]];
    [myButtonForSingleton addTarget:self action:@selector(sendDataFrom_2_To_1_BySingleton) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:myButtonForSingleton];
    [myButtonForSingleton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myButtonForUserDefault.mas_bottom).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.8);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
}


//跳转到第二个页面
- (void) jumpToSecondVC {
    ProDelegateSecondViewController *secondVC = [[ProDelegateSecondViewController alloc] initWithNibName:nil bundle:nil];
    secondVC.myFirstVCString = _myTextField.text;
    secondVC.delegate = self;
    secondVC.Page_1_To_2_DataPassWay = DataPassWayByProperty;

    
    if (self.navigationController) {
        [self.navigationController pushViewController:secondVC animated:YES];
    }else{
        CusDebugLog(@"self.navigationController  跳转失败");
    }
}





/**
    收起键盘
 */
- (void) hideKeyBoard {
    [_myTextField resignFirstResponder];
}




#pragma mark - ProDelegateSecondVCDelegate
//委托传值
- (void) sendDataFrom_2_To_1:(NSString *)fetchString {
    _myFetchLabel.text = fetchString;
    CusDebugLog(@"Delegate逆向传值:%@",fetchString);
}



//通知传值
- (void) getPassedValue: (NSNotification *) notify {
    NSDictionary *nameDictionary = [notify userInfo];
    _myFetchLabel.text = [nameDictionary objectForKey:@"myValue"];
    CusDebugLog(@"NSNotification 传值:%@",_myFetchLabel.text);
}



//通过Block显示，传递的值
- (void) sendDataFrom_2_To_1_ByBlock:(StrBlock) tmpBlock {
    ProDelegateSecondViewController *secondVC =[[ProDelegateSecondViewController alloc] initwithBlock:^(NSString *str) {
        _myFetchLabel.text = str;
    }];
    secondVC.Page_1_To_2_DataPassWay = DataPassWayByBlock;
    
    [self.navigationController pushViewController:secondVC animated:YES];
}




//通过UserDefault显示，传递的值
- (void) sendDataFrom_2_To_1_ByNSUserDefault {
    ProDelegateSecondViewController *secondVC =[[ProDelegateSecondViewController alloc] initWithNibName:nil bundle:nil];
    secondVC.Page_1_To_2_DataPassWay = DataPassWayByNSUserDefault;
    
    [[NSUserDefaults standardUserDefaults] setObject:_myTextField.text forKey:@"_myTextField"];
    [[NSUserDefaults standardUserDefaults] synchronize];        //一定要同步
    
    [self.navigationController pushViewController:secondVC animated:YES];
}



//通过UserDefault显示，传递的值
- (void) sendDataFrom_2_To_1_BySingleton {
    ProDelegateSecondViewController *secondVC =[[ProDelegateSecondViewController alloc] initWithNibName:nil bundle:nil];
    secondVC.Page_1_To_2_DataPassWay = DataPassWayBySingleton;
    
    [[ProDelegateSingleton shareProDelegateSingleton] setShareString:_myTextField.text];
    
    [self.navigationController pushViewController:secondVC animated:YES];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
