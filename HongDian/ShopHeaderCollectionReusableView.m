

//
//  ShopHeaderCollectionReusableView.m
//  HongDian
//
//  Created by 姜通 on 15/8/11.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopHeaderCollectionReusableView.h"
#import "ResetButton.h"
#import <Masonry/Masonry.h>
#import "Config.h"

@implementation ShopHeaderCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 327)];
        [self addSubview:headView];
        headView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        headView.layer.borderWidth = 0.5;
        
        UILabel *label = [[UILabel alloc] init];
        label.text =@"美物频道推荐";
        label.font = [UIFont fontWithName:UserFont size:13];
        [headView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headView.mas_centerX);
            make.top.equalTo(headView.mas_top).offset(23);
        }];
        
        UILabel *labelone = [[UILabel alloc] init];
        labelone.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:labelone];
        
        UILabel *labeltwo = [[UILabel alloc] init];
        labeltwo.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:labeltwo];
        
        UILabel *labelthree = [[UILabel alloc] init];
        labelthree.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:labelthree];
        
        UILabel *labelfour = [[UILabel alloc] init];
        labelfour.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:labelfour];
        
        
        ResetButton *jobButton = [[ResetButton alloc] initWithFrame:CGRectMake(0, 0, 53, 65) WithImageString:@"jodFire" AndTitle:@"工作狂人"];
        
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headView.frame.size.width / 2, headView.frame.size.height / 2)];
        [leftview addSubview:jobButton];
        [headView addSubview:leftview];
        
        ResetButton *sexButton = [[ResetButton alloc] initWithFrame:CGRectMake(0, 0, 53, 65) WithImageString:@"sex" AndTitle:@"性感前台"];
        [leftview addSubview:sexButton];
        
        ResetButton *jobandLoveButton = [[ResetButton alloc] initWithFrame:CGRectMake(0, 0, 53, 65) WithImageString:@"jobandlove" AndTitle:@"工作与爱 缺一不可"];
        [leftview addSubview:jobandLoveButton];
        
        ResetButton *newGoodsButton = [[ResetButton alloc] initWithFrame:CGRectMake(0, 0, 53, 65) WithImageString:@"newgoods" AndTitle:@"新品抢先看"];
        [self addSubview:newGoodsButton];

        UIView *righttview = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, 0, headView.frame.size.width / 2, headView.frame.size.height / 2)];
        [righttview addSubview:sexButton];
        [righttview addSubview:newGoodsButton];
        [headView addSubview:righttview];
        
        [jobButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@53);
            make.width.equalTo(@65);
            make.centerX.equalTo(leftview.mas_centerX);
            make.top.equalTo(headView.mas_top).offset(80);
        }];
        
        
        [jobandLoveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@53);
            make.width.equalTo(@65);
            make.centerX.equalTo(leftview.mas_centerX);
            make.top.equalTo(headView.mas_top).offset(184);
        }];
        
        [sexButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@53);
            make.width.equalTo(@65);
            make.centerX.equalTo(righttview.mas_centerX);
            make.top.equalTo(headView.mas_top).offset(80);
        }];
        
        [newGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@53);
            make.width.equalTo(@65);
            make.centerX.equalTo(righttview.mas_centerX);
            make.top.equalTo(headView.mas_top).offset(184);
        }];

        [labelone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.equalTo(@12);
            make.right.equalTo(@-12);
            make.top.equalTo(headView.mas_top).offset(162);
        }];

        [labeltwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.equalTo(@12);
            make.right.equalTo(@-12);
            make.top.equalTo(headView.mas_top).offset(264);
        }];
        
        
        [labelthree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headView.mas_centerX);
            make.width.equalTo(@0.5);
            make.height.equalTo(@60);
            make.top.equalTo(headView.mas_top).offset(82);
        }];
        
        [labelfour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headView.mas_centerX);
            make.width.equalTo(@0.5);
            make.height.equalTo(@60);
            make.top.equalTo(headView.mas_top).offset(185);
        }];
        
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"查看所有频道" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:UserFont size:13];
        [headView addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(lookAllTypes) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headView.mas_centerX);
            make.bottom.equalTo(headView.mas_bottom).offset(-18);
        }];
        
        
        UILabel *newLabel = [[UILabel alloc] init];
        [self addSubview:newLabel];
        newLabel.backgroundColor = [UIColor lightGrayColor];
        
        [newLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(headView.mas_bottom).offset(10);
        }];
        
        
        UILabel *produceLabel = [[UILabel alloc] init];
        [self addSubview:produceLabel];
        produceLabel.text = @"本周推荐美物";
        produceLabel.font = [UIFont fontWithName:UserFont size:13];
        [produceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headView.mas_centerX);
            make.top.equalTo(newLabel.mas_bottom).offset(23);
        }];
    }
    return self;
}

-(void)lookAllTypes{

}

@end
