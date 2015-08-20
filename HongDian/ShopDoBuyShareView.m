//
//  ShopDoBuyShareView.m
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopDoBuyShareView.h"
#import <Masonry/Masonry.h>

@implementation ShopDoBuyShareView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.shareImageView];
        [self addSubview:self.collectionImageView];
        [self addSubview:self.wrongImageView];
        [self addSubview:self.rightImageView];
        [self addSubview:self.buyImageView];
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    WS(weakSelf);
    [self.buyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@61);
        make.height.equalTo(@61);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.buyImageView.mas_left).offset(-15);
        make.width.equalTo(@32);
        make.height.equalTo(@32);
    }];
    
    [self.wrongImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.rightImageView.mas_left).offset(-15);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@32);
        make.height.equalTo(@32);
    }];
    
    [self.shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.buyImageView.mas_right).offset(15);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@32);
        make.height.equalTo(@32);
    }];

    [self.collectionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.shareImageView.mas_right).offset(15);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@32);
        make.height.equalTo(@32);
    }];
}

-(void)shopDoBuyView:(UITapGestureRecognizer *)tap{
    UIImageView *imageView = (UIImageView *)[tap view];
    if (self.shopDoViewBlock) {
        self.shopDoViewBlock(imageView.tag);
    }
}

-(UIImageView *)shareImageView
{
    if (!_shareImageView) {
        _shareImageView = [[UIImageView alloc] init];
        _shareImageView.image = [UIImage imageNamed:@"share"];
        _shareImageView.layer.masksToBounds = YES;
        _shareImageView.layer.cornerRadius = 16;
        _shareImageView.userInteractionEnabled = YES;
        _shareImageView.tag = 5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopDoBuyView:)];
        [_shareImageView addGestureRecognizer:tap];
    }
    return _shareImageView;
}


-(UIImageView *)collectionImageView
{
    if (!_collectionImageView) {
        _collectionImageView = [[UIImageView alloc] init];
        _collectionImageView.image = [UIImage imageNamed:@"collection_ico"];
        _collectionImageView.layer.masksToBounds = YES;
        _collectionImageView.layer.cornerRadius = 16;
        _collectionImageView.userInteractionEnabled = YES;
        _collectionImageView.tag = 4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopDoBuyView:)];
        [_collectionImageView addGestureRecognizer:tap];
    }
    return _collectionImageView;
}


-(UIImageView *)buyImageView
{
    if (!_buyImageView) {
        _buyImageView = [[UIImageView alloc] init];
        _buyImageView.image = [UIImage imageNamed:@"buy_icon"];
        _buyImageView.layer.masksToBounds = YES;
        _buyImageView.layer.cornerRadius = 61 / 2;
        _buyImageView.userInteractionEnabled = YES;
        _buyImageView.tag = 3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopDoBuyView:)];
        [_buyImageView addGestureRecognizer:tap];
    }
    return _buyImageView;
}

-(UIImageView *)wrongImageView
{
    if (!_wrongImageView) {
        _wrongImageView = [[UIImageView alloc] init];
        _wrongImageView.image = [UIImage imageNamed:@"wrong"];
        _wrongImageView.layer.masksToBounds = YES;
        _wrongImageView.layer.cornerRadius = 16;
        _wrongImageView.userInteractionEnabled = YES;
        _wrongImageView.tag = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopDoBuyView:)];
        [_wrongImageView addGestureRecognizer:tap];
    }
    return _wrongImageView;
}

-(UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"right"];
        _rightImageView.layer.masksToBounds = YES;
        _rightImageView.layer.cornerRadius = 16;
        _rightImageView.userInteractionEnabled = YES;
        _rightImageView.tag = 2;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopDoBuyView:)];
        [_rightImageView addGestureRecognizer:tap];

    }
    return _rightImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
