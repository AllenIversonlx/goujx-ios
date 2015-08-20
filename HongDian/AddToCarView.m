

//
//  AddToCarView.m
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "AddToCarView.h"
#import <Masonry/Masonry.h>
#import "Config.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation AddToCarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
//        [self addSubview:self.moneyLabel];
        [self MasonryTheView];
    }
    return self;
}

-(void)MasonryTheView{
    WS(weakSelf);
   [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.centerY.equalTo(weakSelf.mas_centerY);
       make.right.equalTo(weakSelf.mas_right).offset(-15);
       make.top.equalTo(weakSelf.mas_top).offset(15);
       make.width.equalTo(@20);
       make.height.equalTo(@20);
   }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_imageView.mas_right).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(20);
//        make.top.equalTo(@10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-80);
    }];
    
//    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_imageView.mas_right).offset(10);
//        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
//        make.right.equalTo(weakSelf.mas_right).offset(-5);
//    }];
}

-(void)setFrameModel:(SingleProducrFrameModel *)frameModel
{
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:frameModel.singleProductModel.cover]];
    self.titleLabel.text = frameModel.singleProductModel.name;
//    self.moneyLabel.text = frameModel.singleProductModel.salePrice;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
//        _imageView.layer.borderWidth = 1;
        _imageView.image = [UIImage imageNamed:@"delete_icon"];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleThePushView)];
        [_imageView addGestureRecognizer:tap];
//        _imageView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _imageView;
}

-(void)cancleThePushView{
    if (self.canclePushViewBlock) {
        self.canclePushViewBlock();
    }
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = LittleTextLabelFont;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont fontWithName:nil size:12];
        _moneyLabel.textColor = [UIColor redColor];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.numberOfLines = 0;
    }
    return _moneyLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
