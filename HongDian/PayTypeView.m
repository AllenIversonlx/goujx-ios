


//
//  PayTypeView.m
//  HongDian
//
//  Created by 姜通 on 15/8/6.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "PayTypeView.h"
#import <Masonry/Masonry.h>
#import "Config.h"

@implementation PayTypeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"支付方式";
        [self addSubview:label];
        UIImageView *wechatImageView = [[UIImageView alloc] init];
        wechatImageView.layer.borderColor = [UIColor blackColor].CGColor;
        wechatImageView.layer.borderWidth = 1;
        [self addSubview:wechatImageView];
        wechatImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wechatpay)];
        [wechatImageView addGestureRecognizer:tap];
        
        
        UILabel *wechatLabel = [[UILabel alloc] init];
        wechatLabel.text = @"微信支付";
        wechatLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:wechatLabel];
        
        UIImageView *aliImageView = [[UIImageView alloc] init];
        aliImageView.layer.borderColor = [UIColor blackColor].CGColor;
        aliImageView.layer.borderWidth = 1;
        [self addSubview:aliImageView];
        aliImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aliPay)];
        [aliImageView addGestureRecognizer:tap1];
        
        UILabel *aliLabel = [[UILabel alloc] init];
        aliLabel.text = @"支付宝支付";
        [self addSubview:aliLabel];
        aliLabel.textAlignment = NSTextAlignmentCenter;
        
        WS(weakSelf);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(@20);
        }];
        
        [wechatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.top.equalTo(label.mas_bottom).offset(20);
            make.width.equalTo(@100);
            make.height.equalTo(@100);
        }];
        
        [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@50);
            make.top.equalTo(wechatImageView.mas_bottom).offset(10);
        }];
        
        [aliImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-40);
            make.top.equalTo(label.mas_bottom).offset(20);
            make.width.equalTo(@100);
            make.height.equalTo(@100);
        }];
        
        [aliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-50);
            make.top.equalTo(aliImageView.mas_bottom).offset(10);
        }];
    }
    return self;
}


-(void)wechatpay{
    if (self.wechatPayBlock) {
        self.wechatPayBlock();
    }
}

-(void)aliPay{
    if (self.aliPayBlock) {
        self.aliPayBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
