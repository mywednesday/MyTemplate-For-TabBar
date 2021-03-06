//
//  AppDefine.h
//  MyTemplate
//
//  Created by qnsoft on 15/9/14.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#ifndef MyTemplate_AppDefine_h
#define MyTemplate_AppDefine_h


/**
 全局变量、方法的定义
 */






//通知，一般在AppDefine.h中定义，可供全局使用
#define MyNotification_Login_Success @"MyNotification_Login_Success"
#define MyNotification_PassValue @"MyNotification_PassValue"            //页面传值通知的定义


//颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
                                    //十六进制
#define colorFromHexRGB(hexRgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//设备尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([UIScreen mainScreen].bounds.size)



//当前操作系统状态、相关设置
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CURRENT_SYSTEM_VERSION ([[UIDevice currentDevice] systemVersion])
#define CURRENT_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])




//调试信息
#ifdef DEBUG
#define CusDebugLog(format,...) (NSLog((@"\r\n<<< --- log begin ---\r\n[文件名:%s]\r\n" "[函数名:%s]\r\n" "[行号:%d]\r\n" format "\r\n --- log end --- >>>\r\n\r\n"),__FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__))
#else
#define CusDebugLog(format,...)
#endif



//   设备特征
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4_or_4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5_or_5s_or_5c ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6_or_6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus_or_6sPlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)




//当前设备是iPhone
#if TARGET_OS_IPHONE
//iPhone Device

#endif




//当前设备是模拟器
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator

#endif


#endif
