//
//  CMViewController.h
//  CMKanKan
//
//  Created by 夏和奇 on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMNavigationView.h"

#define kNavigationH 64
@interface CMViewController : UIViewController <CMNavigationViewDelegate>
// 顶部按钮
@property (nonatomic, strong) CMNavigationView *navigationView;

// 右滑返回 事件
- (BOOL)gestureRecognizerShouldBegin;

@end
