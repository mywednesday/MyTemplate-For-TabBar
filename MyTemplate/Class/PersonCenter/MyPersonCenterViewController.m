//
//  MyPersonCenterViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/9/14.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyPersonCenterViewController.h"

@implementation MyPersonCenterViewController



- (void) dealloc {
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MyNotification_Login_Success object:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginSuccess:)
                                                     name:MyNotification_Login_Success
                                                   object:nil];
        
    }
    return self;
}

- (void) viewDidLoad {

    self.title = @"个人中心";
    
    NSMutableDictionary *userInfoForNotify = [[NSMutableDictionary alloc] init];
    [userInfoForNotify setObject:@"个人中心" forKey:@"comeFromView"];
    [[NSNotificationCenter defaultCenter] postNotificationName:MyNotification_Login_Success
                                                        object:nil
                                                      userInfo:userInfoForNotify];

}








- (void) loginSuccess: (NSNotification *) notify {
    NSLog(@"\nloginSuccess:\n%@",[notify.userInfo objectForKey:@"comeFromView"]);
}
@end
