//
//  NSString+CLExtention.h
//  QNGG
//
//  Created by 刘昶 on 15/7/13.
//  Copyright (c) 2015年 luxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (CLExtention)
-(NSString *)encryptWithMD5;
-(NSString *)encryptWithSHA1;

-(NSString *)converGBKString;

-(NSString *)pinYinStr;
-(NSString *)pinYinHeadStr;
+(NSString *)macaddress;
-(CGSize)cl_sizeWithFont:(UIFont *)font;

-(CGSize)cl_sizeWithMaxSize:(CGSize)size attributes:(NSDictionary *)attr;
/**
 *  手机号验证
 */
-(BOOL)isMobilePhoneNumber;
/**
 *  验证码验证 (默认为:六位数字)
 */
-(BOOL)isValidCode;

/**
 *  判断是否为邮箱
 */
- (BOOL)isEmailFormat ;

/**
 *  判断是否为密码格式
 */
- (BOOL)isCorrectPasswordFormat;

/**
 *  判断是否为整数
 */
- (BOOL)isPureInt ;



-(instancetype)stringOrEmptyStr;




/**
 * 随机生成 bits 位的字符串
 */
+(NSString *) generateKeyWithBits:(NSUInteger) bits;


@end
