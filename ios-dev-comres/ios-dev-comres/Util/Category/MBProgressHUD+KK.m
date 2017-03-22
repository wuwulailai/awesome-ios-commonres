//
//  MBProgressHUD+CCHUD.m
//  CloudProperty
//
//  Created by xhq on 15/6/8.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import "MBProgressHUD+KK.h"
#import "AppDelegate.h"
@implementation MBProgressHUD (KK)

#pragma mark - 显示提示信息

+ (void)showHudText:(NSString *)text view:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    [view bringSubviewToFront:hud];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.label.text = text;
    [hud showAnimated:YES];
}

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view showTime:(NSTimeInterval)delay
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
    // 设置图片
    if (icon.length) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    }
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:delay];
}

/**
 *  显示成功信息
 *
 *  @param success 文字
 *  @param delay   时间
 */
+ (void)showSuccess:(NSString *)success showTime:(NSTimeInterval)delay
{
    [self showSuccess:success toView:nil showTime:delay];
}
/**
 *  显示失败信息
 *
 *  @param error 文字
 *  @param delay   时间
 */
+ (void)showError:(NSString *)error showTime:(NSTimeInterval)delay
{
    [self showError:error toView:nil showTime:delay];
}
/**
 *  显示成功信息
 *
 *  @param success 文字
 *  @param view    哪一个视图
 *  @param delay   时间
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view showTime:(NSTimeInterval)delay
{
    [self show:success icon:@"" view:view showTime:delay]; // 取消图片
}
/**
 *  显示失败信息
 *
 *  @param error 文字
 *  @param view    哪一个视图
 *  @param delay   时间
 */
+ (void)showError:(NSString *)error toView:(UIView *)view showTime:(NSTimeInterval)delay
{
    [self show:error icon:@"" view:view showTime:delay]; // 取消图片
}

#pragma mark - 加载动画

/**
 *  显示HUD
 *
 *  @param message 文字
 *  @param view    哪一个view
 */
+ (MBProgressHUD *)animationWithMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) view = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = NO;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = /*dimBackground ? [UIColor colorWithWhite:0.f alpha:.2f] : */[UIColor clearColor];
    
    hud.label.textColor = [UIColor whiteColor];
    
    return hud;
}
/**
 *  显示HUD
 *
 *  @param message 文字
 */
+ (MBProgressHUD *)animationWithMessage:(NSString *)message
{
    return [self animationWithMessage:message toView:nil];
}


/**
 *  隐藏HUD
 *
 *  @param view 哪一个view
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    [self hideHUDForView:view animated:YES];
}
/**
 *  隐藏HUD
 *
 *  @param delay 延迟时间
 */
+ (void)hideHUDForView:(UIView *)view timeOut:(NSTimeInterval)delay
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [self HUDForView:view];
    
    [hud hideAnimated:YES afterDelay:delay];
}
/**
 *  隐藏HUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
