//
//  CustomNetworkError_AFNetworking.h
//  MyTemplate
//
//  Created by qnsoft on 15/10/27.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomNetworkError_AFNetworking : NSError

+ (instancetype)errorWithNSError:(NSError *)error;
+ (CustomNetworkError_AFNetworking *)errorWithCode:(NSInteger)code errorMessage:(NSString *)errorMessage;
- (NSString *)titleForError;

@end
