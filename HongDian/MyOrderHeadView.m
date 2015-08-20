


//
//  MyOrderHeadView.m
//  HongDian
//
//  Created by 姜通 on 15/8/12.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "MyOrderHeadView.h"
#import "Config.h"
#import <Masonry/Masonry.h>

@implementation MyOrderHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.orderNameLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.statusLabel];
        [self setUI];
    }
    return self;
}

-(void)setOrderModel:(MyOrderModel *)orderModel
{
    _dateLabel.text = orderModel.filingDate;
    _orderNameLabel.text = [NSString stringWithFormat:@"订单 %@",orderModel.documentNum];
    _statusLabel.text = orderModel.displayStatus;
    if ([_statusLabel.text isEqualToString:@"待发货"]) {
        _statusLabel.layer.borderColor = WaitForTheDelivery.CGColor;
        _statusLabel.textColor = WaitForTheDelivery;
    } else if ([_statusLabel.text isEqualToString:@"已发货"]) {
        _statusLabel.layer.borderColor = HasTheDelivery.CGColor;
        _statusLabel.textColor = HasTheDelivery;
    } else if ([_statusLabel.text isEqualToString:@"待付款"]) {
        _statusLabel.layer.borderColor = WaitForPayTheGood.CGColor;
        _statusLabel.textColor = WaitForPayTheGood;
    } else if ([_statusLabel.text isEqualToString:@"已取消"]) {
        _statusLabel.layer.borderColor = CancleTheOrder.CGColor;
        _statusLabel.textColor = CancleTheOrder;
    }
}

-(void)setUI{
    WS(weakSelf);
    [self.orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(9);
        make.left.equalTo(weakSelf.mas_left).offset(15);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-9);
        make.left.equalTo(weakSelf.mas_left).offset(15);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}

-(UILabel *)orderNameLabel
{
    if (!_orderNameLabel) {
        _orderNameLabel = [[UILabel alloc] init];
        _orderNameLabel.font = LittleTextLabelFont;
    }
    return _orderNameLabel;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = LittleTextLabelFont;
        _dateLabel.textColor = [UIColor lightGrayColor];
    }
    return _dateLabel;
}


-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = LittleTextLabelFont;
        _statusLabel.layer.borderColor = ButtonColor.CGColor;
        _statusLabel.textColor = ButtonColor;
        _statusLabel.layer.borderWidth = 1;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
//        _statusLabel.text.contentEdgeInsets = UIEdgeInsetsMake(5,10, 5, 10);
    }
    return _statusLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
