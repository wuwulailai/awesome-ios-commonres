//
//  UIImageView+CMCornerRadius.h
//  CMKanKan
//
//  Created by zenghaohong on 2017/1/5.
//  Copyright © 2017年 kankan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CMCornerRadius)

/**
 此方法会将加载的网络图片，通过绘图的方式切圆角，圆角半径为MIN(viewSize.width, viewSize.height)/2.0

 @param url 网络图片的url
 @param placeholder 占位图
 @param viewSize imageView的实际大小
 */
- (void)tt_setCircularImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder viewSize:(CGSize)viewSize;

/**
 此方法会将加载的网络图片，通过绘图的方式切圆角，圆角半径由参数radius给定

 @param url 网络图片的url
 @param placeholder 占位图
 @param viewSize imageView的实际大小
 @param radius 圆角半径
 */
- (void)tt_setCornerImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder viewSize:(CGSize)viewSize cornerRadius:(CGFloat)radius;

@end
