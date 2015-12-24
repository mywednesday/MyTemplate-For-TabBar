//
//  DataSecurityVC.m
//  MyTemplate
//
//  Created by qnsoft on 15/12/16.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "DataSecurityVC.h"
//#import "NSString+AES.h"
//#import "NSString+CLExtention.h"
#import "RSAEncryptor.h"
#import "AESEncryptor.h"




//#define kPublicKeyTag			"com.apple.sample.publickey"
//#define kPrivateKeyTag			"com.apple.sample.privatekey"
//#define kSymmetricKeyTag		"com.apple.sample.symmetrickey"
//
//static const uint8_t publicKeyIdentifier[]		= kPublicKeyTag;
//static const uint8_t privateKeyIdentifier[]		= kPrivateKeyTag;
//static const uint8_t symmetricKeyIdentifier[]	= kSymmetricKeyTag;



@interface DataSecurityVC ()

@property (nonatomic , strong) RSAEncryptor *rsaEncryptor;
@property (nonatomic , strong) AESEncryptor *aesEncryptor;
@property (nonatomic , strong) NSString *aesKey;


@end

@implementation DataSecurityVC {
    NSString *key;
//    RSAManager *rsaManager;     //默认生成长度位512的密钥

}


////使用代码写页面，初始化的时候调用
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
//    {
//        // Tag data to search for keys.
//        privateTag = [[NSData alloc] initWithBytes:privateKeyIdentifier length:sizeof(privateKeyIdentifier)];
//        publicTag = [[NSData alloc] initWithBytes:publicKeyIdentifier length:sizeof(publicKeyIdentifier)];
//        symmetricTag = [[NSData alloc] initWithBytes:symmetricKeyIdentifier length:sizeof(symmetricKeyIdentifier)];
//    }
//    
//    return self;
//}
//
////使用Storyboard的ViewController初始化的时候调用
//- (instancetype) initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder])
//    {
//        // Tag data to search for keys.
//        privateTag = [[NSData alloc] initWithBytes:privateKeyIdentifier length:sizeof(privateKeyIdentifier)];
//        publicTag = [[NSData alloc] initWithBytes:publicKeyIdentifier length:sizeof(publicKeyIdentifier)];
//        symmetricTag = [[NSData alloc] initWithBytes:symmetricKeyIdentifier length:sizeof(symmetricKeyIdentifier)];
//    }
//    
//    return self;
//}


-(void)viewDidLoad{
    self.aesEncryptor = [AESEncryptor new];
    self.aesKey = [self.aesEncryptor aesGenKeyWithBits:QNAESKeyLength256];
//    self.aesKey = [self.aesEncryptor aesGenKeyWithBits:QNAESKeyLength128];
    NSLog(@"\nself.aesKey = %@",self.aesKey);
    
//    rsaManager = [RSAManager new];
// 
//    
//    NSData *keyData = [rsaManager getPublicKeyBitsFromKey:nil];
//    NSLog(@"\nkeyData = %@",keyData);
//    NSString *keyString = [[NSString alloc] initWithData:keyData encoding:NSASCIIStringEncoding];
//    NSLog(@"\nkeyString = %@",keyString);
    
    
    
    
    self.rsaEncryptor = [[RSAEncryptor alloc] init];
    self.rsaEncryptor.curRSAKeyLength = QNRSAKeyLength2048;     //这里必须要设置密钥长度
    
   

}











//背景UIView点击事件
- (IBAction)backViewTouchDownAction:(id)sender {
    //关闭键盘
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}
//AES加密按钮事件
- (IBAction)encryptBtnAction {
    if (!self.originalTextView.text) {
        return;
    }
    
    NSLog(@"\nself.aesKey = %@",self.aesKey);
    self.encryptedLabel.text = [self.aesEncryptor aesEncryptString:self.originalTextView.text
                                                        withAESKey: self.aesKey];
//    [self.originalTextView.text aes256_encrypt:key];
    
    

}
//AES解密按钮事件
- (IBAction)DecryptBtnActioin {
    if (!self.encryptedLabel.text) {
        return;
    }
    
    
    NSLog(@"\nself.aesKey = %@",self.aesKey);
    self.decryptedLabel.text = [self.aesEncryptor aesDecryptString:self.encryptedLabel.text
                                                        withAESKey: self.aesKey];
    //[self.encryptedLabel.text aes256_decrypt:key];
}



//RSA加密按钮事件
- (IBAction)rsaEncryptBtnAction {
    
    if (!self.originalTextView.text) {
        return;
    }
    NSLog(@"\nplainTextLen = %lu",[self.originalTextView.text length]);
    NSString *restrinBASE64STRING = [self.rsaEncryptor rsaEncryptString:self.originalTextView.text];
    NSLog(@"\nrestrinBASE64STRING = %lu",[restrinBASE64STRING length]);
    NSLog(@"Encrypted: %@", restrinBASE64STRING);       // 请把这段字符串Copy到JAVA这边main()里做测试
    
    self.encryptedLabel.text = restrinBASE64STRING;
    
}


//RSA解密按钮事件
- (IBAction)rsaDencryptBtnAction {
    
    if (!self.encryptedLabel.text) {
        return;
    }
    NSLog(@"\nself.encryptedLabel.text = %@", self.encryptedLabel.text);
    NSString* decryptString = [self.rsaEncryptor rsaDecryptString: self.encryptedLabel.text];
    NSLog(@"Decrypted: %@", decryptString);
    
    self.decryptedLabel.text = decryptString;
}

//
//
//#pragma mark ---   Apple  官网例子 改写  ---
////
//////生成RSA密钥对
////- (void)generateRSAKeyPair:(NSUInteger)keySize {
////    
////    
////    
////    
////    OSStatus sanityCheck = noErr;
////    publicKeyRef = NULL;
////    privateKeyRef = NULL;
////    
////    NSAssert1( keySize == 512 || keySize == 1024 || keySize == 2048, @"%d is an invalid and unsupported key size.", keySize );
////    
////    // First delete current keys.
////    [self deleteAsymmetricKeys];
////    
////    // Container dictionaries.
////    NSMutableDictionary * privateKeyAttr = [[NSMutableDictionary alloc] init];
////    NSMutableDictionary * publicKeyAttr = [[NSMutableDictionary alloc] init];
////    NSMutableDictionary * keyPairAttr = [[NSMutableDictionary alloc] init];
////    
////    // Set top level dictionary for the keypair.
////    [keyPairAttr setObject:(id)kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
////    [keyPairAttr setObject:[NSNumber numberWithUnsignedInteger:keySize] forKey:(id)kSecAttrKeySizeInBits];
////    
////    // Set the private key dictionary.
////    [privateKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecAttrIsPermanent];
////    [privateKeyAttr setObject:privateTag forKey:(id)kSecAttrApplicationTag];
////    // See SecKey.h to set other flag values.
////    
////    // Set the public key dictionary.
////    [publicKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecAttrIsPermanent];
////    [publicKeyAttr setObject:publicTag forKey:(id)kSecAttrApplicationTag];
////    // See SecKey.h to set other flag values.
////    
////    // Set attributes to top level dictionary.
////    [keyPairAttr setObject:privateKeyAttr forKey:(id)kSecPrivateKeyAttrs];
////    [keyPairAttr setObject:publicKeyAttr forKey:(id)kSecPublicKeyAttrs];
////    
////    // SecKeyGeneratePair returns the SecKeyRefs just for educational purposes.
////    sanityCheck = SecKeyGeneratePair((CFDictionaryRef)keyPairAttr, &publicKeyRef, &privateKeyRef);
////    NSAssert( sanityCheck == noErr && publicKeyRef != NULL && privateKeyRef != NULL, @"Something really bad went wrong with generating the key pair." );
////    
//////    [privateKeyAttr release];
//////    [publicKeyAttr release];
//////    [keyPairAttr release];
////}
////
////
////- (void)deleteAsymmetricKeys {
////    OSStatus sanityCheck = noErr;
////    NSMutableDictionary * queryPublicKey = [[NSMutableDictionary alloc] init];
////    NSMutableDictionary * queryPrivateKey = [[NSMutableDictionary alloc] init];
////    
////    // Set the public key query dictionary.
////    [queryPublicKey setObject:(id)kSecClassKey forKey:(id)kSecClass];
////    [queryPublicKey setObject:publicTag forKey:(id)kSecAttrApplicationTag];
////    [queryPublicKey setObject:(id)kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
////    
////    // Set the private key query dictionary.
////    [queryPrivateKey setObject:(id)kSecClassKey forKey:(id)kSecClass];
////    [queryPrivateKey setObject:privateTag forKey:(id)kSecAttrApplicationTag];
////    [queryPrivateKey setObject:(id)kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
////    
////    // Delete the private key.
////    sanityCheck = SecItemDelete((CFDictionaryRef)queryPrivateKey);
////    NSAssert1(sanityCheck == noErr || sanityCheck == errSecItemNotFound, @"Error removing private key, OSStatus == %d.", sanityCheck );
////    
////    // Delete the public key.
////    sanityCheck = SecItemDelete((CFDictionaryRef)queryPublicKey);
////    NSAssert1( sanityCheck == noErr || sanityCheck == errSecItemNotFound, @"Error removing public key, OSStatus == %d.", sanityCheck );
////    
////    if (publicKeyRef) CFRelease(publicKeyRef);
////    if (privateKeyRef) CFRelease(privateKeyRef);
////}
////
//
//
//
//#pragma mark ---   使用OpenSSL生成der类型的证书  ---
//
//// 我们在前面使用openssl生成的public_key.der文件的base64值，用你自己的替换掉这里
//#define RSA_KEY_BASE64 @"MIIC5DCCAk2gAwIBAgIJALUk4hrYth9oMA0GCSqGSIb3DQEBBQUAMIGKMQswCQYDVQQGEwJ\
//DTjERMA8GA1UECAwIU2hhbmdoYWkxETAPBgNVBAcMCFNoYW5naGFpMQ4wDAYDVQQKDAVCYWl5aTEOMAwGA1UECwwFQmFpeWk\
//xEDAOBgNVBAMMB1lvcmsuR3UxIzAhBgkqhkiG9w0BCQEWFGd5cTUzMTk5MjBAZ21haWwuY29tMB4XDTExMTAyNjAyNDUzMlo\
//XDTExMTEyNTAyNDUzM1owgYoxCzAJBgNVBAYTAkNOMREwDwYDVQQIDAhTaGFuZ2hhaTERMA8GA1UEBwwIU2hhbmdoYWkxDjA\
//MBgNVBAoMBUJhaXlpMQ4wDAYDVQQLDAVCYWl5aTEQMA4GA1UEAwwHWW9yay5HdTEjMCEGCSqGSIb3DQEJARYUZ3lxNTMxOTk\
//yMEBnbWFpbC5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAK3cKya7oOi8jVMkRGVuNn/SiSS1y5knKLh6t98JukB\
//DJZqo30LVPXXL9nHcYXBTulJgzutCOGQxw8ODfAKvXYxmX7QvLwlJRFEzrqzi3eAM2FYtZZeKbgV6PximOwCG6DqaFqd8X0W\
//ezP1B2eWKz4kLIuSUKOmt0h3RpIPkatPBAgMBAAGjUDBOMB0GA1UdDgQWBBSIiLi2mehEgi/MwRZOld1mLlhl7TAfBgNVHSM\
//EGDAWgBSIiLi2mehEgi/MwRZOld1mLlhl7TAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBBQUAA4GBAB0GUsssoVEDs9vQxk0\
//DzNr8pB0idfI+Farl46OZnW5ZwPu3dvSmhQ+yRdh7Ba54JCyvRy0JcWB+fZgO4QorNRbVVbBSuPg6wLzPuasy9TpmaaYaLLK\
//Iena6Z60aFWRwhazd6+hIsKTMTExaWjndblEbhAsjdpg6QMsKurs9+izr"
//
//static SecKeyRef _public_key=nil;
//+ (SecKeyRef) getPublicKey{ // 从公钥证书文件中获取到公钥的SecKeyRef指针
//    if(_public_key == nil){
////        NSData *certificateData = [Base64 decode:RSA_KEY_BASE64];
//        NSData *certificateData = [[NSData alloc] initWithBase64EncodedString:RSA_KEY_BASE64
//                                                                      options:NSDataBase64DecodingIgnoreUnknownCharacters];
//        SecCertificateRef myCertificate =  SecCertificateCreateWithData(kCFAllocatorDefault, (CFDataRef)certificateData);
//        SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
//        SecTrustRef myTrust;
//        OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
//        SecTrustResultType trustResult;
//        if (status == noErr) {
//            status = SecTrustEvaluate(myTrust, &trustResult);
//        }
//        _public_key = SecTrustCopyPublicKey(myTrust);
//        CFRelease(myCertificate);
//        CFRelease(myPolicy);
//        CFRelease(myTrust);
//    }
//    return _public_key;
//}
//
//+ (NSData*) rsaEncryptString:(NSString*) string{
//    SecKeyRef key = [self getPublicKey];
//    size_t cipherBufferSize = SecKeyGetBlockSize(key);
//    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
//    NSData *stringBytes = [string dataUsingEncoding:NSUTF8StringEncoding];
//    size_t blockSize = cipherBufferSize - 11;
//    size_t blockCount = (size_t)ceil([stringBytes length] / (double)blockSize);
//    NSMutableData *encryptedData = [[NSMutableData alloc] init];
//    for (int i=0; i<blockCount; i++) {
//        int bufferSize = MIN(blockSize,[stringBytes length] - i * blockSize);
//        NSData *buffer = [stringBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
//        OSStatus status = SecKeyEncrypt(key, kSecPaddingPKCS1, (const uint8_t *)[buffer bytes],
//                                        [buffer length], cipherBuffer, &cipherBufferSize);
//        if (status == noErr){
//            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
//            [encryptedData appendData:encryptedBytes];
////            [encryptedBytes release];
//        }else{
//            if (cipherBuffer) free(cipherBuffer);
//            return nil;
//        }
//    }
//    if (cipherBuffer) free(cipherBuffer);
//    //  NSLog(@"Encrypted text (%d bytes): %@", [encryptedData length], [encryptedData description]);
//    //  NSLog(@"Encrypted text base64: %@", [Base64 encode:encryptedData]);
//    return encryptedData;
//}
//
//


@end
