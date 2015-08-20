


//
//  MyVouponTableViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/8/14.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "MyVouponTableViewCell.h"
#import "UIButton+Utilis.h"
#import "Config.h"
#import <Masonry/Masonry.h>

@implementation MyVouponTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 60)];
        [self addSubview:self.backView];
        self.backView.layer.borderWidth = 0.5;
        self.backView.layer.borderColor = CancleNomalColer.CGColor;
        [self.backView addSubview:self.nameLabel];
        [self.backView addSubview:self.numberLabel];
        [self.backView addSubview:self.statusLabel];
        [self.backView addSubview:self.dateLabel];
        
        [self setUI];
    }
    return self;
}
-(void)setUI{
    WS(weakSelf);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.centerY.equalTo(weakSelf.backView.mas_centerY);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.statusLabel.mas_left).offset(-5);
        make.top.equalTo(weakSelf.mas_top).offset(13);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.numberLabel.mas_bottom).offset(7);
    }];
}

/*
 <id>1</id>
 <name>超级代金券</name>
 <code>111212113</code>
 <discount>10.00</discount>
 <expireTimestamp>1439948396</expireTimestamp>
 <crmCouponStatus>未使用</crmCouponStatus>
 */

-(void)setCouponModel:(CouponModel *)couponModel
{
    _nameLabel.text = couponModel.name;
    _numberLabel.text = [NSString stringWithFormat:@"%@代金券",couponModel.discount];
    NSString *dateString = couponModel.expireTimestamp;
    double unixTimeStamp = [dateString doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *newdate = [formatter stringFromDate:date];
    _dateLabel.text = [NSString stringWithFormat:@"有效期至:%@",newdate];
    _statusLabel.text = couponModel.crmCouponStatus;
    if ([_statusLabel.text isEqualToString:@"未使用"]) {
        _statusLabel.layer.borderColor = CouponNotUsed.CGColor;
        _statusLabel.textColor = CouponNotUsed;
    } else if ([_statusLabel.text isEqualToString:@"已使用"]) {
        _statusLabel.layer.borderColor = CouponUsed.CGColor;
        _statusLabel.textColor = CouponUsed;
    } else if ([_statusLabel.text isEqualToString:@"已过期"]) {
        _statusLabel.layer.borderColor = CouponDateOld.CGColor;
        _statusLabel.textColor = CouponDateOld;
    }
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = TextLabelFont;
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = LittleTextLabelFont;
        _numberLabel.textColor = BuyCarNameColor;
    }
    return _numberLabel;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = LittleTextLabelFont;
        _dateLabel.textColor = CancleNomalColer;
    }
    return _dateLabel;
}

-(UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = LittleTextLabelFont;
        _statusLabel.layer.borderColor = CancleNomalColer.CGColor;
        _statusLabel.textColor = CancleNomalColer;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.layer.borderWidth = 0.5;
    }
    return _statusLabel;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
