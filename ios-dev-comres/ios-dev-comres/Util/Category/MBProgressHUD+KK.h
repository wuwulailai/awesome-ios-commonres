//
//  MBProgressHUD+CCHUD.h
//  CloudProperty
//
//  Created by xhq on 15/6/8.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//
// 可代替加载动画和部分不用按钮的alertView
#import "MBProgressHUD.h"


@interface MBProgressHUD (KK)

#pragma mark - 显示提示信息
/**
 *  显示提示信息(显示在上面)
 *
 *  @param text 提示文字
 *  @param view 哪一个视图
 */
+ (void)showHudText:(NSString *)text view:(UIView *)view;
/**
 *  显示成功信息(显示在上面)
 *
 *  @param success 文字
 *  @param delay   时间
 */
+ (void)showSuccess:(NSString *)success showTime:(NSTimeInterval)delay;
/**
 *  显示失败信息(显示在上面)
 *
 *  @param error 文字
 *  @param delay   时间
 */
+ (void)showError:(NSString *)error showTime:(NSTimeInterval)delay;
/**
 *  显示成功信息
 *
 *  @param success 文字
 *  @param view    哪一个视图
 *  @param delay   时间
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view showTime:(NSTimeInterval)delay;
/**
 *  显示失败信息
 *
 *  @param error 文字
 *  @param view    哪一个视图
 *  @param delay   时间
 */
+ (void)showError:(NSString *)error toView:(UIView *)view showTime:(NSTimeInterval)delay;

#pragma mark - 加载动画
/**
 *  显示HUD
 *
 *  @param message 文字
 *  @param view    哪一个view
 */
+ (MBProgressHUD *)animationWithMessage:(NSString *)message toView:(UIView *)view;
/**
 *  显示HUD(显示在上面)
 *
 *  @param message 文字
 */
+ (MBProgressHUD *)animationWithMessage:(NSString *)message;


/**
 *  隐藏HUD
 *
 *  @param view 哪一个view
 */
+ (void)hideHUDForView:(UIView *)view;
/**
 *  隐藏HUD
 *
 *  @param delay 延迟时间
 */
+ (void)hideHUDForView:(UIView *)view timeOut:(NSTimeInterval)delay ;
/**
 *  隐藏HUD
 */
+ (void)hideHUD;

@end
