//
//  QNSecurity.h
//  MyTemplate
//
//  Created by qnsoft on 15/12/24.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AESEncryptor.h"
#import "RSAEncryptor.h"



@interface QNSecurity : NSObject


//单例声明
+(instancetype)sharedInstance;




#pragma mark --- AESEncryptor ---
@property (nonatomic, strong) NSString *qnAESKey;          //当前的AES密钥
/**
 * 生成指定长度的 AES 密钥
 */
+(NSString *) qnGenKeyWithLength:(QNAESKeyLength) aesKeyLength;
/**
 * 密钥长度为128/192/256通用的AES加密
 * return: NSString
 */
+(NSString *) qnEncryptString:(NSString *)plainString;

/**
 * 密钥长度为128/192/256通用的AES解密
 * return: NSString
 */
+(NSString *) qnDecryptString:(NSString *)cipherString;
/**
 * 密钥长度为128/192/256通用的AES加密
 * return: NSData
 */
+(NSData *) qnEncryptData:(NSData *)plainData;

/**
 * 密钥长度为128/192/256通用的AES解密
 * return: NSData
 */
+(NSData *) qnDecryptData:(NSData *)cipherData;








#pragma mark --- RSAEncryptor ---























@end
