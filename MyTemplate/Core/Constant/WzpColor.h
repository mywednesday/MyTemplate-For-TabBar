//
//  WzpColor.h
//  MyTemplate
//
//  Created by qnsoft on 15/11/25.
//  Copyright © 2015年 wzp. All rights reserved.
//

#ifndef WzpColor_h
#define WzpColor_h


/**
    通用 常量
 */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define colorFromHexRGB(hexRgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]







/**
    应用 常量
 */
#define NAVBAR_FONT     [UIFont systemFontOfSize:22]
#define NAVBAR_TITLE_COLOR     RGBCOLOR(255,255,255)
#define APP_BASE_COLOR    [UIColor colorWithRed:(255.0)/255.0 green:(255.0)/255.0 blue:(255.0)/255.0 alpha:1]
#define APP_TINT_COLOR     [UIColor colorWithRed:(204.0)/255.0 green:(0.0)/255.0 blue:(0.0)/255.0 alpha:1]
#define VIEW_NORMAL_BG_COLOR     [UIColor colorWithRed:(238)/255.0 green:(240)/255.0 blue:(242)/255.0 alpha:1]   //视图背景色
#define CELL_LIGHT_SEPARATOR_COLOR    [UIColor colorWithRed:(221)/255.0 green:(225)/255.0 blue:(230)/255.0 alpha:1]     //Cell分割线颜色












#endif /* WzpColor_h */
