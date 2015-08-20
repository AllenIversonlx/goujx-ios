//
//  HeaderView.m
//  HongDian
//
//  Created by 姜通 on 15/8/11.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "HeaderView.h"
#import "Config.h"
#import <Masonry/Masonry.h>


@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)titleArray{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.onebutton];
        [self addSubview:self.twoButton];
        [self addSubview:self.label];
        [self addSubview:self.Ylabel];
        [self addSubview:self.label];
        [self addSubview:self.label2];
        
        self.label.hidden = NO;
        self.label2.hidden = YES;
        [self selectTab:0];
        
        self.titleArray = titleArray;
        [_onebutton setTitle:[titleArray objectAtIndex:0] forState:UIControlStateNormal];
        [_twoButton setTitle:[titleArray objectAtIndex:1] forState:UIControlStateNormal];
        [self setUI];
        
    }
    return self;
}

- (void)selectTab:(NSInteger)tag
{
    for (UIView *abtn in self.subviews) {
        if ([abtn isKindOfClass:[UIButton class]]) {
            UIButton *bb = (UIButton *)abtn;
            if (bb.tag  == tag) {
                bb.titleLabel.font = [UIFont fontWithName:nil size:17];
            } else {
                bb.titleLabel.font = [UIFont fontWithName:nil size:17];
            }
        }
    }
}

-(void)sureToBuy:(UIButton *)btn{
    if (btn.tag == 100) {
        self.label2.hidden = YES;
        self.label.hidden = NO;
    } else if (btn.tag ==101) {
        self.label2.hidden = NO;
        self.label.hidden = YES;
    }
    if (self.tapTheButtonBlock) {
        self.tapTheButtonBlock(btn.tag,btn);
    }
}

-(void)setUI {
    WS(weakSelf);
    [_onebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
    }];
    
    [_twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-30);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
    }];
    
    [_Ylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@2);
        make.width.equalTo(@2);
    }];
}

-(UIButton *)onebutton {
    if (!_onebutton) {
        _onebutton = [[UIButton alloc] init];
        [_onebutton addTarget:self action:@selector(sureToBuy:) forControlEvents:UIControlEventTouchUpInside];
        [_onebutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _onebutton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _onebutton.titleLabel.font = [UIFont systemFontOfSize: 17.0];
        _onebutton.tag = 100;
        [self selectTab:0];
        _onebutton.selected = YES;
    }
    return _onebutton;
}

-(UIButton *)twoButton {
    if (!_twoButton) {
        _twoButton = [[UIButton alloc] init];
        [_twoButton addTarget:self action:@selector(sureToBuy:) forControlEvents:UIControlEventTouchUpInside];
        _twoButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_twoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _twoButton.titleLabel.font = [UIFont systemFontOfSize: 17.0];
        _twoButton.tag = 101;
        [self selectTab:1];
    }
    return _twoButton;
}

-(UILabel *)Ylabel{
    if (!_Ylabel) {
        _Ylabel = [[UILabel alloc] init];
        _Ylabel.backgroundColor = [UIColor blackColor];
    }
    return _Ylabel;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(32, 33, 30, 2)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = ButtonColor;
    }
    return _label;
}

-(UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(88, 33, 30, 2)];
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.backgroundColor = ButtonColor;
    }
    return _label2;
}

@end
