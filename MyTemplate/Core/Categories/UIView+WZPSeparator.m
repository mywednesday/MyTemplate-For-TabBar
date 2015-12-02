//
//  UIView+WZPSeparator.m
//  MyTemplate
//
//  Created by qnsoft on 15/12/2.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "UIView+WZPSeparator.h"
#import "Masonry.h"



#define WZP_SEPARATOR_LINE_COLOR ([UIColor colorWithRed:(230)/255.0f green:(230)/255.0f blue:(230)/255.0f alpha:1.0])





@implementation UIView (WZPSeparator)





/**
 添加顶部横线
 */
- (void) addSeparatorToTop:(CGFloat)top
                  leftEdge:(CGFloat)left
                 rightEdge:(CGFloat)right
                withHeight:(CGFloat)height
                 withColor:(UIColor *)lineColor {
    [self addSeparator:UISeparatorDockDirectionUp
              distance:[NSDirectionDistance distanceWithTop:top Bottom:0 Left:left Right:right]
                 width:height
                 color:lineColor];
}


/**
 添加底部横线
 */
- (void) addSeparatorToBottom:(CGFloat)bottom
                     leftEdge:(CGFloat)left
                    rightEdge:(CGFloat)right
                   withHeight:(CGFloat)height
                    withColor:(UIColor *)lineColor {
    [self addSeparator:UISeparatorDockDirectionDown
              distance:[NSDirectionDistance distanceWithTop:0 Bottom:bottom Left:left Right:right]
                 width:height
                 color:lineColor];
}


/**
 添加左边竖线
 */
- (void) addSeparatorToLeft:(CGFloat)left
                    topEdge:(CGFloat)top
                 bottomEdge:(CGFloat)bottom
                  withWidth:(CGFloat)width
                  withColor:(UIColor *)lineColor {
    [self addSeparator:UISeparatorDockDirectionLeft
              distance:[NSDirectionDistance distanceWithTop:top Bottom:bottom Left:left Right:0]
                 width:width
                 color:lineColor];
}

/**
 添加右边竖线
 */
- (void) addSeparatorToRight:(CGFloat)right
                     topEdge:(CGFloat)top
                  bottomEdge:(CGFloat)bottom
                   withWidth:(CGFloat)width
                   withColor:(UIColor *)lineColor {
    [self addSeparator:UISeparatorDockDirectionRight
              distance:[NSDirectionDistance distanceWithTop:top Bottom:bottom Left:0 Right:right]
                 width:width
                 color:lineColor];
}



- (void)addSeparator{
    [self addSeparator:UISeparatorDockDirectionDown
              distance:[NSDirectionDistance distanceWithTop:0 Bottom:0 Left:0 Right:0]
                 width:1
                 color:WZP_SEPARATOR_LINE_COLOR];
}




/**
 distance 只考虑三个方向
 width : 横向的View的高度，纵向View的宽度
 */
- (void)addSeparator:(UISeparatorDockDirection) dockDirection
            distance:(NSDirectionDistance *) distance
               width:(CGFloat) width
               color:(UIColor *) lineColor {
    //内部变量
    UIView *separatorLine;
    
    if(!separatorLine){
        separatorLine = [[UIView alloc] init];
        [self addSubview:separatorLine];
        separatorLine.backgroundColor = lineColor ? lineColor : [UIColor colorWithRed:(230)/255.0f green:(230)/255.0f blue:(230)/255.0f alpha:1];
        
        __weak typeof(self) weakSelf = self;
        [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            switch (dockDirection) {
                case UISeparatorDockDirectionUp:{
                    make.left.equalTo(weakSelf).offset(distance.leftDistance);
                    make.right.equalTo(weakSelf).offset(0 - distance.rightDistance);
                    make.top.equalTo(weakSelf).offset(distance.topDistance);
                    make.height.mas_equalTo(width);
                    break;
                }
                case UISeparatorDockDirectionDown:{
                    make.left.equalTo(weakSelf).offset(distance.leftDistance);
                    make.right.equalTo(weakSelf).offset(0 - distance.rightDistance);
                    make.bottom.equalTo(weakSelf).offset(0 - distance.bottomDistance);
                    make.height.mas_equalTo(width);
                    break;
                }
                case UISeparatorDockDirectionLeft:{
                    make.left.equalTo(weakSelf).offset(distance.leftDistance);
                    make.top.equalTo(weakSelf).offset(distance.rightDistance);
                    make.bottom.equalTo(weakSelf).offset(0 - distance.bottomDistance);
                    make.width.mas_equalTo(width);
                    break;
                }
                case UISeparatorDockDirectionRight:{
                    make.right.equalTo(weakSelf).offset(0 - distance.leftDistance);
                    make.top.equalTo(weakSelf).offset(distance.rightDistance);
                    make.bottom.equalTo(weakSelf).offset(0 - distance.bottomDistance);
                    make.width.mas_equalTo(width);
                    break;
                }
                default:
                    break;
            }
        }];
    }
}


/**
 移除View中的分割线
 */
- (void)removeSepartor{
//    if(separatorLine){
//        [separatorLine removeFromSuperview];
//        separatorLine = nil;
//    }
}







@end







@implementation NSDirectionDistance
+ (instancetype) distanceWithTop:(CGFloat) top Bottom:(CGFloat) bottom Left:(CGFloat) left Right:(CGFloat) right {
    return [[self alloc] initDistanceWithTop:top Bottom:bottom Left:left Right:right];
}
- (id) initDistanceWithTop:(CGFloat) top Bottom:(CGFloat) bottom Left:(CGFloat) left Right:(CGFloat) right {
    self = [super init];
    if (self) {
        self.topDistance = top;
        self.bottomDistance = bottom;
        self.leftDistance = left;
        self.rightDistance = right;
    }
    return self;
}
@end


