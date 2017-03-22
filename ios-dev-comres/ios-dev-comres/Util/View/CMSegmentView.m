//
//  CMSegmentView.m
//  CMKanKan
//
//  Created by xiaheqi on 16/3/22.
//  Copyright © 2016年 Nesound Kankan Inc. All rights reserved.
//

#import "CMSegmentView.h"
#import "UIImage+Extension.h"
#import "NSString+Util.h"
#import "UIColor+HexString.h"

@interface CMSegmentView ()

@property (nonatomic, strong) NSMutableArray *titlesWidthArray;

@end

@implementation CMSegmentView
{
    __weak UIView *_bottomLine;
    __weak UIImageView *_bottomImage;
    __weak UIButton *_selecetedBtn;
    NSMutableArray *_buttons;
    CGFloat _lineMinX;
    CGFloat _imageMinX;
}

@synthesize selectedIndex = _selectedIndex;

#pragma mark - 初始化
- (instancetype)init
{
    if (self = [super init]) {
        _titleFont = [UIFont systemFontOfSize:17.0];
        _selectedTitleFont = [UIFont systemFontOfSize:18.0];
        _titleColor = [UIColor colorWithHexString:@"#01A2ED"];
        _selectedTitleColor = [UIColor colorWithHexString:@"#21b7ef"];
        _backgroudColor = [UIColor whiteColor];
        _selectedBackgroudColor = [UIColor colorWithHexString:@"332d33"];
    }
    return self;
}
- (instancetype)initWithTitles:(NSArray *)titles {
    if (self = [super init]) {
        
        _titles = [titles copy];
        
        _buttons = [NSMutableArray array];
        
        for (NSInteger index = 0; index < _titles.count; index++) {
            [self createButtonWithTitle:_titles[index] tag:index];
        }
        
        UIImageView *bottomImage = [[UIImageView alloc] init];
        [bottomImage setImage:[UIImage imageNamed:@"navibar_selected"]];
        CMAssert(self != (UIView *)bottomImage, @"这里addsubview崩溃啦segment bottomImage");
        [self addSubview:_bottomImage = bottomImage];
        
        UIView *bottomLine              = [[UIView alloc] init];
        bottomLine.backgroundColor      = [UIColor blackColor];
//        bottomLine.hidden               =   YES;
        [self addSubview:_bottomLine    = bottomLine];
    }
    return self;
}

- (void)createButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // font
    button.titleLabel.font = self.titleFont;
    
    // textColor
    [button setTitleColor:self.titleColor forState:UIControlStateNormal];
    [button setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
    
    // backgroundColor
    [button setBackgroundImage:[UIImage createImageWithColor:self.backgroudColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage createImageWithColor:self.selectedBackgroudColor] forState:UIControlStateSelected];
    
    button.adjustsImageWhenHighlighted = NO;
    
    button.tag = tag;
    
    if (button.tag == 0) { // 默认选中第一个
        
        button.selected = YES;
        
        _selecetedBtn = button;
        
        _selectedIndex = 0;
        
        button.titleLabel.font = self.selectedTitleFont;
        
    }
    CMAssert(self != (UIView *)button, @"这里addsubview崩溃啦segment button");
    [self addSubview:button];
    
    [_buttons addObject:button];
    
    // 计算文本长度
    CGFloat textW = [self getBottomLineWidth:tag];
    [self.titlesWidthArray addObject:@(textW)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count     = _buttons.count;
    CGFloat buttonW     = self.width / count;
    CGFloat buttonH     = self.height;
    CGFloat lineH       = 2.0;
    CGFloat lineW       = [self.titlesWidthArray[_selectedIndex] floatValue];
    
    CGFloat imageH      =   5.0;
    CGFloat imageW      =   12.0 ;
    
    _lineMinX = (buttonW - lineW) / 2.0;
    
    for (UIButton *button in _buttons) {
        NSInteger index = [_buttons indexOfObject:button];
        
        button.frame = CGRectMake(index * buttonW, 0, buttonW, buttonH);
    }
    
    _bottomLine.frame   =   CGRectMake(_lineMinX + _selectedIndex*buttonW, buttonH - 2*lineH, lineW, lineH);
    
     _imageMinX         =   buttonW/2.0 - imageW/2.0;
    _bottomImage.frame  =   CGRectMake(_imageMinX + _bottomLineX, buttonH - imageH - 4 , imageW, imageH);

}

#pragma mark - update UI
- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    for (UIButton *button in _buttons) {
        if (!button.selected) button.titleLabel.font = self.titleFont;
    }
}
- (void)setSelectedTitleFont:(UIFont *)selectedTitleFont
{
    _selectedTitleFont = selectedTitleFont;
    _selecetedBtn.titleLabel.font = selectedTitleFont;
}
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    for (UIButton *button in _buttons) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
}
- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    _selectedTitleColor = selectedTitleColor;
    for (UIButton *button in _buttons) {
        [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
}
- (void)setBackgroudColor:(UIColor *)backgroudColor
{
    _backgroudColor = backgroudColor;
    for (UIButton *button in _buttons) {
        [button setBackgroundImage:[UIImage createImageWithColor:backgroudColor] forState:UIControlStateNormal];
    }
}
- (void)setSelectedBackgroudColor:(UIColor *)selectedBackgroudColor
{
    _selectedBackgroudColor = selectedBackgroudColor;
    for (UIButton *button in _buttons) {
        [button setBackgroundImage:[UIImage createImageWithColor:selectedBackgroudColor] forState:UIControlStateSelected];
    }
}
#pragma mark - 事件处理
- (void)buttonClick:(UIButton *)button {
    if (self.selectedIndex == button.tag) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:selectedAtNowIndex:)]) {
            
            [self.delegate segmentView:self selectedAtNowIndex:button.tag];
        }
        return;
    }
    [self selectButton:button];
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectedWithIndex:)]) {
        
        [self.delegate segmentView:self didSelectedWithIndex:button.tag];
    }
}


// 只会选中按钮，不会触发事件
- (void)selectButton:(UIButton *)button {
    _selecetedBtn.selected = NO;
    _selecetedBtn.titleLabel.font = self.titleFont;
    
    button.selected = YES;
    
    _selecetedBtn = button;
    _selecetedBtn.titleLabel.font = self.selectedTitleFont;
    
}

#pragma mark - 外部控制
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (selectedIndex >=0 && selectedIndex < _buttons.count) {
        
        UIButton *button = _buttons[selectedIndex];
        
        [self selectButton:button];
    }
}

- (NSInteger)selectedIndex {
    return _selecetedBtn.tag;
}

- (void)setBottomLineX:(CGFloat)bottomLineX {
    _bottomLineX = bottomLineX;
    
    _bottomLine.left    =   bottomLineX + _lineMinX;
    
    _bottomImage.left   =   bottomLineX + _imageMinX;
    
}

// 获取线的宽度
- (CGFloat)getBottomLineWidth:(NSInteger )textIndex {
    NSString *text = _titles[textIndex];
    CGFloat lineW = [text widthWithFont:_titleFont constrainedToHeight:self.frame.size.height-2]+4;
    
    return lineW;
}

- (NSMutableArray *)titlesWidthArray {
    if (!_titlesWidthArray) {
        _titlesWidthArray = [[NSMutableArray alloc] init];
    }
    return _titlesWidthArray;
}

@end
