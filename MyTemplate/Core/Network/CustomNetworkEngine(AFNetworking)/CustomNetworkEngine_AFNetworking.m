//
//  CustomNetworkEngine_AFNetworking.m
//  MyTemplate
//
//  Created by qnsoft on 15/10/27.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "CustomNetworkEngine_AFNetworking.h"





@implementation CustomNetworkEngine_AFNetworking



+ (instancetype)sharedInstance
{
    
    static CustomNetworkEngine_AFNetworking *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[CustomNetworkEngine_AFNetworking alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _reqOPManager = [AFHTTPRequestOperationManager manager];
        _reqOPManager.responseSerializer = [AFJSONResponseSerializer serializer];
        //        _reqOPManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _reqOPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    }
    return self;
}

- (void)postRequestUrlPath:(NSString *)strUrlPath dictParams:(NSMutableDictionary *)dictParams completionBlock:(XWCompletionBlock)completionBlock{
    
    NSMutableURLRequest *request = [self.reqOPManager.requestSerializer requestWithMethod:@"POST" URLString:[self getRequestUrl:strUrlPath] parameters:dictParams error:nil];
    
    NSDictionary *headerDic = [self getHttpHeader];
    [headerDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    
    AFHTTPRequestOperation *operation = [self.reqOPManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation __unused *operation, id responseObject){
        
        NSDictionary *resJson = responseObject;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *json = nil;
            
            if (resJson) {
                if ([resJson isKindOfClass:[NSArray class]]) {
                    // 兼容NSArray的情况
                    json = @{@"array":resJson};
                } else {
                    json = [NSDictionary dictionaryWithDictionary:resJson];
                }
            }
            
            if (json && [json isKindOfClass:[NSDictionary class]] && (json.count > 0))
            {
                // 看是否出错
                if ([[json allKeys] containsObject:@"code"] && [json[@"code"] intValue] != 0)
                {
                    // 出错啦，取错误信息
                    NSString *errorMsg = json[@"msg"];
                    CustomNetworkError_AFNetworking *e = [CustomNetworkError_AFNetworking errorWithCode:[json[@"code"] integerValue] errorMessage:errorMsg];
                    completionBlock(XWRequestFailure, nil, e);
                    CustomLog(@"\n请求接口：%@\n错误信息：%@", [self getRequestUrl:strUrlPath], errorMsg);
                }else{
                    // 接口调用成功
                    CustomLog(@"\n请求接口：%@\n请求的结果：%@\n", [self getRequestUrl:strUrlPath], resJson);
                    //                    completionBlock(XWRequestSuccess, json[@"data"], nil);
                    completionBlock(XWRequestSuccess, json, nil);
                    
                }
            }else{
                // 接口数据为空
                CustomLog(@"\n请求接口：%@\n接口数据异常", [self getRequestUrl:strUrlPath]);
                CustomNetworkError_AFNetworking *e = [CustomNetworkError_AFNetworking errorWithCode:-1 errorMessage:@"数据异常"];
                completionBlock(XWRequestFailure, @{}, e);
            }
        });
        
    } failure:^(AFHTTPRequestOperation __unused *operation, NSError *error) {
        CustomLog(@"\n网络错误，请求的错误提示：%@\n", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock != nil) {
                CustomNetworkError_AFNetworking *e = [CustomNetworkError_AFNetworking errorWithNSError:error];
                completionBlock(XWRequestFailure, nil, e);
            }
        });
    }];
    
    [self.reqOPManager.operationQueue addOperation:operation];
}


- (void)postRequestUrlPath:(NSString *)strUrlPath files:(NSArray *)files names:(NSArray *)names fileNames:(NSArray *)fileNames mimeTypes:(NSArray *)mimeTypes dictParams:(NSMutableDictionary *)dictParams completionBlock:(XWCompletionBlock)completionBlock{
    
    //    NSMutableURLRequest *request = [self.reqOPManager.requestSerializer requestWithMethod:@"POST" URLString:[self getRequestUrl:strUrlPath] parameters:dictParams error:nil];
    
    NSMutableURLRequest *request = [self.reqOPManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[self getRequestUrl:strUrlPath] parameters:dictParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        for(int i=0; i<files.count; i++){
            NSString *filePath = [files objectAtIndex:i];
            NSString *name = [names objectAtIndex:i];
            NSString *fileName = [fileNames objectAtIndex:i];
            NSString *mimeType = [mimeTypes objectAtIndex:i];
            NSData *fileData = [NSData dataWithContentsOfFile:filePath];
            [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        }
        
        
    } error:nil];
    [request setTimeoutInterval:60];
    
    NSDictionary *headerDic = [self getHttpHeader];
    [headerDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    
    AFHTTPRequestOperation *operation = [self.reqOPManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation __unused *operation, id responseObject){
        
        NSDictionary *resJson = responseObject;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *json = nil;
            
            if (resJson) {
                if ([resJson isKindOfClass:[NSArray class]]) {
                    // 兼容NSArray的情况
                    json = @{@"array":resJson};
                } else {
                    json = [NSDictionary dictionaryWithDictionary:resJson];
                }
            }
            
            if (json && [json isKindOfClass:[NSDictionary class]] && (json.count > 0))
            {
                // 看是否出错
                if ([[json allKeys] containsObject:@"code"] && [json[@"code"] intValue] != 0)
                {
                    // 出错啦，取错误信息
                    NSString *errorMsg = json[@"msg"];
                    CustomNetworkError_AFNetworking *e = [CustomNetworkError_AFNetworking errorWithCode:[json[@"code"] integerValue] errorMessage:errorMsg];
                    completionBlock(XWRequestFailure, nil, e);
                    CustomLog(@"\n请求接口：%@\n错误信息：%@", [self getRequestUrl:strUrlPath], errorMsg);
                }else{
                    // 接口调用成功
                    CustomLog(@"\n请求接口：%@\n请求的结果：%@\n", [self getRequestUrl:strUrlPath], resJson);
                    //                    completionBlock(XWRequestSuccess, json[@"data"], nil);
                    completionBlock(XWRequestSuccess, json, nil);
                    
                }
            }else{
                // 接口数据为空
                CustomLog(@"\n请求接口：%@\n接口数据异常", [self getRequestUrl:strUrlPath]);
                CustomNetworkError_AFNetworking *e = [CustomNetworkError_AFNetworking errorWithCode:-1 errorMessage:@"数据异常"];
                completionBlock(XWRequestFailure, @{}, e);
            }
        });
        
    } failure:^(AFHTTPRequestOperation __unused *operation, NSError *error) {
        CustomLog(@"\n网络错误，请求的错误提示：%@\n", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock != nil) {
                CustomNetworkError_AFNetworking *e = [CustomNetworkError_AFNetworking errorWithNSError:error];
                completionBlock(XWRequestFailure, nil, e);
            }
        });
    }];
    
    [self.reqOPManager.operationQueue addOperation:operation];
}

-(void)downloadFileFromURLStr:(NSString *)fromURLStr toCachePathFileName:(NSString *)fileName completion:(XWDownloadCompletionBlock)downloadCompletionBlock{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:fromURLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        
        //        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        //
        //        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        NSURL *cacheDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [cacheDirectoryURL URLByAppendingPathComponent:fileName];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        CustomLog(@"文件下载完成到: %@", filePath);
        downloadCompletionBlock(error?XWRequestFailure:XWRequestSuccess, response, error?[CustomNetworkError_AFNetworking errorWithNSError:error]:nil);
    }];
    [downloadTask resume];
}


- (NSDictionary *)getHttpHeader{
    
    NSMutableDictionary *mutDictHeaderParams = [NSMutableDictionary dictionary];
    
    // 20141027 增加多语言
    [mutDictHeaderParams setObject:[MyGlobalHelper appLocale] forKey:@"language"];
    
    // 加系统版本，设备版本，设备ID，分辨率
    [mutDictHeaderParams setObject:[MyGlobalHelper getIOSUUID] forKey:@"deviceid"];
    [mutDictHeaderParams setObject:[MyGlobalHelper deviceType] forKey:@"phonetype"];
    [mutDictHeaderParams setObject:[MyGlobalHelper systemVersion] forKey:@"sdkversion"];
    [mutDictHeaderParams setObject:[MyGlobalHelper resolustionPixel] forKey:@"phoneresolution"];
    
    [mutDictHeaderParams setObject:@"iphone" forKey:@"UserAgent"];
    [mutDictHeaderParams setObject:@"appstore" forKey:@"channelid"];
    [mutDictHeaderParams setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"productid"];
    
//    
//    if ([[XWUserManager sharedUserManager] getLocalUniqueId] != nil) {
//        [mutDictHeaderParams setObject:[[XWUserManager sharedUserManager] getLocalUniqueId] forKey:@"uniqueid"];
//    }else{
//        [mutDictHeaderParams setObject:@"_" forKey:@"uniqueid"];
//    }
//    
//    if ([[XWUserManager sharedUserManager] getUserLoginFlag] != XWLocalUserFlag) {
//        
//        [mutDictHeaderParams setObject:[[XWUserManager sharedUserManager] getUid] forKey:@"userid"];
//        //[mutDictHeaderParams setObject:@"c356381173ab11e39bf8001a6467c5a1" forKey:@"userid"];
//        
//        [mutDictHeaderParams setObject:[[XWUserManager sharedUserManager] getLoginUserToken] forKey:@"userToken"];
//    }else if([[XWUserManager sharedUserManager] getLocalUniqueId]){
//        //[mutDictHeaderParams setObject:@"c356381173ab11e39bf8001a6467c5a1" forKey:@"userid"];
//        [mutDictHeaderParams setObject:[[XWUserManager sharedUserManager] getLocalUniqueId] forKey:@"userid"];
//    }
//    //    NSLog(@"mutDictHeaderParams:%@",mutDictHeaderParams);
    
    
    return mutDictHeaderParams;
    
}

- (NSString *)getRequestUrl:(NSString *)path
{
    if ([path hasPrefix:@"http"]) {
        return path;
    }
    
//    NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://%@", kAppBaseURL];
        NSMutableString *urlString = @"";
    
    if(![path isEqualToString:@"/"]) {
        
        if(path.length > 0 && [path characterAtIndex:0] == '/')
            [urlString appendFormat:@"%@", path];
        else if (path != nil)
            [urlString appendFormat:@"/%@", path];
    }
    return urlString;
}




@end
