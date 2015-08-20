


//
//  ProfileCollectionReusableView.m
//  HongDian
//
//  Created by 姜通 on 15/8/14.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ProfileCollectionReusableView.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "UIButton+Utilis.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ProfileCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ProfileLikeColor;
        [self addSubview:self.backImageView];
        [self addSubview:self.setImageView];
        [self addSubview:self.headImageView];
        [self addSubview:self.nameLabel];
        NSString *omCrmUserLikeProductString = [[NSUserDefaults standardUserDefaults] objectForKey:omCrmUserLikeProduct];
       NSString *omCrmCouponCountString = [[NSUserDefaults standardUserDefaults] objectForKey:omCrmCouponCount];
        NSString *omSaleOrderCountString = [[NSUserDefaults standardUserDefaults] objectForKey:omSaleOrderCount];

        if (omCrmUserLikeProductString) {
            self.collectionbutton = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width() - 50 * 3 - 80 ) / 2, 193, 50, 37) andString:[NSString stringWithFormat:@"%@",omCrmUserLikeProductString] andNameString:@"我的收藏"];
        } else {
            self.collectionbutton = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width() - 50 * 3 - 80 ) / 2, 193, 50, 37) andString:@"0" andNameString:@"我的收藏"];
        }
        self.collectionbutton.tag = 100;
        [self.collectionbutton addTarget:self action:@selector(changeTheType:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.collectionbutton];
        
        if (omCrmCouponCountString) {
            self.daijinButton = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width() - 50 * 3 - 80 ) / 2 + 50 + 40, 193, 50, 37) andNumbleString:[NSString stringWithFormat:@"%@",omCrmCouponCountString] andNameString:@"代金券"];
        } else {
            self.daijinButton = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width() - 50 * 3 - 80 ) / 2 + 50 + 40, 193, 50, 37) andNumbleString:@"0" andNameString:@"代金券"];
        }
        self.daijinButton.tag = 101;
        [self.daijinButton addTarget:self action:@selector(changeTheType:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.daijinButton];
        
        if (omSaleOrderCountString) {
            self.orderButton = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width() - 50 * 3 - 80 ) / 2 +  180, 193, 50, 37) andNumbleString:[NSString stringWithFormat:@"%@",omSaleOrderCountString] andNameString:@"我的订单"];
        } else {
            self.orderButton = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width() - 50 * 3 - 80 ) / 2 +  180, 193, 50, 37) andNumbleString:@"0" andNameString:@"我的订单"];
        }
        self.orderButton.tag = 102;
        [self.orderButton addTarget:self action:@selector(changeTheType:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.orderButton];
        
        
        WS(weakSelf);
        [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(25);
            make.top.equalTo(weakSelf.mas_top).offset(37);
            make.width.equalTo(@13);
            make.height.equalTo(@21);
        }];
        
        [self.setImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).offset(-25);
            make.top.equalTo(weakSelf.mas_top).offset(37);
            make.width.equalTo(@25);
            make.height.equalTo(@25);
        }];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.height.equalTo(@85);
            make.width.equalTo(@85);
            make.top.equalTo(weakSelf.mas_top).offset(56);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(weakSelf.headImageView.mas_bottom).offset(10);
        }];
    }
    return self;
}

-(void)setUI{
}

-(void)changeTheType:(UIButton *)sender {
    if (self.changethetypeBlock) {
        self.changethetypeBlock(sender.tag,sender);
    }
}

-(UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"BackArrow"];
        _backImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToMainVC)];
        [_backImageView addGestureRecognizer:tap];
    }
    return _backImageView;
}


-(UIImageView *)setImageView
{
    if (!_setImageView) {
        _setImageView = [[UIImageView alloc] init];
        _setImageView.image = [UIImage imageNamed:@"set_icon"];
        _setImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToSetVC)];
        [_setImageView addGestureRecognizer:tap];
    }
    return _setImageView;
}

-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        NSString *imageString = [[NSUserDefaults standardUserDefaults] objectForKey:PersonInformation];
        if (imageString) {
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:imageString]];
        } else {
            _headImageView.image = [UIImage imageNamed:@"personImageHeader"];
        }
//        _headImageView.image = [UIImage imageNamed:@"personImageHeader"];
        _headImageView.layer.cornerRadius = 85/2;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = TextLabelFont;
        _nameLabel.textColor = [UIColor whiteColor];
        NSString *nameString = [[NSUserDefaults standardUserDefaults] objectForKey:PersonName];
        if (nameString || [nameString isEqualToString:@"Unauthorized"]) {
            _nameLabel.text = nameString;
        } else {
            _nameLabel.text = @"锦向";
        }
    }
    return _nameLabel;
}

-(void)backToMainVC{
    if (self.backToMainVcBlock) {
        self.backToMainVcBlock();
    }
}

-(void)goToSetVC{
    if (self.gotobackVcBlock) {
        self.gotobackVcBlock();
    }
}

//重写此方法 为了 让左上角的 选择按钮 更加 好 点击
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect rect = CGRectMake(0, 0, 80, 80);
    CGPoint point = [[touches anyObject]locationInView:self];
    if (CGRectContainsPoint(rect, point)) {
        [self backToMainVC];
        return;
    }
    //如果不调用super方法，tableView的代理方法不会响应
    [super touchesBegan:touches withEvent:event];
}




@end
