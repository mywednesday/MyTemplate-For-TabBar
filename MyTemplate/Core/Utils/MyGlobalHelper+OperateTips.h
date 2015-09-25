//
//  MyGlobalHelper+OperateTips.h
//  MyTemplate
//
//  Created by qnsoft on 15/9/25.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyGlobalHelper.h"


#define OperateTips_For_New @"PageTips_For_New"        //新闻主页的使用提示
typedef NS_ENUM(NSInteger, SpecificViewKey) {
    Talk_ViewKey = 0,
    Person_ViewKey = 1
};




@interface MyGlobalHelper (OperateTips)


/**
    显示一个指定页面的操作提示
 */
+ (void) showOperateTipsForSpecificView:(SpecificViewKey) specificViewKey;


/**
 显示会话页面操作提示
 */
+ (void) showTalkViewOperateTips;



/**
 个人中心页面操作提示
 */
+ (void) showPersonViewOperateTips;


@end
