//
//  AESEncryptor.m
//  MyTemplate
//
//  Created by qnsoft on 15/12/24.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "AESEncryptor.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>




#define kUserDefaultsAESKey @"kUserDefaultsAESKey"



//用于生成AES随机密钥的源数据
const static char randomCharSource[] = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";


@interface AESEncryptor ()

@property (nonatomic, strong) NSString *currentAESKey;          //当前的AES密钥

@end
@implementation AESEncryptor {
//     NSString *currentAESKey;
}





////单例定义
//+(instancetype)sharedInstance{
//    return [self new];
//}
//
//+(instancetype)allocWithZone:(struct _NSZone *)zone{
//    static id instance;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [super allocWithZone:zone];
//    });
//    return instance;
//}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentAESKey = @"";
        [self saveCurrentAESKey:self.currentAESKey];
    }
    
    return self;
}



-(void) saveCurrentAESKey:(NSString *) aesKey {
//    NSUserDefaults *myUserDefaults = [NSUserDefaults standardUserDefaults];
//    [myUserDefaults setObject:aesKey forKey:kUserDefaultsAESKey];
//    [myUserDefaults synchronize];
    
    self.currentAESKey = aesKey;
    [[NSUserDefaults standardUserDefaults] setObject:aesKey forKey:kUserDefaultsAESKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(NSString *) getCurrentAESKey {
    self.currentAESKey = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsAESKey];
    NSLog(@"\nself.currentAESKey = %@",self.currentAESKey);
    return self.currentAESKey;
}





#pragma mark --- NSString ---
/**
 * 密钥长度为128/192/256通用的AES加密
 * return: NSString
 */
-(NSString *) aesEncryptString:(NSString *)plainString withAESKey:(NSString *)aesKey {
    //    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    //    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //    NSLog(@"\n%@",data);
    
    if (![aesKey length]) {
        self.currentAESKey = [self getCurrentAESKey];
        aesKey = self.currentAESKey;
    }
    
    
    NSData *data = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    //    NSLog(@"\n%@",data);
    //对数据进行加密
    NSData* result = [self aesDecryptData:data withAESKey:aesKey];
    
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



/**
 * 密钥长度为128/192/256通用的AES解密
 * return: NSString
 */
-(NSString *) aesDecryptString:(NSString *)cipherString withAESKey:(NSString *)aesKey {
    
    NSLog(@"\naesKey = %@",aesKey);
    if (![aesKey length]) {
        self.currentAESKey = [self getCurrentAESKey];
        aesKey = self.currentAESKey;
    }
    
    aesKey = self.currentAESKey;
    
    
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:cipherString.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [cipherString length] / 2; i++) {
        byte_chars[0] = [cipherString characterAtIndex:i*2];
        byte_chars[1] = [cipherString characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [self aesDecryptData:data withAESKey:aesKey];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    
    
    return nil;
}










#pragma mark --- NSData ---
/**
 * 密钥长度为128/192/256通用的AES加密
 * return: NSData
 */
- (NSData *) aesEncryptData:(NSData *)plainData withAESKey:(NSString *)aesKey   //加密
{
    char keyPtr[kCCKeySizeAES256+1];        //这里选用256可用空间最大
    bzero(keyPtr, sizeof(keyPtr));
    [aesKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [plainData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [plainData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}


/**
 * 密钥长度为128/192/256通用的AES解密
 * return: NSData
 */
- (NSData *) aesDecryptData:(NSData *)cipherData withAESKey:(NSString *)aesKey   //解密
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [aesKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [cipherData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [cipherData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    free(buffer);
    return nil;
}



#pragma mark --- common ---
/**
 * 生成指定长度的密钥
 */
-(NSString *) aesGenKeyWithBits:(QNAESKeyLength) aesKeyLength{
    NSUInteger bits = [self changeQNAESKeyLengthToNSUInteger:aesKeyLength];
    char data[bits];
    u_int32_t randomCharSourceLength = (u_int32_t)strlen(randomCharSource);
    for (int i = 0; i < bits; i++) {
        data[i] = randomCharSource[arc4random_uniform(randomCharSourceLength)];
//        data[i] = c;
    }
    
    NSString *tmpKey = [[NSString alloc] initWithBytes:data length:bits encoding:NSUTF8StringEncoding];
    [self saveCurrentAESKey: tmpKey];
    return tmpKey;
}

/**
 * 将QNAESKeyLength转换成对应的NSUInteger长度
 */
- (NSUInteger) changeQNAESKeyLengthToNSUInteger:(QNAESKeyLength) aesKeyLength {
    NSUInteger retLength = 0;
    switch (aesKeyLength) {
        case QNAESKeyLength128:
            retLength = 128;
            break;
        case QNAESKeyLength192:
            retLength = 192;
            break;
        case QNAESKeyLength256:
            retLength = 256;
            break;
        default:
            break;
    }
    return retLength;
}





@end
