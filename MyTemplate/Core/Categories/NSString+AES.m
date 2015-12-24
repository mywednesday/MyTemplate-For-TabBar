//
//  NSString+AES.m
//  MyTemplate
//
//  Created by qnsoft on 15/12/16.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "NSString+AES.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+AES.h"



@implementation NSString (AES)




-(NSString *) aes256_encrypt:(NSString *)key
{
//    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:self.length];
//    NSLog(@"\n%@",data);
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"\n%@",data);
    //对数据进行加密
    NSData *result = [data aes256_encrypt:key];
    
    //转换为2进制字符串
    if (result && result.length > 0) {
        
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

-(NSString *) aes256_decrypt:(NSString *)key
{
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [data aes256_decrypt:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
