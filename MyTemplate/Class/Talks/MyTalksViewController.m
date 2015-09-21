//
//  MyTalksViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/9/14.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyTalksViewController.h"


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
    
    
    
    
    
    
    
    
    NSLog(@"\nHome : %@",[MyGlobalHelper getSandboxDirectoryForHome]);
    NSLog(@"\nDocuments : %@",[MyGlobalHelper getSandboxDirectoryForDocuments]);
    NSLog(@"\nCaches : %@",[MyGlobalHelper getSandboxDirectoryForCaches]);
    NSLog(@"\nTmp : %@",[MyGlobalHelper getSandboxDirectoryForTmp]);


}













@end
