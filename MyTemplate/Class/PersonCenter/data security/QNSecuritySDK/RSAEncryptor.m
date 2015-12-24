//
//  RSAEncryptor.m
//  MyTemplate
//
//  Created by qnsoft on 15/12/23.
//  Copyright © 2015年 wzp. All rights reserved.
//


#import "RSAEncryptor.h"

#import <Security/Security.h>
#import "NSData+Base64.h"



#define kPrivateKeyPasswordForRSALen512 @"kPrivateKeyPasswordForRSALen512"
#define kPrivateKeyPasswordForRSALen1024 @"kPrivateKeyPasswordForRSALen1024"
#define kPrivateKeyPasswordForRSALen2048 @"kPrivateKeyPasswordForRSALen2048"

@interface RSAEncryptor ()

@property (nonatomic, strong) NSString *privateKeyPassword;       //私钥密码,请换成你生成p12时的密码,这个密码一定要对，不然拿不到私钥

@end





@implementation RSAEncryptor
{
    SecKeyRef publicKey;
    SecKeyRef privateKey;
//    NSString *privateKeyPassword;       //私钥密码,请换成你生成p12时的密码,这个密码一定要对，不然拿不到私钥
}


-(void)dealloc
{
    CFRelease(publicKey);
    CFRelease(privateKey);
}



-(SecKeyRef) getPublicKey {
    return publicKey;
}

-(SecKeyRef) getPrivateKey {
    return privateKey;
}

- (NSString *) privateKeyPassword {
    if (QNRSAKeyLength512 == _curRSAKeyLength) {
//        return @"123456789";
        return [[NSUserDefaults standardUserDefaults] stringForKey:kPrivateKeyPasswordForRSALen512];
    } else if (QNRSAKeyLength1024 == _curRSAKeyLength) {
//        return @"BJchannels0ft";
        return [[NSUserDefaults standardUserDefaults] stringForKey:kPrivateKeyPasswordForRSALen1024];
    } else if (QNRSAKeyLength2048 == _curRSAKeyLength) {
//        return @"BJchannels0ft";
        return [[NSUserDefaults standardUserDefaults] stringForKey:kPrivateKeyPasswordForRSALen2048];
    }
    
    return @"";
}

/**
 * 将用于解析私钥文件的密码  存储在本地文件
 */
- (void) savePrivateKeyPasswordToLocalFile {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"BJchannels0ft" forKey:kPrivateKeyPasswordForRSALen512];
    [[NSUserDefaults standardUserDefaults] setObject:@"BJchannels0ft" forKey:kPrivateKeyPasswordForRSALen1024];
    [[NSUserDefaults standardUserDefaults] setObject:@"BJchannels0ft" forKey:kPrivateKeyPasswordForRSALen2048];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void) setCurRSAKeyLength:(QNRSAKeyLength) curRSAKeyLength {
    
    _curRSAKeyLength = curRSAKeyLength;
    NSString *publicKeyPath = nil;
    NSString *privateKeyPath = nil;
    //获取证书路径
    if (QNRSAKeyLength512 == curRSAKeyLength) {
        
        publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key512" ofType:@"der"];
        privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key512" ofType:@"p12"];
        //获取公钥\私钥
        [self loadPublicKeyFromFile: publicKeyPath];
        [self loadPrivateKeyFromFile: privateKeyPath password:self.privateKeyPassword];
        return;
    } else if (QNRSAKeyLength1024 == curRSAKeyLength) {
        
        publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key1024" ofType:@"der"];
        privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key1024" ofType:@"p12"];
        //获取公钥\私钥
        [self loadPublicKeyFromFile: publicKeyPath];
        [self loadPrivateKeyFromFile: privateKeyPath password:self.privateKeyPassword];
        return;
    } else if (QNRSAKeyLength2048 == curRSAKeyLength) {
        
        publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key2048" ofType:@"der"];
        privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key2048" ofType:@"p12"];
        //获取公钥\私钥
        [self loadPublicKeyFromFile: publicKeyPath];
        [self loadPrivateKeyFromFile: privateKeyPath password:self.privateKeyPassword];
        return;
    }
    
    
//    
//    //获取公钥\私钥
//    [self loadPublicKeyFromFile: publicKeyPath];
//    [self loadPrivateKeyFromFile: privateKeyPath password:self.privateKeyPassword];
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.curRSAKeyLength = QNRSAKeyLengthZero;
        [self savePrivateKeyPasswordToLocalFile];
    }
    
    return self;
}










-(void) loadPublicKeyFromFile: (NSString*) derFilePath
{
    if(![derFilePath length])
        return;
    NSData *derData = [[NSData alloc] initWithContentsOfFile:derFilePath];
    [self loadPublicKeyFromData: derData];
}
-(void) loadPublicKeyFromData: (NSData*) derData
{
    publicKey = [self getPublicKeyRefrenceFromeData: derData];
}

-(void) loadPrivateKeyFromFile: (NSString*) p12FilePath password:(NSString*)p12Password
{
    if(![p12FilePath length])
        return;
    
    NSData *p12Data = [NSData dataWithContentsOfFile:p12FilePath];
    [self loadPrivateKeyFromData: p12Data password:p12Password];
}

-(void) loadPrivateKeyFromData: (NSData*) p12Data password:(NSString*)p12Password
{
    privateKey = [self getPrivateKeyRefrenceFromData: p12Data password: p12Password];
}




#pragma mark - Private Methods

-(SecKeyRef) getPublicKeyRefrenceFromeData: (NSData*)derData
{
    SecCertificateRef myCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)derData);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
    SecTrustResultType trustResult;
    if (status == noErr) {
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    SecKeyRef securityKey = SecTrustCopyPublicKey(myTrust);
    CFRelease(myCertificate);
    CFRelease(myPolicy);
    CFRelease(myTrust);
    
    return securityKey;
}


-(SecKeyRef) getPrivateKeyRefrenceFromData: (NSData*)p12Data password:(NSString*)password
{
    SecKeyRef privateKeyRef = NULL;
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    [options setObject: password forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) p12Data, (__bridge CFDictionaryRef)options, &items);
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        if (securityError != noErr) {
            privateKeyRef = NULL;
        }
    }
    CFRelease(items);
    
    return privateKeyRef;
}



#pragma mark - Encrypt

-(NSString*) rsaEncryptString:(NSString*)string {
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData* encryptedData = [self rsaEncryptData: data];
    NSString* base64EncryptedString = [encryptedData base64EncodedString];
    return base64EncryptedString;
}

// 加密的大小受限于SecKeyEncrypt函数，SecKeyEncrypt要求明文和密钥的长度一致，如果要加密更长的内容，需要把内容按密钥长度分成多份，然后多次调用SecKeyEncrypt来实现
-(NSData*) rsaEncryptData:(NSData*)data {
    SecKeyRef key = [self getPublicKey];
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    size_t blockSize = cipherBufferSize - 11;       // 分段加密
    size_t blockCount = (size_t)ceil([data length] / (double)blockSize);
    NSMutableData *encryptedData = [[NSMutableData alloc] init] ;
    for (int i=0; i<blockCount; i++) {
        int bufferSize = MIN(blockSize,[data length] - i * blockSize);
        NSData *buffer = [data subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(key, kSecPaddingPKCS1, (const uint8_t *)[buffer bytes], [buffer length], cipherBuffer, &cipherBufferSize);
        if (status == noErr){
            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
        }else{
            if (cipherBuffer) {
                free(cipherBuffer);
            }
            return nil;
        }
    }
    if (cipherBuffer){
        free(cipherBuffer);
    }
    return encryptedData;
}




#pragma mark - Decrypt

-(NSString*) rsaDecryptString:(NSString*)string {
    NSData* data = [NSData dataFromBase64String: string];
    NSData* decryptData = [self rsaDecryptData: data];
    NSString* result = [[NSString alloc] initWithData: decryptData encoding:NSUTF8StringEncoding];
    return result;
}

-(NSData*) rsaDecryptData:(NSData*)data {
    SecKeyRef key = [self getPrivateKey];
    size_t cipherLen = [data length];
    void *cipher = malloc(cipherLen);
    [data getBytes:cipher length:cipherLen];
    size_t plainLen = SecKeyGetBlockSize(key) - 12;
    void *plain = malloc(plainLen);
    OSStatus status = SecKeyDecrypt(key, kSecPaddingPKCS1, cipher, cipherLen, plain, &plainLen);
    
    if (status != noErr) {
        return nil;
    }
    
    NSData *decryptedData = [[NSData alloc] initWithBytes:(const void *)plain length:plainLen];
    
    return decryptedData;
}








#pragma mark - Class Methods

static RSAEncryptor* sharedInstance = nil;

+(void) setSharedInstance: (RSAEncryptor*)instance
{
    sharedInstance = instance;
}

+(RSAEncryptor*) sharedInstance
{
    return sharedInstance;
}

@end