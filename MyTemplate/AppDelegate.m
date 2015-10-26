//
//  AppDelegate.m
//  MyTemplate
//
//  Created by qnsoft on 15/9/14.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "AppDelegate.h"
#import "MyPersonCenterNavViewController.h"
#import "MyPersonCenterViewController.h"
#import "MyTalksNavViewController.h"
#import "MyTalksViewController.h"








@interface AppDelegate ()

@end

@implementation AppDelegate


+ (void)initialize
{
    [super initialize];
    
    //[[XWUserManager sharedUserManager] setUserLoginFlag: XWLocalUserFlag];
    
    
    //--1-- 获得系统信息
    
    
    //--2-- 加载日志记录工具
    
    
    //--3--
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    //--1-- 设置App全局显示效果
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setUpAppearance];
    
    
    //--2-- 初始化网络
    
    
    
    //--3-- 统计打开次数
    
    
    
    //--4-- 开源组件的全局设置
    
    
    
    //--5-- 程序开始，加载页面
    [self showHomePage];
    
    
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];

    //没有这句话，屏幕不会显示任何东西
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}






#pragma mark 自定义方法


/**
 设置App全局显示效果
 */
- (void)setUpAppearance {
    
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
    //设置状态栏风格
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    //设置导航栏属性
    NSDictionary *navBarTextAttributes = @{NSFontAttributeName:NAVBAR_FONT,
                                           NSForegroundColorAttributeName:NAVBAR_TITLE_COLOR};
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTextAttributes];
    [[UINavigationBar appearance] setBarTintColor:APP_TINT_COLOR];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]]; //navbar上除标题外的元素的颜色
    
    
    // 设置UITabBar的显示效果
    [[UITabBar appearance] setBarTintColor:APP_BASE_COLOR];
    [[UITabBar appearance] setTintColor:APP_TINT_COLOR];
}



/**
 加载程序开始页面
 */
- (void) showHomePage {
    
    UITabBarController *mainTabBarController = [[UITabBarController alloc] init];
    
    
    //--1-- 关联页面（一般都需要导航控制器）
    //个人中心
    MyPersonCenterViewController *myPerCenterVC = [[MyPersonCenterViewController alloc] init];
    MyPersonCenterNavViewController *myPerCenterNavVC = [[MyPersonCenterNavViewController alloc] initWithRootViewController:myPerCenterVC];
    //会话
    MyTalksViewController *myTalksVC = [[MyTalksViewController alloc] init];
    MyTalksNavViewController *myTalksNavVC = [[MyTalksNavViewController alloc] initWithRootViewController:myTalksVC];
    
    [mainTabBarController setViewControllers:[NSArray arrayWithObjects:myTalksNavVC, myPerCenterNavVC, nil]
                                    animated:NO];
    

    
    
    //--2-- 设置个页面对应的TabBarItem的背景图片、文字
    NSArray *tabBarItems = mainTabBarController.tabBar.items;
    
    UITabBarItem *talksTabBarItem = [tabBarItems objectAtIndex:0];
    talksTabBarItem.title = @"会话";
    [talksTabBarItem setImage:[UIImage imageNamed:@"talks_tabItem"]];
    UITabBarItem *personTabBarItem = [tabBarItems objectAtIndex:1];
    personTabBarItem.title = @"个人";
    [personTabBarItem setImage:[UIImage imageNamed:@"person_center_tabItem"]];
    
    
    
    
    self.mainViewController = mainTabBarController;
    self.window.rootViewController = mainTabBarController;
}














@end
