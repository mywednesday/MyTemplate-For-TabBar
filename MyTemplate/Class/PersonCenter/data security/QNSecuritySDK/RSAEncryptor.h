//
//  RSAEncryptor.h
//  MyTemplate
//
//  Created by qnsoft on 15/12/23.
//  Copyright © 2015年 wzp. All rights reserved.
//
#import <Foundation/Foundation.h>


typedef NS_ENUM (NSUInteger, QNRSAKeyLength) {
    QNRSAKeyLengthZero = 0,
    QNRSAKeyLength512 = 512,
    QNRSAKeyLength1024 = 1024,
    QNRSAKeyLength2048 = 2048
};





@interface RSAEncryptor : NSObject

@property (nonatomic, assign) QNRSAKeyLength curRSAKeyLength;
//@property (nonatomic, strong) NSString *publicKeyPath;
//@property (nonatomic, strong) NSString *privateKeyPath;



#pragma mark - Instance Methods

-(void) loadPublicKeyFromFile: (NSString*) derFilePath;
-(void) loadPublicKeyFromData: (NSData*) derData;

-(void) loadPrivateKeyFromFile: (NSString*) p12FilePath password:(NSString*)p12Password;
-(void) loadPrivateKeyFromData: (NSData*) p12Data password:(NSString*)p12Password;




-(NSString*) rsaEncryptString:(NSString*)string;
-(NSData*) rsaEncryptData:(NSData*)data ;

-(NSString*) rsaDecryptString:(NSString*)string;
-(NSData*) rsaDecryptData:(NSData*)data;





#pragma mark - Class Methods

+(void) setSharedInstance: (RSAEncryptor*)instance;
+(RSAEncryptor*) sharedInstance;

@end