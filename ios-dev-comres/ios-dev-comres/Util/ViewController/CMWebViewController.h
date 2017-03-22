//
//  CMWebViewController.h
//  CMKanKan
//
//  Created by 夏和奇 on 2017/3/7.
//  Copyright © 2017年 kankan. All rights reserved.
//

#import "CMViewController.h"

@interface CMWebViewController : CMViewController <UIWebViewDelegate>

// 网页地址
@property (nonatomic, copy) NSString *urlStr;

// 返回或退出时调用
@property (nonatomic, copy) void(^backBlock)();

@end
