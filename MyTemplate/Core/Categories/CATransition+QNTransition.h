//
//  CATransition+QNTransition.h
//  QNDC
//
//  Created by 刘昶 on 15/10/19.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CATransition (QNTransition)
+(CATransition *)qn_transitionWithType:(NSString *)type
                               subType:(NSString *)subtype
                              duration:(NSTimeInterval)duration
                                   key:(NSString *)key;

+(void)qn_startTransitionAniamtionInView:(UIView *)view
                                    type:(NSString *)type
                                 subType:(NSString *)subtype
                                duration:(NSTimeInterval)duration
                                     key:(NSString *)key;

+(void)qn_startFadeTransitionInView:(UIView *)view
                           duration:(NSTimeInterval)duration
                                key:(NSString *)key;

+(void)qn_startRevealTransitionInView:(UIView *)view
                             duration:(NSTimeInterval)duration
                            direction:(NSString *)subType
                                  key:(NSString *)key;


/**
 *  Y轴 翻转动画
 *
 *  @param direction > 0 顺时针，其余逆时针
 */
+(void)qn_StartRotationYTransitionInView:(UIView *)view
                           duration:(NSTimeInterval)duration
                          direction:(int)direction
                                key:(NSString *)key;

+(void)qn_startMoveInTransitionInView:(UIView *)view duration:(NSTimeInterval)duration direction:(NSString *)subType key:(NSString *)key;
@end
