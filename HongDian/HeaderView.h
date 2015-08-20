//
//  HeaderView.h
//  HongDian
//
//  Created by 姜通 on 15/8/11.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapTheButtonBlock)(NSInteger tag,UIButton *btn);

@interface HeaderView : UIView

@property (nonatomic, retain) UIButton *onebutton;
@property (nonatomic, retain) UIButton *twoButton;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UILabel *label2;
@property (nonatomic, retain) UILabel *Ylabel;

@property (nonatomic, copy) TapTheButtonBlock tapTheButtonBlock;
@property (nonatomic, retain) NSArray *titleArray;

- (void)selectTab:(NSInteger)tag;
//- (void)setSelected:(BOOL)selected;


-(instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)titleArray;

@end
