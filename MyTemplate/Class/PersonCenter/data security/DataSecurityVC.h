//
//  DataSecurityVC.h
//  MyTemplate
//
//  Created by qnsoft on 15/12/16.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "BaseVC.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>



@interface DataSecurityVC : BaseVC {
//    NSData * publicTag;
//    NSData * privateTag;
//    NSData * symmetricTag;
//    CCOptions typeOfSymmetricOpts;
//    SecKeyRef publicKeyRef;
//    SecKeyRef privateKeyRef;
//    NSData * symmetricKeyRef;
}




@property (weak, nonatomic) IBOutlet UITextView *originalTextView;      //要加密的文字
@property (weak, nonatomic) IBOutlet UILabel *encryptedLabel;           //加密后的文字Label
@property (weak, nonatomic) IBOutlet UILabel *decryptedLabel;           //解密后的文字Label
- (IBAction)encryptBtnAction;   //AES加密按钮事件
- (IBAction)DecryptBtnActioin;  //AES解密按钮事件
- (IBAction)rsaEncryptBtnAction; //RSA加密按钮事件
- (IBAction)rsaDencryptBtnAction;   //RSA解密按钮事件

//背景UIView点击事件
- (IBAction)backViewTouchDownAction:(id)sender;

@end
