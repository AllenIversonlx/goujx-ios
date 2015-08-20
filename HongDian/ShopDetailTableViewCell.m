//
//  ShopDetailTableViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopDetailTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ShopDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imageShodow];
        [self.contentView addSubview:self.headImageView];
//        [self.contentView addSubview:self.shopDoView];
//        [self setUI];
    }
    return self;
}

-(ShopDetailImgaeModel *)getImageModel
{
    return  self.shopDetailImageModel;
}

-(void)setShopDetailImageModel:(ShopDetailImgaeModel *)shopDetailImageModel
{
    WS(weakSelf);
    NSDictionary *imageDic = shopDetailImageModel.image;
    _shopDoView = [[ShopDoBuyShareView alloc] initWithFrame:CGRectMake(60, Screen_Height() - 40-61, Screen_Width() - 120, 60)];
    _shopDoView.shopDoViewBlock = ^(NSInteger tag){
        if (weakSelf.shopDetailSelectBlock) {
            weakSelf.shopDetailSelectBlock(tag,shopDetailImageModel);
        }
    };
    [self.contentView addSubview:self.shopDoView];

    [self.headImageView sd_setImageWithURL:[imageDic objectForKey:@"absoluteMediaUrl"]];
}

-(void)setUI{
    WS(weakSelf);
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(12);
        make.right.equalTo(weakSelf.mas_right).offset(-12);
        make.top.equalTo(weakSelf.mas_top).offset(55);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-122);
    }];
}

-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 55, Screen_Width() - 24,  (Screen_Width() - 24) * 7 / 5)];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}

-(UIImageView *)imageShodow
{
    if (!_imageShodow) {
        _imageShodow = [[UIImageView alloc] initWithFrame:CGRectMake(10, 85, Screen_Width() - 20,  (Screen_Width() - 24) * 7 / 5 + 30)];
        _imageShodow.layer.masksToBounds = YES;
        _imageShodow.image = [UIImage imageNamed:@"Image_shadow"];
        _imageShodow.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageShodow;
}

//-(ShopDoBuyShareView *)shopDoView{
//    if (!_shopDoView) {
//        WS(weakSelf);
//        _shopDoView = [[ShopDoBuyShareView alloc] initWithFrame:CGRectMake(60, Screen_Height() - 40-61, Screen_Width() - 120, 60)];
//        _shopDoView.shopDoViewBlock = ^(NSInteger tag){
//            if (weakSelf.shopDetailSelectBlock) {
//                weakSelf.shopDetailSelectBlock(tag,weakSelf.shopDetailImageModel);
//            }
//        };
//    }
//    return _shopDoView;
//}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
