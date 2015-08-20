
//
//  SelectTableViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "SelectTableViewCell.h"
#import "Config.h"
@implementation SelectTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *peopleView = [[UIView alloc] init];
        peopleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        peopleView.layer.borderWidth = 0.5;
        [self addSubview:peopleView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = TextLabelFont;
        [peopleView addSubview:self.nameLabel];
        
        self.phoneLabel = [[UILabel alloc] init];
        self.phoneLabel.font = LittleTextLabelFont;
        [peopleView addSubview:self.phoneLabel];
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.font = LittleTextLabelFont;
        self.addressLabel.numberOfLines = 0;
        [peopleView addSubview:self.addressLabel];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setImage:[UIImage imageNamed:@"unselectImage"] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"selectedImage"] forState:UIControlStateSelected];
        [self.button addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
        [peopleView addSubview:self.button];
        
        WS(weakSelf);

        [peopleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
        }];
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(peopleView.mas_centerY);
            make.left.equalTo(peopleView.mas_left).offset(15);
            make.width.equalTo(@35);
            make.height.equalTo(@35);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(peopleView.mas_left).offset(60);
            make.top.equalTo(peopleView.mas_top).offset(15);
        }];
        
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(peopleView.mas_left).offset(60);
            make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
        }];
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(peopleView.mas_left).offset(60);
            make.top.equalTo(self.phoneLabel.mas_bottom).offset(5);
            make.right.equalTo(peopleView.mas_right).offset(-100);
        }];
    }
    return  self;
}

-(void)setAddressModel:(AddressModel *)addressModel
{
    self.addressLabel.text = addressModel.address;
    self.nameLabel.text = addressModel.shippingToName;
    self.phoneLabel.text = addressModel.shippingToPhone;
}


-(void)selectAddress:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.selectAddressBlock) {
        self.selectAddressBlock(btn);
    }
}


@end
