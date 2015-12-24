//
//  NSString+AES.h
//  MyTemplate
//
//  Created by qnsoft on 15/12/16.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface NSString (AES)

/**
 * 密钥长度为256的AES加密
 * return: NSString
 */
-(NSString *) aes256_encrypt:(NSString *)key;

/**
 * 密钥长度为256的AES解密
 * return: NSString
 */
-(NSString *) aes256_decrypt:(NSString *)key;

@end
