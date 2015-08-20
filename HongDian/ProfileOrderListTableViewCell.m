



//
//  ProfileOrderListTableViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ProfileOrderListTableViewCell.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ProfileOrderListTableViewCell

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

 -(void)setMyModel:(MyOrderOmSaleOrderModel *)myModel
{
    _moneyLabel.text = [NSString stringWithFormat:@"￥%@",myModel.price];
    _numberLabel.text = [NSString stringWithFormat:@"%@件",myModel.quantity];
    NSDictionary *dic = myModel.mallProductSku;
    NSDictionary *mallProductDic = [dic objectForKey:@"mallProduct"];
    NSDictionary *coverDic = [mallProductDic objectForKey:@"cover"];
    _nameLabel.text =  [mallProductDic objectForKey:@"name"];
    [_headimageView sd_setImageWithURL:[NSURL URLWithString:[coverDic objectForKey:@"absoluteMediaUrl"]]];
}


-(UIImageView *)headimageView
{
    if (!_headimageView) {
        _headimageView = [[UIImageView alloc] init];
        _headimageView.layer.masksToBounds = YES;
        _headimageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _headimageView;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = LittleTextLabelFont;
    }
    return _nameLabel;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = LittleTextLabelFont;
    }
    return _moneyLabel;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
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
