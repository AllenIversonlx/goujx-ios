//
//  SingleBottomView.m
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "SingleBottomView.h"
#import <Masonry/Masonry.h>
@implementation SingleBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        [self addSubview:self.label];
        [self addSubview:self.priceLabel];
        [self addSubview:self.label2];
        [self addSubview:self.newPriceLabel];
        [self addSubview:self.addtoCarButton];
        [self addSubview:self.buyNowButton];
        [self MasonryView];

    }
    return self;
}

-(void)setFrameModel:(SingleProducrFrameModel *)frameModel
{
    _newPriceLabel.text = frameModel.singleProductModel.salePrice;
    _priceLabel.text = frameModel.singleProductModel.originalPrice;
}


-(void)MasonryView{
    WS(weakSelf);
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(@5);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_label.mas_right).offset(5);
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_priceLabel.mas_right).offset(5);
    }];
    
    [_newPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_label2.mas_right).offset(5);
    }];
    
    [_addtoCarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(@-5);
    }];
    [_buyNowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(_addtoCarButton.mas_left).offset(5);
    }];
}


-(UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text =@"原价:";
        _label.textColor = [UIColor lightGrayColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont fontWithName:nil size:12];
    }
    return _label;
}

-(UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.text =@"现价:";
        _label2.textColor = [UIColor redColor];
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.font = [UIFont fontWithName:nil size:12];
    }
    return _label2;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
         _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor lightGrayColor];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = [UIFont fontWithName:nil size:12];
    }
    return _priceLabel;
}

-(UILabel *)newPriceLabel{
    if (!_newPriceLabel) {
        _newPriceLabel = [[UILabel alloc] init];
        _newPriceLabel.textColor = [UIColor redColor];
        _newPriceLabel.textAlignment = NSTextAlignmentCenter;
        _newPriceLabel.font = [UIFont fontWithName:nil size:12];
    }
    return _newPriceLabel;
}

-(UIButton *)addtoCarButton{
    if (!_addtoCarButton) {
        _addtoCarButton = [[UIButton alloc] init];
        [_addtoCarButton addTarget:self action:@selector(buyToCar:) forControlEvents:UIControlEventTouchUpInside];
        [_addtoCarButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addtoCarButton.layer.borderColor = [UIColor colorWithRed:90/255.0 green:198/255.0 blue:184/255.0 alpha:1.0].CGColor;
        _addtoCarButton.layer.borderWidth = 1;
        [_addtoCarButton setTitleColor:[UIColor colorWithRed:90/255.0 green:198/255.0 blue:184/255.0 alpha:1.0] forState:UIControlStateNormal];
        _addtoCarButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        _addtoCarButton.contentEdgeInsets = UIEdgeInsetsMake(5,10, 5, 10);
        _addtoCarButton.tag = 1;
    }
    return _addtoCarButton;
}

-(UIButton *)buyNowButton{
    if (!_buyNowButton) {
        _buyNowButton = [[UIButton alloc] init];
        [_buyNowButton addTarget:self action:@selector(buyToCar:) forControlEvents:UIControlEventTouchUpInside];
        [_buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyNowButton.layer.borderColor = [UIColor colorWithRed:90/255.0 green:198/255.0 blue:184/255.0 alpha:1.0].CGColor;
        _buyNowButton.layer.borderWidth = 1;
        [_buyNowButton setTitleColor:[UIColor colorWithRed:90/255.0 green:198/255.0 blue:184/255.0 alpha:1.0] forState:UIControlStateNormal];
        _buyNowButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        _buyNowButton.contentEdgeInsets = UIEdgeInsetsMake(5,10, 5, 10);
        _buyNowButton.tag = 2;
    }
    return _buyNowButton;
}


-(void)buyToCar:(UIButton *)btn{
    self.tapButtonBlock(btn.tag);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
