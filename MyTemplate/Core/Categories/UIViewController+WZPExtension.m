//
//  UIViewController+WZPExtension.m
//  MyTemplate
//
//  Created by qnsoft on 15/12/15.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "UIViewController+WZPExtension.h"

@implementation UIViewController (WZPExtension)


- (__kindof UIViewController *) instanceInitialViewControllerFromStoryboard:(NSString *)name
                                                                     bundle:(nullable NSBundle *)storyboardBundleOrNil
                                                                 identifier:(NSString *)identifier {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:storyboardBundleOrNil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

@end
