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

//用户的经纬度
+ (double)getUserLongitude;

+ (double)getUserLatitude;

+ (void)setUserLongitude:(double)longitude;

+ (void)setUserLatitude:(double)latitude;

+ (NSString *)getSandBoxFilePath:(NSString *)fileName;


//NSDate   NSString
+ (NSDate *)getDateFromString:(NSString *)dateString;

+ (NSString *)getStringFromDate:(NSDate *)date;

//MD5
+ (NSString *)md5:(NSString *)str;

+ (NSString *)getBundleId;


+ (BOOL)autoriseCamera;




@end
