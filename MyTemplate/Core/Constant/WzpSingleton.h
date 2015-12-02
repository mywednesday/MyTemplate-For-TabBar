//
//  WzpSingleton.h
//  MyTemplate
//
//  Created by qnsoft on 15/11/25.
//  Copyright © 2015年 wzp. All rights reserved.
//

#ifndef WzpSingleton_h
#define WzpSingleton_h




/**
    通用 常量
 */

//单例声明
#define CUSTOM_SINGLETON_DECLARE \
+(instancetype)sharedInstance;
//单例定义
#define CUSTOM_SINGLETON_IMPLEMENTATION \
+(instancetype)sharedInstance{ \
return [self new]; \
} \
\
+(instancetype)allocWithZone:(struct _NSZone *)zone{ \
static id instance; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
}\
\
-(instancetype)init{\
static dispatch_once_t onceToken;\
static typeof(self) instance;\
dispatch_once(&onceToken, ^{\
instance = [super init];\
});\
return instance;\
}







/**
    应用 常量
 */
#define APP_SINGLETON_DECLARE CUSTOM_SINGLETON_DECLARE
#define APP_SINGLETON_IMPLEMENTATION CUSTOM_SINGLETON_IMPLEMENTATION













#endif /* WzpSingleton_h */
