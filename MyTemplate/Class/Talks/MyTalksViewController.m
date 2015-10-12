//
//  MyTalksViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/9/14.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyTalksViewController.h"
#import "MyOperateTipsHelper.h"


@implementation MyTalksViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
        
        
    }
    return self;
}

- (void)viewDidLoad{
    
    self.title = @"会话";
    
    
    
    
    
    
    NSMutableDictionary *userInfoForNotify = [[NSMutableDictionary alloc] init];
    [userInfoForNotify setObject:@"会话" forKey:@"comeFromView"];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:MyNotification_Login_Success
                                                        object:nil
                                                      userInfo:userInfoForNotify];
    
    
    
    
    UIButton *myTestBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    [myTestBtn setTitle:@"显示" forState:UIControlStateNormal];
    [myTestBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:myTestBtn];
    myTestBtn.frame = CGRectMake(100, 100, 100, 100);
    [myTestBtn addTarget:self action:nil forControlEvents:UIControlEventTouchDown];
    
    
    
    NSLog(@"\nHome : %@",[MyGlobalHelper getSandboxDirectoryForHome]);
    NSLog(@"\nDocuments : %@",[MyGlobalHelper getSandboxDirectoryForDocuments]);
    NSLog(@"\nCaches : %@",[MyGlobalHelper getSandboxDirectoryForCaches]);
    NSLog(@"\nTmp : %@",[MyGlobalHelper getSandboxDirectoryForTmp]);


    
    NSString *testStr = @"文志平wzp";
    NSString *testStr1 = @"wzp";
    NSLog(@"\n%@ length = %lu",testStr,[testStr length]);
    NSLog(@"\n%@ length = %lu",testStr1,[testStr1 length]);
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    
//    //添加显示帮助向导的代码
//    MyOperateTipsHelper *channelManageTips = [[MyOperateTipsHelper alloc] initWithNibName:nil bundle:nil];
//    [channelManageTips showOperateTipsForChannelManageAtPoint:CGPointMake(95, 25)];
    
}






@end
