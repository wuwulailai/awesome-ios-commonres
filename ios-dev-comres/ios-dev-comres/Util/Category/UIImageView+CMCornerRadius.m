//
//  UIImageView+CMCornerRadius.m
//  CMKanKan
//
//  Created by zenghaohong on 2017/1/5.
//  Copyright © 2017年 kankan. All rights reserved.
//

#import "UIImageView+CMCornerRadius.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Extension.h"

@implementation UIImageView (CMCornerRadius)

- (void)tt_setCircularImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder viewSize:(CGSize)viewSize{
    @weakify(self)
    [self sd_setImageWithURL:url placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image){
            [self asynSetCircularImage:image viewSize:viewSize];
        }
    }];
}
- (void)tt_setCornerImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder viewSize:(CGSize)viewSize cornerRadius:(CGFloat)radius{
    @weakify(self)
    [self sd_setImageWithURL:url placeholderImage:[self synGetCornerImage:placeholder viewSize:viewSize cornerRadius:radius] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image){
            [self asynSetCornerImage:image viewSize:viewSize cornerRadius:radius];
        }
    }];
}

// 异步设置圆形图
- (void)asynSetCircularImage: (UIImage *)image viewSize: (CGSize)viewSize{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGFloat radius = MIN(viewSize.width, viewSize.height)/2.0;
        CGRect drawRect = [self getDrawRectWithImageSize:image.size viewSize:viewSize];
        UIImage *newImage = [image cornerImageWithRadius:radius viewSize:viewSize drawRect:drawRect];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = newImage;
        });
    });
}

// 同步获取圆角图
- (UIImage *)synGetCornerImage: (UIImage *)image viewSize: (CGSize)viewSize cornerRadius: (CGFloat)radius{
    CGRect drawRect = [self getDrawRectWithImageSize:image.size viewSize:viewSize];
    return [image cornerImageWithRadius:radius viewSize:viewSize drawRect:drawRect];
}

// 异步设置圆角图
- (void)asynSetCornerImage: (UIImage *)image viewSize: (CGSize)viewSize cornerRadius: (CGFloat)radius{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGRect drawRect = [self getDrawRectWithImageSize:image.size viewSize:viewSize];
        UIImage *newImage = [image cornerImageWithRadius:radius viewSize:viewSize drawRect:drawRect];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = newImage;
        });
    });
}
- (CGRect)getDrawRectWithImageSize: (CGSize)imgSize viewSize: (CGSize)size{
    CGPoint finalOrigin = CGPointZero;
    CGSize finalSize = imgSize;
    CGFloat wRate = imgSize.width/size.width;
    CGFloat hRate = imgSize.height/size.height;
    switch (self.contentMode) {
        case UIViewContentModeTop:
            finalOrigin.x = (size.width-imgSize.width)/2.0;
            break;
        case UIViewContentModeBottom:
            finalOrigin.x = (size.width-imgSize.width)/2.0;
            finalOrigin.y = (size.height-imgSize.height);
            break;
        case UIViewContentModeLeft:
            finalOrigin.y = (size.height-imgSize.height)/2.0;
            break;
        case UIViewContentModeRight:
            finalOrigin.x = size.width-imgSize.width;
            finalOrigin.y = (size.height-imgSize.height)/2.0;
            break;
        case UIViewContentModeCenter:
            finalOrigin.x = (size.width-imgSize.width)/2.0;
            finalOrigin.y = (size.height-imgSize.height)/2.0;
            break;
        case UIViewContentModeTopLeft:
            break;
        case UIViewContentModeTopRight:
            finalOrigin.x = size.width-imgSize.width;
            break;
        case UIViewContentModeBottomLeft:
            finalOrigin.y = size.height-imgSize.height;
            break;
        case UIViewContentModeBottomRight:
            finalOrigin.x = size.width-imgSize.width;
            finalOrigin.y = size.height-imgSize.height;
            break;
        case UIViewContentModeScaleToFill:
            finalSize = size;
            break;
        case UIViewContentModeScaleAspectFit:
            if (hRate > wRate){
                finalSize.height = size.height;
                finalSize.width = imgSize.width/hRate;
                finalOrigin.y = 0.0;
                finalOrigin.x = (size.width-finalSize.width)/2.0;
            }else{
                finalSize.width = size.width;
                finalSize.height = imgSize.height/wRate;
                finalOrigin.x = 0.0;
                finalOrigin.y = (size.height-finalSize.height)/2.0;
            }
            break;
        case UIViewContentModeScaleAspectFill:
            if (hRate < wRate){
                finalSize.height = size.height;
                finalSize.width = imgSize.width/hRate;
                finalOrigin.y = 0.0;
                finalOrigin.x = (size.width-finalSize.width)/2.0;
            }else{
                finalSize.width = size.width;
                finalSize.height = imgSize.height/wRate;
                finalOrigin.x = 0.0;
                finalOrigin.y = (size.height-finalSize.height)/2.0;
            }
            break;
        default:
            return CGRectZero;
    }
    return CGRectMake(finalOrigin.x, finalOrigin.y, finalSize.width, finalSize.height);
}

@end
