//
//  WzpLog.h
//  MyTemplate
//
//  Created by qnsoft on 15/11/25.
//  Copyright © 2015年 wzp. All rights reserved.
//

#ifndef WzpLog_h
#define WzpLog_h


/**
    通用 常量
 */
//调试日志
#ifdef DEBUG
    #define CusDebugLog(format,...) (NSLog((@"\r\n<<< --- log begin ---\r\n[文件名:%s]\r\n" "[函数名:%s]\r\n" "[行号:%d]\r\n" format "\r\n --- log end --- >>>\r\n\r\n"),__FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__))
#else
    #define CusDebugLog(format,...)
#endif
//放在VC的 dealloc 或者 didReceiveMemoryWarning 方法中，监视VC的释放 
#define CusMemoryCheckDebugLog QNDebugLog(@"<%@,%p> is dealoc.Memory safe",self.class,self)








/**
    应用 常量
 */
#ifdef CusDebugLog
    #define APPDEBUGLOG CusDebugLog
#endif
#define APP_MEMORY_CHECK_DEBUG_LOG CusMemoryCheckDebugLog



#endif /* WzpLog_h */
