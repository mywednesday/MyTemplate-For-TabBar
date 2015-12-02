//
//  UIView+WZPSeparator.h
//  MyTemplate
//
//  Created by qnsoft on 15/12/2.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSDirectionDistance;




@interface UIView (WZPSeparator)



//分割线的停靠方向
typedef NS_ENUM(NSInteger, UISeparatorDockDirection) {
    UISeparatorDockDirectionUp,//默认从0开始
    UISeparatorDockDirectionDown,
    UISeparatorDockDirectionLeft,
    UISeparatorDockDirectionRight
};

/**
 添加顶部横线
 */
- (void)addSeparatorToTop:(CGFloat) top
                 leftEdge:(CGFloat) left
                rightEdge:(CGFloat) right
               withHeight:(CGFloat) height
                withColor:(UIColor *) lineColor;


/**
 添加底部横线
 */
- (void)addSeparatorToBottom:(CGFloat) bottom
                    leftEdge:(CGFloat) left
                   rightEdge:(CGFloat) right
                  withHeight:(CGFloat) height
                   withColor:(UIColor *) lineColor;
/**
 添加左边竖线
 */
- (void)addSeparatorToLeft:(CGFloat) left
                   topEdge:(CGFloat) top
                bottomEdge:(CGFloat) bottom
                 withWidth:(CGFloat) width
                 withColor:(UIColor *) lineColor;

/**
 添加右边竖线
 */
- (void)addSeparatorToRight:(CGFloat) right
                    topEdge:(CGFloat) top
                 bottomEdge:(CGFloat) bottom
                  withWidth:(CGFloat) width
                  withColor:(UIColor *) lineColor;

/**
 添加左、右、底部对齐，线高为1.0的灰色横线
 */
- (void)addSeparator;

//- (void)removeSepartor;     //移除分割线

@end







/**
 距离不同方向的距离
 */
@interface NSDirectionDistance : NSObject
@property (nonatomic, assign) CGFloat topDistance;              //到顶部的距离
@property (nonatomic, assign) CGFloat bottomDistance;           //到底部的距离
@property (nonatomic, assign) CGFloat leftDistance;             //到左边的距离
@property (nonatomic, assign) CGFloat rightDistance;            //到右边的距离
+ (instancetype) distanceWithTop:(CGFloat) top Bottom:(CGFloat) bottom Left:(CGFloat) left Right:(CGFloat) right;
@end






