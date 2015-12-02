//
//  NSString+CLExtention.m
//  QNGG
//
//  Created by 刘昶 on 15/7/13.
//  Copyright (c) 2015年 luxy. All rights reserved.
//

#import "NSString+CLExtention.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
@implementation NSString (CLExtention)
#pragma mark -MD5
-(NSString *)encryptWithMD5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i< CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x",digest[i]];
    }
    return result.copy;
}

#pragma mark SHA1
-(NSString *)encryptWithSHA1 {
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (int)data.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x",digest[i]];
    }
    return result.copy;
}


-(NSString *)converGBKString{
    NSStringEncoding gbk = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *strData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *gbkStr = [[NSString alloc]initWithData:strData encoding:gbk];
    return gbkStr;
}

-(NSString *)pinYinStr{
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return mutableString.copy;
}
-(NSString *)pinYinHeadStr{
    NSString *full = [[self pinYinStr] capitalizedString];
    NSMutableString *str = [NSMutableString string];
    NSRegularExpression *rex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z]" options:0 error:nil];
    NSArray *results= [rex matchesInString:full options:0 range:NSMakeRange(0, full.length)];
    for (NSTextCheckingResult *result in results) {
        [str appendString:[full substringWithRange:result.range]];
    }
    return str;
}

#pragma mark mac address
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
+ (NSString *) macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}

-(CGSize)cl_sizeWithFont:(UIFont *)font{
   return [self sizeWithAttributes:@{NSFontAttributeName : font}];
}

-(CGSize)cl_sizeWithMaxSize:(CGSize)size attributes:(NSDictionary *)attr{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
}

-(BOOL)isMobilePhoneNumber{
    if (self.length < 11){
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:self];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:self];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:self];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}



/**
 *  验证码验证 (默认为:六位数字)
 */
-(BOOL)isValidCode {
    NSString *VALID_CODE = @"\\b([0-9]{6})\\b";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VALID_CODE];
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}

/**
 *  判断是否为邮箱
 */
- (BOOL)isEmailFormat {
    NSString *EMAIL_CODE = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", EMAIL_CODE];
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}

/**
 *  判断是否为密码格式
 */
- (BOOL)isCorrectPasswordFormat {
    
    BOOL isMatch = NO;
    if (self.length != 0) {
        NSString *PASSWORD_CODE = @"\\b([a-zA-Z0-9]{6,16})\\b";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PASSWORD_CODE];
        isMatch = [pred evaluateWithObject:self];
    }
    
    
    return isMatch;
}

/**
 *  判断是否为整数
 */
- (BOOL)isPureInt {
    NSScanner* scan = [NSScanner scannerWithString: self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}



-(instancetype)stringOrEmptyStr{
    return self.length ? self : @"";
}
@end
