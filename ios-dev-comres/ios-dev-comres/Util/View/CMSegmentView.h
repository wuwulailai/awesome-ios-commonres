//
//  CMSegmentView.h
//  CMKanKan
//
//  Created by xiaheqi on 16/3/22.
//  Copyright © 2016年 Nesound Kankan Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CMSegmentView;

@protocol CMSegmentViewDelegate <NSObject>

@optional
- (void)segmentView:(CMSegmentView *)segementView selectedAtNowIndex:(NSInteger)index;
- (void)segmentView:(CMSegmentView *)segementView didSelectedWithIndex:(NSInteger)index;

@end

@interface CMSegmentView : UIView

- (instancetype)initWithTitles:(NSArray *)titles;
// NSString数组
@property (nonatomic, strong, readonly) NSArray *titles;
// 文字字体
@property (nonatomic, strong) UIFont *titleFont;
// 文字选中字体
@property (nonatomic, strong) UIFont *selectedTitleFont;
// 字体颜色
@property (nonatomic, strong) UIColor *titleColor;
// 选中字体颜色
@property (nonatomic, strong) UIColor *selectedTitleColor;
// 未选中背景颜色
@property (nonatomic, strong) UIColor *backgroudColor;
// 选中背景颜色
@property (nonatomic, strong) UIColor *selectedBackgroudColor;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, weak) id<CMSegmentViewDelegate> delegate;

@property (nonatomic, assign) CGFloat bottomLineX;

@end
