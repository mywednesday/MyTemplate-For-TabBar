//
//  UIImage+Adjust.m
//  WeboDemo
//
//  Created by 刘昶 on 14/10/22.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import "UIImage+CLExtenstion.h"
#define kUImageIOS7expandString @"_os7"
@implementation UIImage (CLExtenstion)


+(UIImage *)imageWithName:(NSString *)imageName defaultName:(NSString *)defaultName{
    UIImage *image = [UIImage imageNamed:imageName];
    if (!image) {
        image = [UIImage imageNamed:defaultName];
    }
    return image;
}
+(UIImage *)imageFitIosVersionWithName:(NSString *)imageName{
    return [self imageWithName:[imageName stringByAppendingString:kUImageIOS7expandString] defaultName:imageName];
}
+(UIImage *)imageFitBackgroundWithName:(NSString *)imageName{
    return [self imageFitBackgroundWithName:imageName adjustLeft:0.5f adjustTop:0.5f];
}

+(UIImage *)imageFitBackgroundWithName:(NSString *)imageName adjustLeft:(CGFloat)left adjustTop:(CGFloat)top{
    UIImage *image = [self imageFitIosVersionWithName:imageName];
    CGFloat eTop = image.size.height * top;
    CGFloat eLeft = image.size.width * left;
    CGFloat eBottom = image.size.height - eTop - 1;
    CGFloat eRight = image.size.width - eLeft - 1;
    UIEdgeInsets edge = UIEdgeInsetsMake(eTop,eLeft , eBottom, eRight);
//  return   [image stretchableImageWithLeftCapWidth:eLeft topCapHeight:eTop];
    return [image resizableImageWithCapInsets:edge];
}

+ (UIImage *)image:(UIImage *)originalImage toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(originalImage.size.width * scaleSize, originalImage.size.height * scaleSize));
    [originalImage drawInRect:CGRectMake(0, 0, originalImage.size.width * scaleSize, originalImage.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+(UIImage *)imageCaptureWithView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return img;
}
+(UIImage *)imageWithQRCode:(NSString *)qrCode color:(UIColor*)color WidthAndHeight:(CGFloat)size{
    CIImage *qRCIImage = [self createQRForString:qrCode];
    UIImage *qRImage = [self createNonInterpolatedUIImageFormCIImage:qRCIImage withSize:size];
    return [qRImage imageBlackToTransparentWithForecColor:color];
}

+(CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return qrFilter.outputImage;
}

+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage*)imageBlackToTransparentWithForecColor:(UIColor *)color{
    const int imageWidth = self.size.width;
    const int imageHeight = self.size.height;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), self.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}
@end
