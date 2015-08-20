

//
//  SingleProductFooterTagView.m
//  HongDian
//
//  Created by 姜通 on 15/7/29.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "SingleProductFooterTagView.h"
#import <Masonry/Masonry.h>
#import "UIColor+Utils.h"
#import "Config.h"

@implementation SingleProductFooterTagView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.ItemsArray = @[@"Python", @"Javascript",@"A"] ;
        [self addSubview: self.detailLable];
        [self setupTagView];

    }
    return self;
}

- (void)setupTagView
{
    self.tagView = ({
        SKTagView *view = [SKTagView new];
        view.backgroundColor = UIColor.whiteColor;
        view.padding = UIEdgeInsetsMake(5, 5, 5, 5);
        view.insets = 10 ;
        view.lineSpace = 10;
        view;
    });
    [self addSubview:self.tagView];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = self;
        make.top.equalTo(self.detailLable.mas_bottom).offset(0);
        make.leading.equalTo(superView.mas_leading).with.offset(0);
        make.trailing.equalTo(superView.mas_trailing);
    }];
    
    //Add Tags
    [self.ItemsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         SKTag *tag = [SKTag tagWithText:obj];
         tag.textColor = [UIColor lightGrayColor];
         tag.fontSize = 15;
         tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
         tag.bgColor = [UIColor whiteColor];
         tag.borderWidth = 1;
         tag.borderColor = ThemeViewColor;
         [self.tagView addTag:tag];
     }];
}

-(UILabel *)detailLable
{
    if (!_detailLable) {
        _detailLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 40)];
        _detailLable.font = [UIFont fontWithName:nil size:16];
        _detailLable.textColor = [UIColor blackColor];
        _detailLable.textAlignment = NSTextAlignmentLeft;
        _detailLable.backgroundColor = [UIColor lightGrayColor];
        _detailLable.numberOfLines = 0;
        _detailLable.text = @"标签";
    }
    return _detailLable;
}


@end
