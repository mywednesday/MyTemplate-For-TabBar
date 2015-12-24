//
//  QNSecurity.m
//  MyTemplate
//
//  Created by qnsoft on 15/12/24.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "QNSecurity.h"

@implementation QNSecurity {
    AESEncryptor *aesEncryptor;
    RSAEncryptor *rsaEncryptor;
}


//单例定义
+(instancetype)sharedInstance{
    return [self new];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}
-(instancetype)init{
    static dispatch_once_t onceToken;
    static typeof(self) instance;
    dispatch_once(&onceToken, ^{
        instance = [super init];
        
    });
    aesEncryptor = [AESEncryptor new];
    rsaEncryptor = [RSAEncryptor new];
    return instance;
}





/**
 * 生成指定长度的 AES 密钥
 */
+(NSString *) qnGenKeyWithLength:(QNAESKeyLength) aesKeyLength {
    
    return nil;
}
/**
 * 密钥长度为128/192/256通用的AES加密
 * return: NSString
 */
+(NSString *) qnEncryptString:(NSString *)plainString {
    
    return nil;
}

/**
 * 密钥长度为128/192/256通用的AES解密
 * return: NSString
 */
+(NSString *) qnDecryptString:(NSString *)cipherString {
    
    return nil;
}
/**
 * 密钥长度为128/192/256通用的AES加密
 * return: NSData
 */
+(NSData *) qnEncryptData:(NSData *)plainData {
    
    return nil;
}

/**
 * 密钥长度为128/192/256通用的AES解密
 * return: NSData
 */
+(NSData *) qnDecryptData:(NSData *)cipherData {
    
    return nil;
}




@end
