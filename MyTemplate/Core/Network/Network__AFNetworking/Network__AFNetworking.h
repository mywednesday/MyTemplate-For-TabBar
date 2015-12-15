//
//  CustomNetworkEngine_AFNetworking.h
//  MyTemplate
//
//  Created by qnsoft on 15/10/27.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkError__AFNetworking.h"
#import <AFNetworking/AFNetworking.h>


typedef NS_ENUM(NSInteger, XWRequestStatus)
{
    XWRequestSuccess,
    XWRequestFailure
};

typedef void(^XWCompletionBlock)(XWRequestStatus status, NSDictionary *data, NetworkError__AFNetworking *xwError);
typedef void(^XWDownloadCompletionBlock)(XWRequestStatus status, NSURLResponse *urlResponse, NetworkError__AFNetworking *xwError);





@interface Network__AFNetworking : NSObject



@property (nonatomic, strong)AFHTTPRequestOperationManager *reqOPManager;
+ (instancetype)sharedInstance;
- (NSDictionary *)getHttpHeader;
- (void)postRequestUrlPath:(NSString *)strUrlPath dictParams:(NSMutableDictionary *)dictParams completionBlock:(XWCompletionBlock)completionBlock;
- (void)postRequestUrlPath:(NSString *)strUrlPath files:(NSArray *)files names:(NSArray *)names fileNames:(NSArray *)fileNames mimeTypes:(NSArray *)mimeTypes dictParams:(NSMutableDictionary *)dictParams completionBlock:(XWCompletionBlock)completionBlock;
-(void)downloadFileFromURLStr:(NSString *)fromURLStr toCachePathFileName:(NSString *)fileName completion:(XWDownloadCompletionBlock)downloadCompletionBlock;



@end
