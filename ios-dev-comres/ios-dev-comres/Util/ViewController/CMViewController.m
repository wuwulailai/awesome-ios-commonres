//
//  CMViewController.m
//  CMKanKan
//
//  Created by 夏和奇 on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "CMViewController.h"

@interface CMViewController ()

@end

@implementation CMViewController

#pragma mark - ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    
    [self creatNavigationView];
}
- (void)creatNavigationView
{
    _navigationView = [[CMNavigationView alloc] init];
    _navigationView.titleLabel.text = self.title;
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
    
    // rootView不显示返回按钮
    if (self.navigationController.viewControllers.firstObject == self) {
        _navigationView.backButton.hidden = YES;
    }
    
    @weakify(self);
    [_navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(kNavigationH);
    }];
}
- (void)dealloc
{
    [CMDefaultCenter removeObserver:self];
}

#pragma mark - NavigationView Delegate
// 点击了返回按钮
- (void)navigationViewDidSelectedBack:(CMNavigationView *)navigationView
{
    [self.navigationController popViewControllerAnimated:YES];
    
    //  子类可以重写
}

#pragma mark - gestureRecongnizer
- (BOOL)gestureRecognizerShouldBegin
{
    // 子类实现
    if (self.navigationController.viewControllers.firstObject == self) {
        return NO;
    }
    
    return YES;
}
#pragma mark - Rotate
- (BOOL)shouldAutorotate
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    if (self.navigationView){
        self.navigationView.titleLabel.text = title;
    }
}
@end
