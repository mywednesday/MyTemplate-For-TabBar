//
//  CATransition+QNTransition.m
//  QNDC
//
//  Created by 刘昶 on 15/10/19.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CATransition+QNTransition.h"

@implementation CATransition (QNTransition)
+(void)qn_startTransitionAniamtionInView:(UIView *)view
                                    type:(NSString *)type
                                 subType:(NSString *)subtype
                                duration:(NSTimeInterval)duration
                                     key:(NSString *)key{
    
    CATransition *transition = [self qn_transitionWithType:type subType:subtype duration:duration key:key];
    
    [view.layer addAnimation:transition forKey:key];
}

+(CATransition *)qn_transitionWithType:(NSString *)type
                               subType:(NSString *)subtype
                              duration:(NSTimeInterval)duration
                                   key:(NSString *)key{
    
    CATransition *transition = [CATransition animation];
    transition.duration = duration;
    transition.type = type;
    transition.subtype = subtype;
    
    return transition;
    
}

+(void)qn_startFadeTransitionInView:(UIView *)view
                           duration:(NSTimeInterval)duration
                                key:(NSString *)key{
    [self qn_startTransitionAniamtionInView:view type:kCATransitionFade subType:nil duration:duration key:key];
}

+(void)qn_startRevealTransitionInView:(UIView *)view
                             duration:(NSTimeInterval)duration
                            direction:(NSString *)subType
                                  key:(NSString *)key{
    [self qn_startTransitionAniamtionInView:view type:kCATransitionReveal subType:subType duration:duration key:key];
}

+(void)qn_StartRotationYTransitionInView:(UIView *)view
                        duration:(NSTimeInterval)duration
                       direction:(int)direction
                             key:(NSString *)key{
    CABasicAnimation *animtaion = [CABasicAnimation animation];
    animtaion.keyPath = @"transform.rotation.y";
    animtaion.duration = duration;
    animtaion.fromValue = @(0);
    if (direction > 0) {
        animtaion.toValue = @(M_PI);
    }else{
        animtaion.toValue = @(-M_PI);
    }
    [view.layer addAnimation:animtaion forKey:key];
    
}

+(void)qn_startMoveInTransitionInView:(UIView *)view duration:(NSTimeInterval)duration direction:(NSString *)subType key:(NSString *)key{
    [self qn_startTransitionAniamtionInView:view type:kCATransitionMoveIn subType:subType duration:duration key:key];
}
@end
