

//
//  MyProfileOrderHeaderView.m
//  HongDian
//
//  Created by 姜通 on 15/8/19.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "MyProfileOrderHeaderView.h"
#import "Config.h"
#import <Masonry/Masonry.h>

@implementation MyProfileOrderHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.font = LittleTextLabelFont;
        [self addSubview:self.statusLabel];
        
        self.statusLabel.textColor = [UIColor whiteColor];
        self.statusLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        self.statusLabel.layer.borderWidth = 1;
        self.statusLabel.textAlignment = NSTextAlignmentCenter;
        
//        if ([statusString isEqualToString:@"1"]) {
//            self.backgroundColor = DelayToPayOrderColor;
//            statusLabel.text = @"待付款";
//        }
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"order_menu"];
        [self addSubview:imageView];
        
        self.orderMoneyLabel = [[UILabel alloc] init];
//        orderMoneyLabel.text = [NSString stringWithFormat:@"订单金额：￥%@",money];
        self.orderMoneyLabel.textColor = [UIColor whiteColor];
        self.orderMoneyLabel.font = TextLabelFont;
        [self addSubview:self.orderMoneyLabel];
        
        WS(weakSelf);
        
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@22);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.width.equalTo(@28);
            make.height.equalTo(@32);
        }];
        
        [self.orderMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).offset(32);
            make.centerX.equalTo(weakSelf.mas_centerX);
        }];
        
        
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.width.equalTo(@60);
            make.height.equalTo(@19);
            make.right.equalTo(weakSelf.mas_right).offset(-15);
        }];
        
        self.orderNumberLabel = [[UILabel alloc] init];
        self.orderNumberLabel.textColor = [UIColor whiteColor];
        self.orderNumberLabel.font = LittleTextLabelFont;
        [self addSubview:self.orderNumberLabel];
 
        [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderMoneyLabel.mas_bottom).offset(5);
            make.centerX.equalTo(weakSelf.mas_centerX);
        }];

    }
    return self;
}

-(void)setMyProfileOrderModel:(MyProfileOrderModel *)myProfileOrderModel
{
    self.orderMoneyLabel.text = [NSString stringWithFormat:@"订单金额%@",myProfileOrderModel.totalAmount];
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单：%@",myProfileOrderModel.documentNum];
    self.statusLabel.text = myProfileOrderModel.displayStatus;
    if ([self.statusLabel.text isEqualToString:@"待发货"]) {
        self.backgroundColor = WaitForTheDelivery;
    } else if ([self.statusLabel.text isEqualToString:@"已发货"]) {
        self.backgroundColor = HasTheDelivery;
    } else if ([self.statusLabel.text isEqualToString:@"待付款"]) {
        self.backgroundColor = WaitForPayTheGood;
    } else if ([self.statusLabel.text isEqualToString:@"已取消"]) {
        self.backgroundColor = CancleTheOrder;
    }
}

 
@end
