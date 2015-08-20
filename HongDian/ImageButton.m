//
//  ImageButton.m
//  HongDian
//
//  Created by Dave on 15/3/23.
//  Copyright (c) 2015年 HONG DIAN. All rights reserved.
//

#import "ImageButton.h"
#import <Masonry/Masonry.h>
#import "Config.h"
@interface ImageButton ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *title;

@end


@implementation ImageButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        _title.userInteractionEnabled = YES;
        
        [self addSubview:self.imageView];
        [self addSubview:self.title];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title withFontSize:(CGFloat)fontSize andColor:(UIColor *)color
{
//    self.imageView.image = image;
//    [self.imageView sizeToFit];
    
    self.title.text = title;
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.font = [UIFont systemFontOfSize:fontSize];
    self.title.textColor = color;
    
    WS(view);
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(view.mas_centerX);
//    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.imageView.mas_bottom).offset(2);
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY);
//        make.bottom.equalTo(view.mas_bottom).offset(-6);
    }];
}


- (void)addTarget:(id)target andAction:(SEL)selector
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    
    [self addGestureRecognizer:tapGesture];
}

@end
