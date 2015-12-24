//
//  NSData+AES.h
//  MyTemplate
//
//  Created by qnsoft on 15/12/16.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)


/**
 * 密钥长度为128/192/256通用的AES加密
 * return: NSData
 */
-(NSData *) aes256_encrypt:(NSString *)key;

/**
 * 密钥长度为128/192/256通用的AES加密
 * return: NSData
 */
-(NSData *) aes256_decrypt:(NSString *)key;
@end
