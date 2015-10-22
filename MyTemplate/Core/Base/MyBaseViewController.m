//
//  MyBaseViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/10/15.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyBaseViewController.h"

@interface MyBaseViewController ()


@end



@implementation MyBaseViewController


- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.title = @"MyBaseViewController";
    [self.view setBackgroundColor:VIEW_NORMAL_BG_COLOR];
    
    if([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        [self.navigationController.navigationBar setTranslucent:NO];
    }
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
    
    
    
    //设置导航栏 左侧按钮风格
    if (self) {
        _leftBarButtonItemStyle = UILeftBarButtonItemStyleImage;
        _sideSlipForNavBackWorked = NO;
    }
    
    
    
    
    
    
    
    //添加左上角的返回按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.highlighted=NO;
    
    
    
    switch (_leftBarButtonItemStyle) {
        case UILeftBarButtonItemStyleImage:{
            btn.frame=CGRectMake(0, 0, 40, 40);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
            [btn setImage:[UIImage imageNamed:@"navbtn_back"] forState:UIControlStateNormal];       //navbtn_back  =  25 * 25
            break;
        }
        case UILeftBarButtonItemStyleTitle:{
            btn.frame=CGRectMake(0, 0, 40, 40);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
            [btn setTitle:@"返回" forState:UIControlStateNormal];
            break;
        }
        case UILeftBarButtonItemStyleTitleAndImage:{
            btn.frame=CGRectMake(0, 0, 60, 40);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
            [btn setImage:[UIImage imageNamed:@"navbtn_back"] forState:UIControlStateNormal];
            [btn setTitle:@"返回" forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
    
    
    [btn addTarget:self action:@selector(navBack) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem.width = 40;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
    
    
    
    
    //向右滑动，返回上一页面手势
    if (_sideSlipForNavBackWorked) {
        UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(navBack)];
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        swipeGestureRecognizer.numberOfTouchesRequired = 1;
        [self.view addGestureRecognizer:swipeGestureRecognizer];
    }
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
}


-(void)navBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
