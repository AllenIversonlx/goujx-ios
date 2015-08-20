


//
//  MyProfileOrderDetailTableViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/8/19.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "MyProfileOrderDetailTableViewCell.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
@implementation MyProfileOrderDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.headimageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.myMoneyLabel];
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
    
    [self.myMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(19);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.myMoneyLabel.mas_bottom).offset(3);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
    }];
}

 -(void)setProfileCellModel:(MyProfileCellModel *)profileCellModel
{
    self.numberLabel.text = [NSString stringWithFormat:@"%@",profileCellModel.quantity];
    self.myMoneyLabel.text = [NSString stringWithFormat:@"%@",profileCellModel.price];
    NSDictionary *dic = profileCellModel.mallProductSku;
    NSDictionary *mallProductDic = [dic objectForKey:@"mallProduct"];
    self.nameLabel.text = [mallProductDic objectForKey:@"name"];
    [self.headimageView sd_setImageWithURL:[NSURL URLWithString:[[mallProductDic objectForKey:@"cover"] objectForKey:@"absoluteMediaUrl"]]];
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
         _nameLabel.font = LittleTextLabelFont;
    }
    return _nameLabel;
}

-(UILabel *)myMoneyLabel
{
    if (!_myMoneyLabel) {
        _myMoneyLabel = [[UILabel alloc] init];
        _myMoneyLabel.text = @"￥780";
        _myMoneyLabel.font = LittleTextLabelFont;
    }
    return _myMoneyLabel;
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
