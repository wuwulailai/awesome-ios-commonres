//
//  UIButton+Extensions.h
//  CMKanKan
//
//  Created by 吴保来 on 2017/3/22.
//  Copyright © 2017年 kankan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extensions)

/**
 *  使点击区域扩大，要用负数
 *  [button setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
 */
@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end
