//
//  CMNavigationView.m
//  CMKanKan
//
//  Created by 夏和奇 on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "CMNavigationView.h"
#import "UIColor+HexString.h"

@interface CMNavigationView ()

@property (nonatomic, strong) UIView *lineView;
@end
@implementation CMNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#303031"];
        [self addSubview:_titleLabel];
        
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"nav_back_icon"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_backButton];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#c2c2c2"];
        [self addSubview:_lineView];
        
        self.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
- (void)updateConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).with.mas_offset(10);
        make.centerX.equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.mas_offset(3);
        make.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [super updateConstraints];
}

- (void)backBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationViewDidSelectedBack:)]) {
        [self.delegate navigationViewDidSelectedBack:self];
    }
}
@end
