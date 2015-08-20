


//
//  TitleCollectionViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "TitleCollectionViewCell.h"
#import "Config.h"

@implementation TitleCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(0, 0, 84, 44);
        [self.button setTitleColor:CancleNomalColer forState:UIControlStateNormal];
        [self.button setTitleColor:ButtonColor forState:UIControlStateSelected];
        self.button.titleLabel.font = TextLabelFont;
        [self.button addTarget:self action:@selector(SelectTheTitle:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button];
    }
    return self;
}

-(void)SelectTheTitle:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.tapBlock) {
        self.tapBlock(btn,self.model);
    }
}

-(TitleModel *)getModel{
    return self.model;
}

-(void)setModel:(TitleModel *)model
{
    [self.button setTitle:model.name forState:UIControlStateNormal];
//    self.label.text = model.name;
}

@end
