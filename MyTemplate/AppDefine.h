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






//通知
#define MyNotification_Login_Success @"MyNotification_Login_Success"


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
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif



//   设备特征
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
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
