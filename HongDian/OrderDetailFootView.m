//
//  OrderDetailFootView.m
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "OrderDetailFootView.h"
#import <Masonry/Masonry.h>
#import "Config.h"
#import "UIButton+Utilis.h"

@implementation OrderDetailFootView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BackGroundColor;
        UILabel *peopleInformation = [[UILabel alloc] init];
        peopleInformation.text = @"收货人信息";
        peopleInformation.textColor = [UIColor lightGrayColor];
        peopleInformation.font = LittleTextLabelFont;
        [self addSubview:peopleInformation];
        
        UIView *peopleView = [[UIView alloc] init];
        peopleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        peopleView.layer.borderWidth = 0.5;
        [self addSubview:peopleView];
        
        peopleView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTheAddress)];
        [peopleView addGestureRecognizer:tap];
        
        self.namelabel = [[UILabel alloc] init];
        self.namelabel.font = TextLabelFont;
        [peopleView addSubview:self.namelabel];
        
        self.phoneLabel = [[UILabel alloc] init];
        self.phoneLabel.font = LittleTextLabelFont;
        [peopleView addSubview:self.phoneLabel];
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.font = LittleTextLabelFont;
        self.addressLabel.numberOfLines = 0;
        [peopleView addSubview:self.addressLabel];
        
        UIImageView *rightImageView = [[UIImageView alloc] init];
        rightImageView.image = [UIImage imageNamed:@"right_arrow"];
        [peopleView addSubview:rightImageView];
        
        WS(weakSelf);
        [peopleInformation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(15);
            make.top.equalTo(weakSelf.mas_top).offset(15);
        }];
        
        [peopleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(peopleInformation.mas_bottom).offset(5);
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.height.equalTo(@109);
        }];
        
        [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(peopleView.mas_left).offset(15);
            make.top.equalTo(peopleView.mas_top).offset(15);
        }];
        
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(peopleView.mas_left).offset(15);
            make.top.equalTo(weakSelf.namelabel.mas_bottom).offset(5);
        }];
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(peopleView.mas_left).offset(15);
            make.top.equalTo(weakSelf.phoneLabel.mas_bottom).offset(5);
            make.right.equalTo(peopleView.mas_right).offset(-100);
        }];
        
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(peopleView.mas_centerY);
            make.right.equalTo(peopleView.mas_right).offset(-15);
            make.width.equalTo(@9);
            make.height.equalTo(@18);
        }];

        UILabel *payInfomation = [[UILabel alloc] init];
        payInfomation.text = @"支付信息";
        payInfomation.textColor = [UIColor lightGrayColor];
        payInfomation.font = LittleTextLabelFont;
        [self addSubview:payInfomation];
        
        [payInfomation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(15);
            make.top.equalTo(peopleView.mas_bottom).offset(15);
        }];
        
        UIView *payView = [[UIView alloc] init];
        payView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        payView.layer.borderWidth = 0.5;
        [self addSubview:payView];
        payView.userInteractionEnabled = YES;
        UITapGestureRecognizer *payTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectThePayType)];
        [payView addGestureRecognizer:payTap];
        
        self.payImageView = [[UIImageView alloc] init];
        [payView addSubview:self.payImageView];
        self.payLabel = [[UILabel alloc] init];
        self.payLabel.font = TextLabelFont;
        [payView addSubview:self.payLabel];
        
        UIImageView *rightImageView2 = [[UIImageView alloc] init];
        rightImageView2.image = [UIImage imageNamed:@"right_arrow"];
        [payView addSubview:rightImageView2];
        
        [payView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(payInfomation.mas_bottom).offset(5);
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.height.equalTo(@59);
        }];
        
        [self.payImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(payView.mas_centerY);
            make.left.equalTo(payView.mas_left).offset(15);
            make.height.equalTo(@35);
            make.width.equalTo(@35);
        }];
        
        [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(payView.mas_centerY);
            make.left.equalTo(self.payImageView.mas_right).offset(15);
        }];
        
        [rightImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(payView.mas_centerY);
            make.right.equalTo(payView.mas_right).offset(-15);
            make.width.equalTo(@9);
            make.height.equalTo(@18);
        }];
        
        
        UIView *coupouView = [[UIView alloc] init];
        coupouView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        coupouView.layer.borderWidth = 0.5;
        [self addSubview:coupouView];
        coupouView.userInteractionEnabled = YES;
        UITapGestureRecognizer *coupounTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UsetTheCoupon)];
        [coupouView addGestureRecognizer:coupounTap];
        
        UIImageView *coupouImageView = [[UIImageView alloc] init];
        coupouImageView.image = [UIImage imageNamed:@"cupoun"];
        [coupouView addSubview:coupouImageView];
        
        UILabel *coupouLabel = [[UILabel alloc] init];
        coupouLabel.text = @"请使用优惠券";
        coupouLabel.font = TextLabelFont;
        [coupouView addSubview:coupouLabel];
        
        self.couponMoneyLabel = [[UILabel alloc] init];
        self.couponMoneyLabel.font = LittleTextLabelFont;
        self.couponMoneyLabel.layer.borderWidth = 0.5;
        self.couponMoneyLabel.text = @"无";
        self.couponMoneyLabel.textAlignment = NSTextAlignmentCenter;
        self.couponMoneyLabel.layer.cornerRadius = 10;
        self.couponMoneyLabel.layer.borderColor = CouponMoneyLabelColor.CGColor;
        self.couponMoneyLabel.textColor = CouponMoneyLabelColor;
        [coupouView addSubview:self.couponMoneyLabel];
        
        UIImageView *rightImageView3 = [[UIImageView alloc] init];
        rightImageView3.image = [UIImage imageNamed:@"right_arrow"];
        [coupouView addSubview:rightImageView3];
        
        [coupouView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(payView.mas_bottom).offset(5);
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.height.equalTo(@59);
        }];
        
        [coupouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(coupouView.mas_centerY);
            make.left.equalTo(coupouView.mas_left).offset(15);
            make.height.equalTo(@35);
            make.width.equalTo(@35);
        }];
        
        [coupouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(coupouView.mas_centerY);
            make.left.equalTo(coupouImageView.mas_right).offset(15);
        }];
        
        [rightImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(coupouView.mas_centerY);
            make.right.equalTo(coupouView.mas_right).offset(-15);
            make.width.equalTo(@9);
            make.height.equalTo(@18);
        }];

        
        [self.couponMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(coupouView.mas_centerY);
            make.right.equalTo(rightImageView.mas_left).offset(-15);
            make.width.equalTo(@100);
            make.height.equalTo(@28);
        }];
        
        UIView *timeView = [[UIView alloc] init];
        timeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        timeView.layer.borderWidth = 0.5;
        [self addSubview:timeView];
        
        UIImageView *timeImageView = [[UIImageView alloc] init];
        timeImageView.image = [UIImage imageNamed:@"time"];
        [timeView addSubview:timeImageView];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = @"请在订单生成后 2 小时内完成付款逾期订单将自动取消";
        timeLabel.font = LittleTextLabelFont;
        timeLabel.numberOfLines = 0;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [timeView addSubview:timeLabel];
        
        [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coupouView.mas_bottom).offset(15);
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.height.equalTo(@80);
        }];
        
        [timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(timeView.mas_centerY);
            make.left.equalTo(timeView.mas_left).offset(15);
            make.height.equalTo(@32);
            make.width.equalTo(@32);
        }];
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(timeImageView.mas_right).offset(40);
            make.right.equalTo(timeView.mas_right).offset(-80);
            make.centerY.equalTo(timeView.mas_centerY);
        }];
        
        
        UIButton *payButton = [UIButton buttonWithTitleString:@"付款"];
        [payButton addTarget:self action:@selector(payWithMoney) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:payButton];
        
        [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(timeView.mas_bottom).offset(35);
            make.height.equalTo(@60);
            make.left.equalTo(@25);
            make.right.equalTo(@-25);
        }];
        
        
        UIButton *cancleButton = [UIButton borderbuttonWithTitleString:@"取消订单" andWithColor:CancleNomalColer];
        [cancleButton addTarget:self action:@selector(cancleTheOrder) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancleButton];
        
        [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(payButton.mas_bottom).offset(5);
            make.height.equalTo(@60);
            make.left.equalTo(@25);
            make.right.equalTo(@-25);
        }];

//        UILabel *orderDipectionLabel = [[UILabel alloc] init];
//        orderDipectionLabel.text = @"下单时间 2015-08-10 23:32:12";
//        orderDipectionLabel.textColor = TimeColor;
//        orderDipectionLabel.font = LittleTextLabelFont;
//        [self addSubview:orderDipectionLabel];
        
//        [orderDipectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(weakSelf.mas_centerX);
//            make.top.equalTo(cancleButton.mas_bottom).offset(10);
//        }];
    }
    return self;
}

-(void)setAddressModel:(AddressModel *)addressModel
{
    self.namelabel.text = addressModel.shippingToName ;
    self.phoneLabel.text = addressModel.shippingToPhone;
    self.addressLabel.text = addressModel.address;
}

-(void)setPayModel:(PayModel *)payModel
{
    self.payImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",payModel.image]];
    self.payLabel.text = [NSString stringWithFormat:@"%@",payModel.name];
}

-(void)setCouponModel:(CouponModel *)couponModel
{
    self.couponMoneyLabel.text = [NSString stringWithFormat:@"%@元代金券",couponModel.discount];
}

-(void)payWithMoney{
     self.payTheGoodBlock();
}

-(void)cancleTheOrder{
    if (self.cancleBolck) {
        self.cancleBolck();
    }
}

-(void)selectTheAddress{
    if (self.selectAddressType) {
        self.selectAddressType();
    }
}

-(void)selectThePayType{
    if (self.selectPayType) {
        self.selectPayType();
    }
}

-(void)UsetTheCoupon{
    if (self.selectTheCouponTypeBlock) {
        self.selectTheCouponTypeBlock();
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
