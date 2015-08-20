

//
//  PersonTableViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "PersonTableViewCell.h"
#import "Config.h"
#import <Masonry/Masonry.h>


@implementation PersonTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backView];
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.right_arrowImageView];
        [self setUI];
    }
    return self;
}

-(void)setPayModel:(PayModel *)payModel
{
//    NSString *omSaleOrderPaymentChannel = payModel.omSaleOrderPaymentChannel;
//    
//    if (omSaleOrderPaymentChannel) {
//        if ([omSaleOrderPaymentChannel isEqualToString:@"微信支付"]) {
//            self.nameLabel.text = @"微信支付";
//            self.headImageView.image = [UIImage imageNamed:@"wechat_L"];
//        } else if ([omSaleOrderPaymentChannel isEqualToString:@"支付宝支付"]) {
//            self.headImageView.image = [UIImage imageNamed:@"alipay_icon"];
//            self.nameLabel.text = @"支付宝支付";
//        }
//    }
    self.nameLabel.text = payModel.name;
    self.headImageView.image = [UIImage imageNamed: payModel.image];
}


//-(void)applyWithTitilString:(NSString *)string andIMageString:(NSString *)imagestring{
//    self.nameLabel.text = string;
//    self.headImageView.image = [UIImage imageNamed:imagestring];
//}

-(void)setUI{
    WS(weakSelf);
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@60);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(10);
        make.top.equalTo(weakSelf.mas_top).offset(0);
        make.width.equalTo(weakSelf.mas_width);
    }];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView.mas_centerY);
        make.left.equalTo(@15);
        make.height.equalTo(@35);
        make.width.equalTo(@35);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageView.mas_right).offset(10);
        make.height.equalTo(@40);
        make.top.equalTo(weakSelf.backView.mas_top).offset(20);
        make.bottom.equalTo(weakSelf.backView.mas_bottom).offset(-20);
    }];
    
    [_right_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView.mas_centerY);
        make.right.equalTo(_backView.mas_right).offset(-25);
        make.width.equalTo(@9);
        make.height.equalTo(@18);
    }];
}

-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
    }
    return _headImageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = TextLabelFont;
    }
    return _nameLabel;
}

-(UIImageView *)right_arrowImageView
{
    if (!_right_arrowImageView) {
        _right_arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
    }
    return _right_arrowImageView;
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
//        _backView.backgroundColor = [UIColor greenColor];
        _backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _backView.layer.borderWidth = 0.5;
    }
    return _backView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
