

//
//  ResetButton.m
//  weidian
//
//  Created by 姜通 on 15/7/26.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ResetButton.h"
#import <Masonry/Masonry.h>
#import "Config.h"

@implementation ResetButton

-(instancetype)initWithFrame:(CGRect)frame WithImageString:(NSString *)imageString AndTitle:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageString];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = LittleTextLabelFont;
        label.text = title;
        [self addSubview:label];
        
        WS(weakSelf);
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.width.equalTo(@45);
            make.height.equalTo(@45);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(imageView.mas_bottom).offset(5);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
