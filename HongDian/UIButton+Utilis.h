//
//  UIButton+Utilis.h
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Utilis)

+(UIButton *)buttonWithTitleString:(NSString *)title;


+(UIButton *)borderbuttonWithTitleString:(NSString *)title;


+(UIButton *)borderbuttonWithTitleString:(NSString *)title andWithColor:(UIColor *)color;
-(instancetype)initWithFrame:(CGRect)frame andString:(NSString *)number andNameString:(NSString *)nameString;

-(instancetype)initWithFrame:(CGRect)frame andNumbleString:(NSString *)number andNameString:(NSString *)nameString;


@end
