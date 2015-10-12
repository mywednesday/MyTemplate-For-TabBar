//
//  MyOperateTipsHelper.m
//  xhxw
//
//  Created by qnsoft on 15/9/28.
//  Copyright (c) 2015年 北京青牛科技有限公司. All rights reserved.
//

#import "MyOperateTipsHelper.h"
#import "AppDelegate.h"



@interface MyOperateTipsHelper()

@property (nonatomic, strong) UIButton *coverBtn;               //背景按钮，响应点击页面消失事件
@property (nonatomic, strong) UIView *backContainerView;        //含有 topView  和  bottomView
@property (nonatomic, assign) CGFloat topOffset;


@property (nonatomic, strong) UIImage *myCoverImage;
@property (nonatomic, assign) CGPoint myCoverTopLeftPoint;       //帮助向导图片左上角的坐标
@property (nonatomic, assign) BOOL myDisableFoldUp;
@property (nonatomic, assign) BOOL showing;


/**
 *  显示或隐藏面板
 */
- (void) showOperateTips;


/**
 *  用户指引控制板
 *
 *  @param coverImage       图片
 *  @param coverPos         图片左上角的坐标
 *
 *  @return MyOperateTipsHelper
 */
- (instancetype)initWithCoverImage:(UIImage *)coverImage andCoverPosition:(CGPoint) coverPos;

@end

@implementation MyOperateTipsHelper{
    
    UIWindow *MyOperateTipsHelperWindow;
    
}



- (void)dealloc{
    if(MyOperateTipsHelperWindow){
        MyOperateTipsHelperWindow.hidden = YES;
        if ([MyOperateTipsHelperWindow isKeyWindow])
            [MyOperateTipsHelperWindow resignFirstResponder];
        MyOperateTipsHelperWindow.rootViewController = nil;
        MyOperateTipsHelperWindow = nil;
    }
}



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializer];
    self.view.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







- (void)initializer{
    if(! self.myCoverImage)
        self.myCoverImage = [[UIImage alloc] init];
    self.myDisableFoldUp = NO;
    self.showing = NO;
    
    
    self.coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.coverBtn.backgroundColor = [UIColor grayColor];
    self.coverBtn.frame = self.view.bounds;
    [self.coverBtn addTarget:self action:@selector(coverBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.coverBtn];
    
    self.backContainerView = [[UIView alloc] init];
    [self.view addSubview:self.backContainerView];
    self.backContainerView.backgroundColor = [UIColor clearColor];
    
}


- (void)coverBtnTouched:(UIButton *)coverBtn{
    [self showMoreInWindow];
}


/**
 *  用户指引控制板
 *
 *  @param coverImage       图片
 *  @param coverPos         图片左上角的坐标
 *
 *  @return MyOperateTipsHelper
 */
- (instancetype)initWithCoverImage:(UIImage *)coverImage andCoverPosition:(CGPoint) coverPos {
    if (self) {
        self.myCoverImage = coverImage;
        self.myCoverTopLeftPoint = CGPointMake(coverPos.x, coverPos.y);    }
    return self;
}



- (void)showOperateTips{
    [self showMoreInWindow];
}


- (void)showMoreInWindow {
    
    if(self.myDisableFoldUp){
        [self.coverBtn removeFromSuperview];
        self.coverBtn = nil;
    }
    
    __weak typeof(self) weakSelf = self;
    if(self.showing){
        //        CGFloat height = self.view.bounds.size.height;
        //        CGRect rect = self.view.frame;
        //        rect.origin.y -= height;
        self.coverBtn.alpha = 0;
        [UIView animateWithDuration:0.3f animations:^{
            //            weakSelf.view.frame = rect;
        } completion:^(BOOL finished) {
            weakSelf.view.hidden = YES;
            weakSelf.showing = NO;
            
            MyOperateTipsHelperWindow.hidden = YES;
            if ([MyOperateTipsHelperWindow isKeyWindow])
                [MyOperateTipsHelperWindow resignFirstResponder];
            MyOperateTipsHelperWindow.rootViewController = nil;
            MyOperateTipsHelperWindow = nil;
        }];
        
        
    }else{
        self.showing = YES;
        
        if(!MyOperateTipsHelperWindow){
            MyOperateTipsHelperWindow = ({
                UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                window.windowLevel        = UIWindowLevelAlert;
                window.backgroundColor    = [UIColor clearColor];
                window.rootViewController = weakSelf;
                window.tag = 78987;
                window;
            });
        }
        [MyOperateTipsHelperWindow makeKeyAndVisible];
        
        self.view.hidden = NO;
        self.coverBtn.alpha = 0;
        [UIView animateWithDuration:0.3f animations:^{
            //            weakSelf.view.frame = rect;
        } completion:^(BOOL finished) {
            weakSelf.coverBtn.alpha = 0.2;
        }];
        
    }
}



+ (void)dismissCurrentMoreControl{
    NSArray *windows = [UIApplication sharedApplication].windows;
    UIWindow *win;
    for(UIWindow *window in windows){
        if(window.tag == 78987){
            window.hidden = YES;
            if ([window isKeyWindow])
                [window resignFirstResponder];
            window.rootViewController = nil;
            win = window;
        }
    }
    win = nil;
    
}


+ (CGFloat)getTopOffset{
    CGFloat topOffset = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    UIWindow *appWindow = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    if([appWindow.rootViewController isKindOfClass:([UINavigationController class])]){
        if(!((UINavigationController *)appWindow.rootViewController).navigationBar.hidden){
            topOffset += [((UINavigationController *)appWindow.rootViewController) topViewController].topLayoutGuide.length;
        }
    }else if([appWindow.rootViewController isKindOfClass:([UITabBarController class])]){
        if([((UITabBarController *)appWindow.rootViewController).selectedViewController isKindOfClass:[UINavigationController class]]){
            UINavigationController *topNav = (UINavigationController*)((UITabBarController *)appWindow.rootViewController).selectedViewController;
            if(!topNav.navigationBar.hidden){
                topOffset += CGRectGetHeight(topNav.navigationBar.frame);
            }
        }
    }
    return topOffset;
}



/**
 *  显示“频道管理”帮助向导
 *  point :图片左上角坐标
 */
- (void) showOperateTipsForChannelManageAtPoint:(CGPoint) point {
    if (self) {
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:HasShownChannelManageViewHelp]) {
            self.myCoverImage = [UIImage imageNamed:@"channel_manage"];
            self.myCoverTopLeftPoint = CGPointMake(point.x, point.y);
            UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:self.myCoverImage];
            self.backContainerView.frame = CGRectMake(self.myCoverTopLeftPoint.x, self.myCoverTopLeftPoint.y, tmpImageView.bounds.size.width, tmpImageView.bounds.size.height);
            [self.backContainerView addSubview:tmpImageView];
            
            [self showOperateTips];
            
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:HasShownChannelManageViewHelp];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}
/**
 *  显示“新闻搜索”帮助向导
 *  point :图片左上角坐标
 */
- (void) showOperateTipsForNewsSearchAtPoint:(CGPoint) point {
    if (self) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:HasShownNewsSearchViewHelp]) {
            self.myCoverImage = [UIImage imageNamed:@"news_search"];
            self.myCoverTopLeftPoint = CGPointMake(point.x, point.y);
            UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:self.myCoverImage];
            self.backContainerView.frame = CGRectMake(self.myCoverTopLeftPoint.x, self.myCoverTopLeftPoint.y, tmpImageView.bounds.size.width, tmpImageView.bounds.size.height);
            [self.backContainerView addSubview:tmpImageView];
            
            [self showOperateTips];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:HasShownNewsSearchViewHelp];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}
/**
 *  显示“字体设置”帮助向导
 *  point :图片左上角坐标
 */
- (void) showOperateTipsForFontSelectAtPoint:(CGPoint) point {
    if (self) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:HasShownFontSelectViewHelp]) {
            self.myCoverImage = [UIImage imageNamed:@"font_select"];
            self.myCoverTopLeftPoint = CGPointMake(point.x, point.y);
            UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:self.myCoverImage];
            self.backContainerView.frame = CGRectMake(self.myCoverTopLeftPoint.x, self.myCoverTopLeftPoint.y, tmpImageView.bounds.size.width, tmpImageView.bounds.size.height);
            [self.backContainerView addSubview:tmpImageView];
            
            [self showOperateTips];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:HasShownFontSelectViewHelp];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}



@end
