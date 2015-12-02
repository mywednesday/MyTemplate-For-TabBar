//
//  UIImage+Adjust.h
//  WeboDemo
//
//  Created by 刘昶 on 14/10/22.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CLExtenstion)
/**
 *  根据图片创建 barItem
 */
+(UIImage *)imageWithName:(NSString *)imageName defaultName:(NSString *)defaultName;
/**
 *  分别返回ios 7 和 ios 6的图片
 */
+(UIImage *)imageFitIosVersionWithName:(NSString *)imageName;
/**
 *  图片拉伸 (背景)
 */
+(UIImage *)imageFitBackgroundWithName:(NSString *)imageName;

+(UIImage *)imageFitBackgroundWithName:(NSString *)imageName adjustLeft:(CGFloat)left adjustTop:(CGFloat)top;


+ (UIImage *)image:(UIImage *)originalImage toScale:(float)scaleSize;
/**
 *  截图
 */
+(UIImage *)imageCaptureWithView:(UIView *)view;

/**
 *  纯色图片
 */
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  生成二维码图片
 */
+(UIImage *)imageWithQRCode:(NSString *)qrCode color:(UIColor*)color WidthAndHeight:(CGFloat)size;
@end
