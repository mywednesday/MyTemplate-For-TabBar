//
//  UIViewController+WZPExtension.h
//  MyTemplate
//
//  Created by qnsoft on 15/12/15.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
//NS_CLASS_AVAILABLE_IOS(5_0)
@interface UIViewController (WZPExtension)


/**
    load ViewController from UIStoryboard with 
    storyboard'name
    bundle              and
    identifier
 */
- (__kindof UIViewController *) instanceInitialViewControllerFromStoryboard:(NSString *)name
                                                                     bundle:(nullable NSBundle *)storyboardBundleOrNil
                                                                 identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END