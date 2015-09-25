//
//  MyOperateTipsHelper.m
//  MyTemplate
//
//  Created by qnsoft on 15/9/25.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyOperateTipsHelper.h"


@interface MyOperateTipsHelper ()

@property (nonatomic, strong) UIButton *coverBtn;

/**
 显示会话页面操作提示
 */
- (void) showTalkViewOperateTips;



/**
 个人中心页面操作提示
 */
- (void) showPersonViewOperateTips;

@end



@implementation MyOperateTipsHelper


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/**
 显示一个指定页面的操作提示
 */
- (void) showOperateTipsForSpecificView:(SpecificViewKey) specificViewKey {
    
    switch (specificViewKey) {
        case SpecificViewKey_ForTalk: {
            NSLog(@"\n显示会话页面操作提示");
            [self showTalkViewOperateTips];
        }
            break;
        case SpecificViewKey_ForPerson:
            NSLog(@"\n显示个人中心操作提示");
            [self showPersonViewOperateTips];
            break;
        default:
            break;
    }
}


/**
 显示会话页面操作提示
 */
- (void) showTalkViewOperateTips {
    ////    BOOL showedChannelSearchHelp = [[NSUserDefaults standardUserDefaults] boolForKey:@"showedChannelSearchHelp"];
    ////    if(!showedChannelSearchHelp){
    //
    //        UIButton *maskBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //        maskBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    //
    //        [maskBtn addTarget:self action:@selector(maskBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    //        UIImageView *helpView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"help_channelsearch"]];
    //
    //        CGRect helpRect = helpView.frame;
    //        //        helpRect.origin = CGPointMake(0, self.view.bounds.size.height-helpRect.size.height);
    //        CGRect fakeSearchBarRect = [self.fakeSearchBar convertRect:self.fakeSearchBar.bounds toView:self.view];
    //        helpRect.origin = CGPointMake(0, fakeSearchBarRect.origin.y+fakeSearchBarRect.size.height-helpRect.size.height);
    //
    //
    //        helpView.frame = helpRect;
    //
    //        [maskBtn addSubview:helpView];
    //        [self.view addSubview:maskBtn];
    //
    //        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showedChannelSearchHelp"];
    //        [[NSUserDefaults standardUserDefaults] synchronize];
    ////    }
    
    
    
    
    
    __weak typeof(self) weakSelf = self;
    if(self.isOperateTipsShowing){
        CGFloat height = self.view.bounds.size.height;
        CGRect rect = self.view.frame;
        rect.origin.y -= height;
        self.coverBtn.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.view.frame = rect;
        } completion:^(BOOL finished) {
            weakSelf.view.hidden = YES;
            weakSelf.isOperateTipsShowing = NO;
        }];
    }else{
        self.isOperateTipsShowing = YES;
        
        CGFloat height = self.view.bounds.size.height;
        CGRect rect = self.view.frame;
        rect.origin.y -= height;
        self.view.frame = rect;
        rect.origin.y = 0;
        self.view.hidden = NO;
        self.coverBtn.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.view.frame = rect;
            
        } completion:^(BOOL finished) {
            weakSelf.coverBtn.alpha = 0.2;
        }];
    }
    
}



/**
 个人中心页面操作提示
 */
- (void) showPersonViewOperateTips {
    
}


- (void)maskBtnTouched:(id)sender{
    [sender removeFromSuperview];
    sender = nil;
}



@end
