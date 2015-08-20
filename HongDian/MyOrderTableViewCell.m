


//
//  MyOrderTableViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/8/12.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MyOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.headimageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.numberLabel];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    WS(weakSelf);
    [self.headimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
        make.left.equalTo(weakSelf.mas_left).offset(15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.headimageView.mas_right).offset(15);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(19);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moneyLabel.mas_bottom).offset(3);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
    }];
}

-(BuyCarModel *)getbuyCarModel
{
    return self.buyCarModel;
}

- (void)applyModelValueWithModel:(BuyCarModel *)buyCarModel andCount:(int)count
{
    self.buyCarModel= buyCarModel;
    self.numberLabel.text = [NSString stringWithFormat:@"%@",buyCarModel.quantity];
    MallProductSkuModel *productSkuModel = [MallProductSkuModel objectWithKeyValues:buyCarModel.mallProductSku];
    self.mallProductSkuId = productSkuModel.id;

    MallProductModel *productModel = [MallProductModel objectWithKeyValues:productSkuModel.mallProduct];
    
    NSDictionary *dic = productModel.cover;

    [self.headimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"absoluteMediaUrl"]]]];
    self.moneyLabel.text = [NSString stringWithFormat:@" %.2f", [productModel.salePrice floatValue]];
//    self.totalfees =  [productModel.salePrice floatValue];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", productModel.name];
//    if (productSkuModel.baseColor == nil) {
//        self.lb_goo.text = [NSString stringWithFormat:@"%@ ",productSkuModel.size ];
//    }  else if (productSkuModel.size == nil) {
//        self.lb_goods_brand.text = [NSString stringWithFormat:@"%@ ",productSkuModel.baseColor ];
//    } else {
//        self.lb_goods_brand.text = [NSString stringWithFormat:@"%@ |  %@",productSkuModel.size,productSkuModel.baseColor];
//    }
}

-(UIImageView *)headimageView
{
    if (!_headimageView) {
        _headimageView = [[UIImageView alloc] init];
        _headimageView.layer.masksToBounds = YES;
        _headimageView.contentMode = UIViewContentModeScaleAspectFit;
        _headimageView.image = [UIImage imageNamed:@"personImageHeader"];
    }
    return _headimageView;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
//        _nameLabel.text= @"锦向锦向锦向";
        _nameLabel.font = LittleTextLabelFont;
    }
    return _nameLabel;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.text = @"￥780";
        _moneyLabel.font = LittleTextLabelFont;
    }
    return _moneyLabel;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.text = @"2件";
        _numberLabel.font = LittleTextLabelFont;
    }
    return _numberLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
