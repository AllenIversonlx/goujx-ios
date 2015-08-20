
//
//  ShopListCollectionViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/7/16.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopListCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "Config.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ShopListCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        self.imageView.frame = CGRectMake(0, 0,Screen_Width() / 2 - 2.5, Screen_Width() / 2- 2.5);
        [self addSubview:self.contentLabel];
        [self addSubview:self.dateLabel];
        
        [self MasonryTheView];
    }
    return self;
}

-(void)MasonryTheView{
    WS(weakSelf);

    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageView.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.bottom.equalTo(weakSelf.dateLabel.mas_top).offset(-3);
        make.height.equalTo(@40);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentLabel.mas_bottom).offset(3);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
    }];
}

-(void)setShopListModel:(ShopListModel *)shopListModel
{
    NSDictionary *dic = shopListModel.cover;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"absoluteMediaUrl"]]];
    self.contentLabel.text = shopListModel.name;
    self.dateLabel.text = [NSString stringWithFormat:@"￥%@",shopListModel.salePrice];
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.masksToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = LittleTextLabelFont;
    }
    return _contentLabel;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = ButtonColor;
        _dateLabel.font = LittleTextLabelFont;
    }
    return _dateLabel;
}


@end
