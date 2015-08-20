



//
//  UIButton+Utilis.m
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "UIButton+Utilis.h"
#import "Config.h"
#import <Masonry/Masonry.h>
@implementation UIButton (Utilis)

-(instancetype)initWithFrame:(CGRect)frame andString:(NSString *)number andNameString:(NSString *)nameString{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] init];
        label.text = number;
        [self addSubview:label];
        label.font = LittleTextLabelFont;
        label.textColor = ButtonColor;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = nameString;
        [self addSubview:nameLabel];
        nameLabel.font = LittleTextLabelFont;
        nameLabel.textColor = ButtonColor;
        
        [self addSubview:label];
        
        WS(weakSelf);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(label.mas_bottom).offset(5);
        }];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame andNumbleString:(NSString *)number andNameString:(NSString *)nameString{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] init];
        label.text = number;
        [self addSubview:label];
        label.font = LittleTextLabelFont;
        label.textColor = [UIColor whiteColor];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = nameString;
        [self addSubview:nameLabel];
        nameLabel.font = LittleTextLabelFont;
        nameLabel.textColor = [UIColor whiteColor];

        [self addSubview:label];
        
        WS(weakSelf);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(label.mas_bottom).offset(5);
        }];
    }
    return self;
}

+(UIButton *)buttonWithTitleString:(NSString *)title{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.borderColor = ButtonColor.CGColor;
    button.backgroundColor = ButtonColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 30;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = TextLabelFont;
    button.contentEdgeInsets = UIEdgeInsetsMake(5,10, 5, 10);
    return button;
}

+(UIButton *)borderbuttonWithTitleString:(NSString *)title{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.borderColor = ButtonColor.CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 30;
    [button setTitleColor:ButtonColor forState:UIControlStateNormal];
    button.titleLabel.font = TextLabelFont;
    button.contentEdgeInsets = UIEdgeInsetsMake(5,10, 5, 10);
    return button;
}

+(UIButton *)borderbuttonWithTitleString:(NSString *)title andWithColor:(UIColor *)color{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.borderColor = color.CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 30;
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = TextLabelFont;
    button.contentEdgeInsets = UIEdgeInsetsMake(5,10, 5, 10);
    return button;
}

@end
