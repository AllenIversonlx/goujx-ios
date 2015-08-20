

//
//  OrderDetailHeadView.m
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "OrderDetailHeadView.h"
#import "Config.h"
#import <Masonry/Masonry.h>
@implementation OrderDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame andWithMoney:(NSString *)money andOrderNumber:(NSString *)orderString andStatus:(NSString *)statusString{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *statusLabel = [[UILabel alloc] init];
        statusLabel.font = LittleTextLabelFont;
        [self addSubview:statusLabel];
        statusLabel.textColor = [UIColor whiteColor];
        statusLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        statusLabel.layer.borderWidth = 1;
        statusLabel.textAlignment = NSTextAlignmentCenter;
        
        if ([statusString isEqualToString:@"1"]) {
            self.backgroundColor = DelayToPayOrderColor;
            statusLabel.text = @"待付款";
        }
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"order_menu"];
        [self addSubview:imageView];
        
        UILabel *orderMoneyLabel = [[UILabel alloc] init];
        orderMoneyLabel.text = [NSString stringWithFormat:@"订单金额：￥%@",money];
        orderMoneyLabel.textColor = [UIColor whiteColor];
        orderMoneyLabel.font = TextLabelFont;
        [self addSubview:orderMoneyLabel];
        
        WS(weakSelf);

        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@22);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.width.equalTo(@28);
            make.height.equalTo(@32);
        }];
        
        [orderMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).offset(32);
            make.centerX.equalTo(weakSelf.mas_centerX);
        }];
            
        
        [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.width.equalTo(@60);
            make.height.equalTo(@19);
            make.right.equalTo(weakSelf.mas_right).offset(-15);
        }];
        
        UILabel *orderNumberLabel = [[UILabel alloc] init];
        orderNumberLabel.textColor = [UIColor whiteColor];
        orderNumberLabel.font = LittleTextLabelFont;
        [self addSubview:orderNumberLabel];

        if ([orderString isEqualToString:@""]) {
            orderNumberLabel.text = [NSString stringWithFormat:@"订单号 - %@",orderString];
        } else {
            orderNumberLabel.text = [NSString stringWithFormat:@"订单号  %@",orderString];
        }

        [orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderMoneyLabel.mas_bottom).offset(5);
            make.centerX.equalTo(weakSelf.mas_centerX);
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
