

//
//  PayGoodsTableViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "PayGoodsTableViewCell.h"
#import <Masonry/Masonry.h>
#import "Config.h"
@interface PayGoodsTableViewCell ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIImageView *img_seperator;
@property (nonatomic, strong) UIImageView *img_goods_image;
@property (nonatomic, strong) UILabel *lb_goods_name;
@property (nonatomic, strong) UILabel *lb_goods_brand;
@property (nonatomic, strong) UILabel *lb_goods_price;
@property (nonatomic, strong) UILabel *lb_goods_count;
@property (nonatomic, strong) UILabel *buyCountLabel;

//暂存
@property (nonatomic, strong) BuyCarModel *model;
@end



@implementation PayGoodsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
        self.frame = CGRectMake(0, 0, Screen_Width(), CART_SHOW_CELL_HEIGHT);
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}



- (void)setupSubviews
{
    [self.contentView addSubview:self.img_goods_image];
    [self.contentView addSubview:self.lb_goods_name];

    [self.contentView addSubview:self.lb_goods_price];
    [self.contentView addSubview:self.lb_goods_brand];
    [self.contentView addSubview:self.buyCountLabel];
    [self.contentView addSubview:self.lb_goods_brand];
    
    //layout
    WS(Cell);
    
    [_img_goods_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
        make.centerY.equalTo(Cell.mas_centerY);
    }];
    
    [_lb_goods_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Cell.mas_top).offset(15);
        make.left.equalTo(_img_goods_image.mas_right).offset(5);
        make.right.equalTo(@-5);
    }];
    
    [_lb_goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lb_goods_name.mas_bottom).offset(5);
        make.left.equalTo(_img_goods_image.mas_right).offset(5);
        make.right.equalTo(@-5);
    }];
    
    [_lb_goods_brand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lb_goods_price.mas_bottom).offset(5);
        make.left.equalTo(_img_goods_image.mas_right).offset(5);
        make.right.equalTo(@-5);
    }];
    
    [_buyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lb_goods_brand.mas_bottom).offset(13);
        make.left.equalTo(_img_goods_image.mas_right).offset(5);
        make.right.equalTo(@-5);
    }];
}


-(BuyCarModel *)getModel
{
    return self.model;
}


- (void)applyModelValueWithModel:(BuyCarModel *)model andCount:(int)count
{
    self.model = model;
    self.lb_goods_count.text = [NSString stringWithFormat:@"%d",1];
    
    //    [self.img_goods_image setImageWithURL:[NSURL URLWithString:model.goods_list_image[0]] placeholderImage:nil];
    self.lb_goods_price.text = [NSString stringWithFormat:@"%.2f 元",11.444];
    self.lb_goods_name.text = @"xxxxxxxx";
    self.lb_goods_brand.text = @"xxxxxxxx";
}



#pragma mark - getters

- (UIImageView *)img_seperator
{
    if (!_img_seperator) {
        _img_seperator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    }
    return _img_seperator;
}

- (UIImageView *)img_goods_image
{
    if (!_img_goods_image) {
        _img_goods_image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _img_goods_image.contentMode = UIViewContentModeScaleAspectFit;
        _img_goods_image.layer.borderWidth = 1;
        _img_goods_image.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _img_goods_image;
}

- (UILabel *)lb_goods_name
{
    if (!_lb_goods_name) {
        _lb_goods_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        _lb_goods_name.font = [UIFont systemFontOfSize:20];
        _lb_goods_name.textAlignment = NSTextAlignmentLeft;
        _lb_goods_name.text = @"xxxxxxxxxxxxxxx";
        _lb_goods_name.textColor = [UIColor blackColor];
        _lb_goods_name.numberOfLines = 0;
    }
    return _lb_goods_name;
}

- (UILabel *)lb_goods_brand
{
    if (!_lb_goods_brand) {
        _lb_goods_brand = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 18)];
        _lb_goods_brand.font = [UIFont systemFontOfSize:16];
        _lb_goods_brand.textAlignment = NSTextAlignmentLeft;
        _lb_goods_brand.textColor = [UIColor lightGrayColor];
        _lb_goods_brand.text =  [NSString stringWithFormat:@"尺码: %@  颜色%@", @"白",@"1"];
    }
    return _lb_goods_brand;
}

- (UILabel *)lb_goods_price
{
    if (!_lb_goods_price) {
        _lb_goods_price = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        _lb_goods_price.font = [UIFont systemFontOfSize:18];
        _lb_goods_price.textAlignment = NSTextAlignmentLeft;
        _lb_goods_price.text = @"1800";
        _lb_goods_price.textColor = [UIColor redColor];
    }
    return _lb_goods_price;
}


-(UILabel *)buyCountLabel
{
    if (!_buyCountLabel) {
        _buyCountLabel = [[UILabel alloc] init];
        _buyCountLabel.textColor = [UIColor blackColor];
        _buyCountLabel.text = @"购买数量: 1";
        _buyCountLabel.font = [UIFont fontWithName:nil size:16];
    }
    return _buyCountLabel;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
