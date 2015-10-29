//
//  CustomViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/10/28.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController


- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.leftBarButtonItemStyle = UILeftBarButtonItemStyleImage;
        self.sideSlipForNavBackWorked = YES;
        self.hidesBottomBarWhenPushed = YES;        //隐藏底部导航Bar
    }
    
    
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
