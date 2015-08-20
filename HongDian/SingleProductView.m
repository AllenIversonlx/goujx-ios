


//
//  SingleProductView.m
//  HongDian
//
//  Created by 姜通 on 15/7/29.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "SingleProductView.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SingleProductView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BackGroundColor;
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.detailLable];
        [self addSubview:self.headImageScrollView];
        [self addSubview:self.pageControl];
        [self addSubview:self.buyCayButton];
        [self addSubview:self.collectionButton];
        [self addSubview:self.shareButton];
        [self addSubview:self.produceLabel];
        
        WS(weakSelf);
        _headImageScrollView.frame = CGRectMake(0, 0, Screen_Width(), Screen_Width());

        CGFloat imageHeight = Screen_Width() + 15;
        [_titleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(weakSelf.mas_top).offset(imageHeight);
        }];
        
        [_priceLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
        }];
        
        [_collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.height.equalTo(@70);
            make.width.equalTo(@50);
            make.top.equalTo(_priceLabel.mas_bottom).offset(15);
        }];
        
        [_buyCayButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@70);
            make.width.equalTo(@50);
            make.top.equalTo(_priceLabel.mas_bottom).offset(15);
            make.right.equalTo(_collectionButton.mas_left).offset(-34);
        }];
        
        [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@70);
            make.width.equalTo(@50);
            make.top.equalTo(_priceLabel.mas_bottom).offset(15);
            make.left.equalTo(_collectionButton.mas_right).offset(34);
        }];

        UILabel *lable1 = [[UILabel alloc] init];
        lable1.backgroundColor = CancleNomalColer;
        [self addSubview:lable1];
        [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.top.equalTo(_shareButton.mas_bottom).offset(25);
            make.height.equalTo(@0.5);
        }];
        
        UILabel *lable2 = [[UILabel alloc] init];
        lable2.backgroundColor = CancleNomalColer;
        [self addSubview:lable2];
        [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.top.equalTo(lable1.mas_bottom).offset(15);
            make.height.equalTo(@0.5);
        }];
        
        [self.produceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lable2.mas_bottom).offset(15);
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.height.equalTo(@40);
        }];
        
        UILabel *label3 = [[UILabel alloc] init];
        label3.text = @"........................";
        label3.font = LittleTextLabelFont;
        label3.textColor = CancleNomalColer;
        [self addSubview:label3];
         [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(weakSelf.produceLabel.mas_bottom).offset(0);
             make.centerX.equalTo(weakSelf.mas_centerX);
         }];
    }
    return self;
}

-(void)shareOrCollectionOrBuyCar:(UITapGestureRecognizer *)tap{
    ResetButton *view = (ResetButton *)[tap view];
    if (self.share_colletion_buycarBlock) {
        self.share_colletion_buycarBlock(view.tag);
    }
}


-(void)setFrameModel:(SingleProducrFrameModel *)frameModel
{
    _headImageScrollView.contentSize = CGSizeMake(frameModel.singleProductModel.image.count * Screen_Width(),Screen_Width());
    count = frameModel.singleProductModel.image.count;
    for (int i = 0; i < frameModel.singleProductModel.image.count; i ++) {
         _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i* Screen_Width(), 0, Screen_Width(), Screen_Width())];
        NSDictionary *dic = frameModel.singleProductModel.image[i];
        [_bigImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"absoluteMediaUrl"]]];
        _bigImageView.layer.masksToBounds = YES;
        _bigImageView.contentMode = UIViewContentModeScaleAspectFill;
        //UIViewContentModeScaleAspectFit
        [_headImageScrollView addSubview:_bigImageView];
    }
    _pageControl.frame = CGRectMake(120, _headImageScrollView.frame.size.height - 40, Screen_Width() - 240,40);
    _pageControl.numberOfPages = frameModel.singleProductModel.image.count;
    
    _titleLabel.text = frameModel.singleProductModel.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",frameModel.singleProductModel.salePrice];
}

-(UILabel *)produceLabel{
    if (!_produceLabel) {
        _produceLabel = [[UILabel alloc] init];
        _produceLabel.textAlignment = NSTextAlignmentCenter;
        _produceLabel.text = @"产品描述";
        _produceLabel.font = LittleTextLabelFont;
    }
    return _produceLabel;
}

-(ResetButton *)buyCayButton
{
    if (!_buyCayButton) {
        _buyCayButton = [[ResetButton alloc] initWithFrame:CGRectMake(0, 0, 45, 65) WithImageString:@"buycar_icon" AndTitle:@"购物车"];
        _buyCayButton.userInteractionEnabled = YES;
        _buyCayButton.tag = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareOrCollectionOrBuyCar:)];
        [_buyCayButton addGestureRecognizer:tap];
    }
    return _buyCayButton;
}

-(ResetButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [[ResetButton alloc] initWithFrame:CGRectMake(0, 0, 45, 65) WithImageString:@"buycar_icon" AndTitle:@"分享"];
        _shareButton.userInteractionEnabled = YES;
        _shareButton.tag = 2;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareOrCollectionOrBuyCar:)];
        [_shareButton addGestureRecognizer:tap];
    }
    return _shareButton;
}


-(ResetButton *)collectionButton
{
    if (!_collectionButton) {
        _collectionButton = [[ResetButton alloc] initWithFrame:CGRectMake(0, 0, 45, 65) WithImageString:@"buycar_icon" AndTitle:@"收藏"];
        _collectionButton.tag = 3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareOrCollectionOrBuyCar:)];
        [_collectionButton addGestureRecognizer:tap];
    }
    return _collectionButton;
}

-(UIScrollView *)headImageScrollView
{
    if (!_headImageScrollView) {
        _headImageScrollView = [[UIScrollView alloc] init];
        _headImageScrollView.bounces = YES;
        _headImageScrollView.userInteractionEnabled = YES;
        _headImageScrollView.pagingEnabled = YES;
        _headImageScrollView.showsHorizontalScrollIndicator = NO;
        _headImageScrollView.showsVerticalScrollIndicator = NO;
        _headImageScrollView.delegate = self;
    }
    return _headImageScrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = ThemeViewColor;
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
        _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageControl;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = LittleTextLabelFont;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = LittleTextLabelFont;
        _priceLabel.textColor = ButtonColor;
//        _priceLabel.text = @"11111111";
//        _priceLabel.backgroundColor = [UIColor redColor];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.numberOfLines = 0;
    }
    return _priceLabel;
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float x = self.headImageScrollView.contentOffset.x;
    self.pageControl.currentPage = x / Screen_Width();
}

//选择器的方法
- (void)turnPage
{
    NSInteger pageNum = self.pageControl.currentPage;
    CGPoint offset = self.headImageScrollView.contentOffset;
    offset.x = pageNum * Screen_Width();
    [self.headImageScrollView setContentOffset:offset animated:YES];
}

// 定时器 绑定的方法
- (void)runTimePage
{
    int page = (int)self.pageControl.currentPage;
    page++;
    page = page > count ? 0 : page ;
    self.pageControl.currentPage = page;
    [self turnPage];
}



@end
