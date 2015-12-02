//
//  WzpDevice.h
//  MyTemplate
//
//  Created by qnsoft on 15/11/25.
//  Copyright © 2015年 wzp. All rights reserved.
//

#ifndef WzpDevice_h
#define WzpDevice_h


/**
    通用 常量
 */
//设备尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([UIScreen mainScreen].bounds.size)

//当前操作系统状态、相关设置
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CURRENT_SYSTEM_VERSION ([[UIDevice currentDevice] systemVersion])
#define CURRENT_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])

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












/**
    应用 常量
 */





#endif /* WzpDevice_h */
