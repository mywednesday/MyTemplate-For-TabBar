//
//  CustomNetworkError_AFNetworking.m
//  MyTemplate
//
//  Created by qnsoft on 15/10/27.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "CustomNetworkError_AFNetworking.h"

@implementation CustomNetworkError_AFNetworking


+ (instancetype)errorWithNSError:(NSError*)error {
    CustomNetworkError_AFNetworking* myError;
    if(error){
        NSString *errorDomain;
        if(error.domain){
            errorDomain = error.domain;
        }else{
            errorDomain = @"";
        }
        myError = [CustomNetworkError_AFNetworking errorWithDomain:errorDomain code:error.code userInfo:error.userInfo];
    }else{
        NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] initWithCapacity:2];
        [userInfo setObject:[NSString stringWithFormat:@"%d", -1] forKey:@"code"];
        [userInfo setObject:@"网络连接失败，请稍后再试" forKey:@"msg"];
        myError = [CustomNetworkError_AFNetworking errorWithDomain:@"ChannelSoft" code:-1 userInfo:userInfo];
    }
    
    return myError;
}

+ (CustomNetworkError_AFNetworking *)errorWithCode:(NSInteger)code errorMessage:(NSString*)errorMessage
{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithCapacity:2];
    [userInfo setObject:[NSString stringWithFormat:@"%ld", (long)code] forKey:@"code"];
    if (errorMessage) {
        [userInfo setObject:errorMessage forKey:@"msg"];
    }
    
    CustomNetworkError_AFNetworking *error = [CustomNetworkError_AFNetworking errorWithDomain:@"ChannelSoft" code:code userInfo:userInfo];
    return error;
    
}

- (NSString*)titleForError {
    NSString* title = nil;
    if (NSOrderedSame == [self.domain compare:@"NSURLErrorDomain"]) {
        switch (self.code) {
            case NSURLErrorNotConnectedToInternet:
                title = @"网络连接失败，请稍后再试";
                break;
            case NSURLErrorTimedOut:
                title = @"连接超时";
                break;
            case kCFURLErrorCancelled:
                title = @"网络连接失败，请稍后再试";
            default:
                break;
        }
    } else if (NSOrderedSame == [self.domain compare:@"NSPOSIXErrorDomain"] ||
               NSOrderedSame == [self.domain compare:@"kCFErrorDomainCFNetwork"]) {
        title = @"网络连接失败，请稍后再试";
    }
    else
    {
        
    }
    
    if (title == nil) {
        title = [self.userInfo objectForKey:@"msg"];
    }
    // 如果还没取到，就写死
    if (title == nil) {
        title = @"网络连接失败，请稍后再试";
    }
    
    return title;
}



@end
