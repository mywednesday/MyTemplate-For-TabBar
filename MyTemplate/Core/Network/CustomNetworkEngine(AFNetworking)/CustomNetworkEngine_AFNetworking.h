//
//  CustomNetworkEngine_AFNetworking.h
//  MyTemplate
//
//  Created by qnsoft on 15/10/27.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomNetworkError_AFNetworking.h"
#import <AFNetworking/AFNetworking.h>


typedef NS_ENUM(NSInteger, XWRequestStatus)
{
    XWRequestSuccess,
    XWRequestFailure
};

typedef void(^XWCompletionBlock)(XWRequestStatus status, NSDictionary *data, CustomNetworkError_AFNetworking *xwError);
typedef void(^XWDownloadCompletionBlock)(XWRequestStatus status, NSURLResponse *urlResponse, CustomNetworkError_AFNetworking *xwError);





@interface CustomNetworkEngine_AFNetworking : NSObject



@property (nonatomic, strong)AFHTTPRequestOperationManager *reqOPManager;
+ (instancetype)sharedInstance;
- (NSDictionary *)getHttpHeader;
- (void)postRequestUrlPath:(NSString *)strUrlPath dictParams:(NSMutableDictionary *)dictParams completionBlock:(XWCompletionBlock)completionBlock;
- (void)postRequestUrlPath:(NSString *)strUrlPath files:(NSArray *)files names:(NSArray *)names fileNames:(NSArray *)fileNames mimeTypes:(NSArray *)mimeTypes dictParams:(NSMutableDictionary *)dictParams completionBlock:(XWCompletionBlock)completionBlock;
-(void)downloadFileFromURLStr:(NSString *)fromURLStr toCachePathFileName:(NSString *)fileName completion:(XWDownloadCompletionBlock)downloadCompletionBlock;



@end
