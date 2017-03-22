//
//  CMAlertView.h
//  CMKanKan
//
//  Created by xiaheqi on 15/12/14.
//  Copyright © 2015年 Nesound Kankan Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMAlertView : NSObject <UIAlertViewDelegate>

+ (nullable UIAlertView *)showWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle;

+ (nullable UIAlertView *)showAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message clickAction:(nullable void(^)(NSInteger buttonIndex))action cancelButtonTitle:(nullable NSString *)cancel otherButtonTitles:(nullable NSArray *)otherButtonTitles;

@end
