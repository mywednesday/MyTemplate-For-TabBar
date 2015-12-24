//
//  AESEncryptor.h
//  MyTemplate
//
//  Created by qnsoft on 15/12/24.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 加密时候若没有密钥（currentAESKey），则随机生成256长度的密钥
 * 解密时候若没有密钥（currentAESKey），则返回－1
 *****/

typedef NS_ENUM(NSUInteger, QNAESKeyLength) {
    QNAESKeyLength128,
    QNAESKeyLength192,
    QNAESKeyLength256
};



@interface AESEncryptor : NSObject


//单例声明
//+(instancetype)sharedInstance;







#pragma mark --- public ---



-(NSString *) aesGenKeyWithBits:(QNAESKeyLength) aesKeyLength;            //生成指定长度的密钥




#pragma mark --- NSString ---


/**
 * 密钥长度为128/192/256通用的AES加密
 * return: NSString
 */
-(NSString *) aesEncryptString:(NSString *)plainString withAESKey:(NSString *) aesKey;

/**
 * 密钥长度为128/192/256通用的AES解密
 * return: NSString
 */
-(NSString *) aesDecryptString:(NSString *)cipherString withAESKey:(NSString *) aesKey;





#pragma mark --- NSData ---
/**
 * 密钥长度为128/192/256通用的AES加密
 * return: NSData
 */
-(NSData *) aesEncryptData:(NSData *)plainData withAESKey:(NSString *) aesKey;

/**
 * 密钥长度为128/192/256通用的AES解密
 * return: NSData
 */
-(NSData *) aesDecryptData:(NSData *)cipherData withAESKey:(NSString *) aesKey;

@end
