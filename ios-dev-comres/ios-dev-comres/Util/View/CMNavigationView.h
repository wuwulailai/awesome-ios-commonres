//
//  CMNavigationView.h
//  CMKanKan
//
//  Created by 夏和奇 on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMNavigationView;
@protocol CMNavigationViewDelegate <NSObject>

@optional
- (void)navigationViewDidSelectedBack:(CMNavigationView *)navigationView ;

@end
@interface CMNavigationView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, weak) id<CMNavigationViewDelegate> delegate;
@end
