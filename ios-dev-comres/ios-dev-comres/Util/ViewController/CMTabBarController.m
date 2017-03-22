//
//  CMTabBarViewController.m
//  CMKanKan
//
//  Created by 夏和奇 on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "CMTabBarController.h"
#import "CMNavigationController.h"

@interface CMTabBarController ()

@end

@implementation CMTabBarController

#pragma mark - ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 显示状态栏
    [self showStatusBar];
    
    //  创建控制器
    [self creatViewControllers];
}

- (void)showStatusBar
{
    CMSharedApplication.statusBarHidden = NO;
    CMSharedApplication.statusBarStyle = UIStatusBarStyleDefault;
}


#pragma mark - ViewContollers
- (void)creatViewControllers
{
    //首页
//    CMHomeViewController *home = [[CMHomeViewController alloc] init];
//    home.edgesForExtendedLayout = UIRectEdgeNone;
//    home.title = @"主页";
//    CMNavigationController *homeNav = [[CMNavigationController alloc] initWithRootViewController:home];
//    [self setTabBarItemWithNav:homeNav imageEn:@"home"];
//    
//    [self setTabBarItemWithNav:mineNav imageEn:@"mine"];
    
    //把控制器加到tabbaeViewController中
//    self.viewControllers = @[homeNav,focusNav,mineNav];
}

- (void)setTabBarItemWithNav:(CMNavigationController *)nav imageEn:(NSString *)imageEn
{
    NSString *normalName = [NSString stringWithFormat:@"tarbar_%@_normal",imageEn];
    NSString *selectedName = [NSString stringWithFormat:@"tarbar_%@_selected",imageEn];
    [nav.tabBarItem setImage:[[UIImage imageNamed:normalName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11.0], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#99999b"]} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11.0], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#404042"]} forState:UIControlStateSelected];
}
#pragma mark - Rotate
- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}
@end
