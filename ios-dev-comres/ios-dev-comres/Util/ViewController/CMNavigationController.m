//
//  CMNavigationController.m
//  CMKanKan
//
//  Created by 夏和奇 on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "CMNavigationController.h"
#import "CMViewController.h"

@interface CMNavigationController ()<UINavigationControllerDelegate>

    @property (nonatomic, getter=isPushing) BOOL pushing;

@end

@implementation CMNavigationController

#pragma mark - ViewControll
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.hidden = YES;
    
    self.delegate = self; 
}

#pragma mark - GestureRecognizer
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL isOk = YES;
    
    if ([self.topViewController isKindOfClass:[CMViewController class]] &&
        [self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin)]) {

        CMViewController *baseVc = (CMViewController *)self.topViewController;
        isOk = [baseVc gestureRecognizerShouldBegin];
    }
    return isOk;
}
#pragma mark - BottomBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // push进去的控制器隐藏tabBar
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 防止快速点击，重复push页面
    if ([self isPushing]) { //正在push
        
        return;
        
    }
    self.pushing = YES;

    [super pushViewController:viewController animated:animated];
}

#pragma mark - Rotate
- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.pushing = NO;
}
@end
