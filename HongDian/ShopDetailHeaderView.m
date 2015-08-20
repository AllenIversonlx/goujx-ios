



//
//  ShopDetailHeaderView.m
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopDetailHeaderView.h"
#import "Config.h"
#import "ShopDoBuyShareView.h"
#import <Masonry/Masonry.h>


@implementation ShopDetailHeaderView
-(instancetype)initWithFrame:(CGRect)frame WithShopDetailMode:(ShopDeatilModel *)shopdetailModel
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.contentLable];
        [self addSubview:self.nameLabel];
        [self addSubview:self.favLabel];
        
        [self addSubview:self.rightImageView];
        [self addSubview:self.shopDoView];
        
        self.shopDetailModel = shopdetailModel;
    }
    return self;
}

-(void)setShopDetailModel:(ShopDeatilModel *)shopDetailModel
{
    WS(weakSelf);
    self.contentLable.text = shopDetailModel.describe;
    self.nameLabel.text = shopDetailModel.name;
    self.favLabel.text = [NSString stringWithFormat:@"%@人阅读 %@人喜欢 ",shopDetailModel.readCount,shopDetailModel.likeCount];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-415);
        make.left.equalTo(weakSelf.mas_left).offset(25);
        make.right.equalTo(weakSelf.mas_right).offset(-25);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-25);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@26);
        make.height.equalTo(@49);
    }];
    
    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(25);
        make.left.equalTo(weakSelf.mas_left).offset(25);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-130);
        make.right.equalTo(weakSelf.rightImageView.mas_right).offset(-25);
    }];
    
    
    [self.favLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-25);
        make.left.equalTo(weakSelf.mas_left).offset(25);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-106);
    }];
    
//    [self.shopDoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakSelf.mas_centerX);
//        make.bottom.equalTo(weakSelf.mas_bottom).offset(-40);
//        make.height.equalTo(@61);
//    }];
}

 #pragma mark - 计算label的高度
-(CGFloat)reloadCalcuteTheHeightWithString:(NSString *)string andFont:(int)fontint{
    UIFont *font = [UIFont fontWithName:nil size:fontint];
    CGSize size = CGSizeMake(320, 300);
    NSDictionary *detaildic = @{NSFontAttributeName:font};
    CGSize newSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:detaildic context:nil].size;
    CGFloat height = 10 + newSize.height;
    return height;
}


-(UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"detailButton"];
    }
    return _rightImageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:UserFont size:38];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

-(UILabel *)contentLable
{
    if (!_contentLable) {
        _contentLable = [[UILabel alloc] init];
        _contentLable.font = TextLabelFont;
        _contentLable.backgroundColor = [UIColor clearColor];
        _contentLable.textColor = [UIColor whiteColor];
        _contentLable.numberOfLines = 0;
    }
    return _contentLable;
}

-(UILabel *)readLabel
{
    if (!_readLabel) {
        _readLabel = [[UILabel alloc] init];
        _readLabel.font = LittleTextLabelFont;
        _readLabel.backgroundColor = [UIColor clearColor];
        _readLabel.textColor = [UIColor whiteColor];
    }
    return _readLabel;
}

-(UILabel *)favLabel
{
    if (!_favLabel) {
        _favLabel = [[UILabel alloc] init];
        _favLabel.font = LittleTextLabelFont;
        _favLabel.backgroundColor = [UIColor clearColor];
        _favLabel.textColor = [UIColor whiteColor];
    }
    return _favLabel;
}

-(ShopDoBuyShareView *)shopDoView{
    if (!_shopDoView) {
        WS(weakSelf);
        _shopDoView = [[ShopDoBuyShareView alloc] initWithFrame:CGRectMake(20, Screen_Height() - 40-61, Screen_Width() - 40, 60)];
        _shopDoView.shopDoViewBlock = ^(NSInteger tag){
            if (weakSelf.shopDetailblock) {
                weakSelf.shopDetailblock(tag);
            }
        };
    }
    return _shopDoView;
}



@end
