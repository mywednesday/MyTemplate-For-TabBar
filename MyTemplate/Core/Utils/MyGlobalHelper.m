//
//  MyGlobalHelper.m
//  MyTemplate
//
//  Created by qnsoft on 15/9/21.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyGlobalHelper.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>


//#import "RegexKitLite.h"
//#import <SSKeychain/SSKeychain.h>
//#import "XWUserManager.h"
//#import "SQLiteInstanceManager.h"




@implementation MyGlobalHelper



+ (instancetype)sharedHelper {
    static MyGlobalHelper *_sharedHelper = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedHelper = [[self alloc] init];
    });
    
    return _sharedHelper;
}

- (instancetype)init{
    self = [super init];
    if (self) {
    
    }
    return self;
}




/**项目文件路径相关*/
+ (NSString *) getSandboxDirectoryForHome{
    return NSHomeDirectory();
}
+ (NSString *) getSandboxDirectoryForDocuments{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return docDir;
}
+ (NSString *) getSandboxDirectoryForCaches{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}
+ (NSString *) getSandboxDirectoryForTmp{
    NSString *tmpDir = NSTemporaryDirectory();
    return tmpDir;
}




// 判断是否为手机号
+ (BOOL)isPhoneNumberFormat:(NSString *)accountStr {
    BOOL ret = NO;
    if(accountStr.length != 0) {
//        ret = [accountStr isMatchedByRegex:@"\\b(1[0-9]{10})\\b"];
    } else {
        ret = NO;
    }
    return ret;
    
}

// 判断是否为邮箱
+ (BOOL)isEmailFormat:(NSString *)accountStr {
    BOOL ret;
    if(accountStr.length != 0) {
//        ret = [accountStr isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
    } else {
        ret = NO;
    }
    return ret;
}

// 判断是否为6位数字
+ (BOOL)isVerifyCodeFormat:(NSString *)codeStr {
    BOOL ret;
    if(codeStr.length != 0) {
//        ret = [codeStr isMatchedByRegex:@"\\b([0-9]{6})\\b"];
    } else {
        ret = NO;
    }
    return ret;
}

// 判断是否为密码格式
+ (BOOL)isCorrectPasswordFormat:(NSString *)pwdStr {
    BOOL ret;
    if(pwdStr.length != 0) {
//        ret = [pwdStr isMatchedByRegex:@"\\b([a-zA-Z0-9]{6,16})\\b"];
    } else {
        ret = NO;
    }
    return ret;
}

// 判断是否为空格字符串
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}

// 判断是否为整数
+ (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (NSString *)getCachePathWithFileName:(NSString *)filename
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    NSString *cacheDir = [cachePaths objectAtIndex:0];
    if (filename) {
        return [cacheDir stringByAppendingPathComponent:filename];
    }else{
        return cacheDir;
    }
}

+(int)calculateTextNumber:(NSString *) textA
{
    int number = 0;
    int index = 0;
    for (index=0; index < [textA length]; index++) {
        
        NSString *character = [textA substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            number += 2;
        } else {
            number++;
        }
    }
    //    return ceil(number);
    return number;
}

+(NSString*)systemVersion{
    return [UIDevice currentDevice].systemVersion;
}

// Codes are from
// http://stackoverflow.com/questions/448162/determine-device-iphone-ipod-touch-with-iphone-sdk
// Thanks for sss and UIBuilder
+ (NSString *)deviceType
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    return platform;
}

+(NSString*)resolustionPixel{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    int width = (int)MIN(screenSize.width, screenSize.height)*scale;
    int height = (int)MAX(screenSize.width, screenSize.height)*scale;
    return [NSString stringWithFormat:@"%dx%d",width,height];
}

+ (NSString *)getIOSUUID
{

//    NSString *uuidInUserDefault = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceId"];
//    if(uuidInUserDefault == nil || [uuidInUserDefault isEqualToString:@""]){
//        NSString* bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*) kCFBundleIdentifierKey];
//        NSString *retrieveuuid = [SSKeychain passwordForService:bundleID account:@"uuid"];
//        
//        if ( retrieveuuid == nil || [retrieveuuid isEqualToString:@""]){ // defaults中不存在，keychain中也不存在，则生成，并在两处存储
//            CFUUIDRef theUUID = CFUUIDCreate(NULL);
//            CFStringRef string = CFUUIDCreateString(NULL, theUUID);
//            CFRelease(theUUID);
//            retrieveuuid = (__bridge NSString*)string;
//            
//            [SSKeychain setPassword:retrieveuuid forService:bundleID account:@"uuid"]; //keychain有可能存储不成功
//            
//            [[NSUserDefaults standardUserDefaults] setObject:retrieveuuid forKey:@"deviceId"]; // 存储新生成的id
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }else{
//            [[NSUserDefaults standardUserDefaults] setObject:retrieveuuid forKey:@"deviceId"]; // 存储keychain中的id
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
//        return retrieveuuid;
//    }else{
//        NSString* bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*) kCFBundleIdentifierKey];
//        NSString *retrieveuuid = [SSKeychain passwordForService:bundleID account:@"uuid"];
//        
//        if ( retrieveuuid == nil || [retrieveuuid isEqualToString:@""]){ // keychain中还没有，则存储到keychain
//            [SSKeychain setPassword:uuidInUserDefault forService:bundleID account:@"uuid"];
//        }
//        return uuidInUserDefault;
//    }
    
    
    return nil;
}

+ (CGFloat)getScreenWidth{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    int width = (int)MIN(screenSize.width, screenSize.height);
    return width;
}

+ (CGFloat)getScreenHeight{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    int height = (int)MAX(screenSize.width, screenSize.height);
    return height;
}

+ (NSString *)getAppVersion{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size allowEnlarge:(BOOL)allowEnlarge
{
    
//    DDLogDebug(@"originalImage.size:%@",NSStringFromCGSize(originalImage.size));
    
    //avoid redundant drawing
    if (CGSizeEqualToSize(originalImage.size, size))
    {
        return originalImage;
    }
    
    // 不允许放大
    if(!allowEnlarge && ((originalImage.size.width<size.width) && (originalImage.size.height<size.height))){
        return originalImage;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    //draw
    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
//    DDLogDebug(@"scaled image.size:%@",NSStringFromCGSize(image.size));
    
    //return image
    return image;
}

+ (UIImage *)image:(UIImage *)originalImage toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(originalImage.size.width * scaleSize, originalImage.size.height * scaleSize));
    [originalImage drawInRect:CGRectMake(0, 0, originalImage.size.width * scaleSize, originalImage.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


/**
 将UIImage转换为base64编码的字符串，方便上传后台数据库
 */
- (NSString *)convertImageToNSString :(UIImage *) image {
    NSData *data;
    NSString *logoBase64Str;
    UIImage *resizedImage;
    if(image){
        resizedImage = [MyGlobalHelper image:image scaledToSize:CGSizeMake(77, 77) allowEnlarge:NO];
        if (UIImagePNGRepresentation(resizedImage) == nil) {
            data = [UIImageJPEGRepresentation(resizedImage, 1) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
        } else {
            data = [UIImagePNGRepresentation(resizedImage) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
        }
        
        logoBase64Str = [NSString stringWithUTF8String:[data bytes]];
    }else{
        logoBase64Str = @"";
    }
    
    return logoBase64Str;
}




+ (NSString *)getHeadImageDir{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *headImageDirectory = [docPath stringByAppendingPathComponent:@"UserHeadImage"];
    BOOL isDir;
    NSError *err;
    BOOL succeed = YES;
    
    // 保存Project文件路径
    if(![fileManager fileExistsAtPath:headImageDirectory isDirectory:&isDir] || !isDir){
        succeed = [fileManager createDirectoryAtPath:headImageDirectory withIntermediateDirectories:YES attributes:nil error:&err];
    }
    if(!succeed){
//        DDLogError(@"创建文件夹%@错误:%@",headImageDirectory,err);
        return nil;
    }
    
    return headImageDirectory;
    
}

+ (CGSize)calculateStringSize:(NSString *)str font:(UIFont *)font width:(CGFloat)width
{
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                    options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                 attributes:@{ NSFontAttributeName: font }
                                    context:nil].size;
    return size;
}


+ (BOOL)switchToCurrentUserDataBase{
//    NSString *dbFileSuffix;
//    XWLoginFlag loginFlag = [[XWUserManager sharedUserManager] getUserLoginFlag];
//    if(loginFlag == XWLoginUserFlag || loginFlag == XWThirdUserFlag){
//        dbFileSuffix = [[XWUserManager sharedUserManager] getLoginUserId];
//    }else{
//        dbFileSuffix = @"local";
//    }
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
//    NSString *userDBFileDir = [docPath stringByAppendingPathComponent:@"UserDBs"];
//    NSString *userDBFilePath = [[userDBFileDir stringByAppendingPathComponent:[NSString stringWithFormat:@"SQLPO_%@",dbFileSuffix]] stringByAppendingPathExtension:@"db"];
//    
//    // DB文件路径
//    if(![fileManager fileExistsAtPath:userDBFileDir]){
//        NSError *err;
//        BOOL succeed = YES;
//        succeed = [fileManager createDirectoryAtPath:userDBFileDir withIntermediateDirectories:YES attributes:nil error:&err];
//        if(!succeed){
//            DDLogError(@"创建文件夹%@错误:%@",userDBFileDir,err);
//            return NO;
//        }
//    }
//    
//    SQLiteInstanceManager *manager = [SQLiteInstanceManager sharedManager];
//    if(![userDBFilePath isEqualToString:[manager databaseFilepath]])
//    {
//        [manager closeDatabase];
//        [manager setDatabaseFilepath:userDBFilePath];
//        [manager database];
//    }
    return YES;
    
}

+ (UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor colorWithRed: (float)redByte / 0xff
                             green: (float)greenByte/ 0xff
                              blue: (float)blueByte / 0xff
                             alpha:1.0];
    return result;
}



+ (NSDate *)getDateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}
+ (NSString *)getStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}



+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}


+ (NSString *)getBundleId{
    NSString* bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*) kCFBundleIdentifierKey];
    return bundleID;
}

//取消UITableView多余的分割线
+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (BOOL)autoriseCamera
{
    BOOL isCameraValid = NO;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusAuthorized || authStatus == AVAuthorizationStatusNotDetermined)
    {
        isCameraValid = YES;
    }
    return isCameraValid;
}



@end
