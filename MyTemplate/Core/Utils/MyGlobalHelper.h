//
//  MyGlobalHelper.h
//  MyTemplate
//
//  Created by qnsoft on 15/9/21.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyGlobalHelper : NSObject

+ (instancetype)sharedHelper;

//@property (nonatomic, assign) BOOL isOperateTipsShowing;

/**项目文件路径相关*/
/**返回项目的Home目录的路径*/
+ (NSString *) getSandboxDirectoryForHome;
/**
    返回项目的Documents目录的路径，
    存放数据库文件、备份文件，设备重启文件不丢失
    如果进行备份会将此文件夹中的文件包括其中
 */
+ (NSString *) getSandboxDirectoryForDocuments;
/**
    返回项目的Library/Caches目录的路径，
    设备重启文件不丢失
    备份不包含此文件夹 ，同级别的Preferences目录存放NSUserDefault设置的用户偏好文件
 */
+ (NSString *) getSandboxDirectoryForCaches;
/**
    返回项目的Tmp目录的路径
    存放临时文件，重启丢失
 */
+ (NSString *) getSandboxDirectoryForTmp;

// 判断是否为手机号
+ (BOOL)isPhoneNumberFormat:(NSString *)accountStr;
// 判断是否为邮箱
+ (BOOL)isEmailFormat:(NSString *)accountStr;
// 判断是否为6位数字
+ (BOOL)isVerifyCodeFormat:(NSString *)codeStr;
// 判断是否为密码格式
+ (BOOL)isCorrectPasswordFormat:(NSString *)pwdStr;
// 判断是否为空格字符串
+ (BOOL)isBlankString:(NSString *)string;
// 判断是否为整数
+ (BOOL)isPureInt:(NSString *)string;

+ (NSString *)getCachePathWithFileName:(NSString *)filename;

+ (int)calculateTextNumber:(NSString *) textA;

+ (NSString*)systemVersion;

+ (NSString *)deviceType;

+ (NSString*)resolustionPixel;

+ (NSString *)getIOSUUID;

+ (CGFloat)getScreenWidth;

+ (CGFloat)getScreenHeight;

+ (NSString *)getAppVersion;

+ (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size allowEnlarge:(BOOL)allowEnlarge;

+ (UIImage *)image:(UIImage *)originalImage toScale:(float)scaleSize;

+ (NSString *)getHeadImageDir;

+ (CGSize)calculateStringSize:(NSString *)str font:(UIFont *)font width:(CGFloat)width;

+ (BOOL)switchToCurrentUserDataBase;

+ (UIColor *)colorFromHexRGB:(NSString *) inColorString;


+ (NSString *)appLocale;

+ (void)setAppLocale:(NSString*)appLocale;

+ (void)checkUniqueIdIsExsit;



+ (void)setUserLongitude:(double)longitude;

+ (void)setUserLatitude:(double)latitude;

+ (NSString *)getSandBoxFilePath:(NSString *)fileName;


//NSDate   NSString
+ (NSDate *)getDateFromString:(NSString *)dateString;

+ (NSString *)getStringFromDate:(NSDate *)date;

//MD5
+ (NSString *)md5:(NSString *)str;

+ (NSString *)getBundleId;


- (CGSize)boundingRectWithSize:(CGSize)size;



+ (BOOL)autoriseCamera;




@end
